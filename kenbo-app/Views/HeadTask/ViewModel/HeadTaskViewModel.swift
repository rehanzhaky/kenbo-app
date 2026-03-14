import SwiftUI
import Combine

enum HeadTaskStep {
    case announcement
    case tracking
    case result
    case earnXP
}

class HeadTaskViewModel: ObservableObject {
    @Published var currentStep: HeadTaskStep = .announcement
    @Published var isDismissed: Bool = false
    
    // Tracking state
    @Published var progress: Double = 0.0
    @Published var turnsCount: Int = 0
    let turnGoal: Int
    
    private var trackingCancellable: AnyCancellable?
    private var lastTurnDirection: Int = 0 // 1 = left, -1 = right, 0 = center
    
    let onComplete: (Int) -> Void
    var xpEarned: Int { 150 }
    
    var progressLabel: String {
        return "\(turnsCount)/\(turnGoal) Putaran"
    }
    
    init(turnGoal: Int = 10, onComplete: @escaping (Int) -> Void) {
        self.turnGoal = turnGoal
        self.onComplete = onComplete
    }
    
    func beginTracking() {
        currentStep = .tracking
        turnsCount = 0
        progress = 0.0
        lastTurnDirection = 0
        
        ARFaceTrackingManager.shared.startTracking()
        startTurnTracking()
    }
    
    func finishTask() {
        cancelTracking()
        currentStep = .earnXP
    }
    
    private func startTurnTracking() {
        trackingCancellable?.cancel()
        trackingCancellable = ARFaceTrackingManager.shared.$headYaw
            .receive(on: RunLoop.main)
            .sink { [weak self] yaw in
                guard let self = self else { return }
                
                // yaw > 0.4 usually means looking left, < -0.4 means looking right
                let threshold: Float = 0.4
                let resetThreshold: Float = 0.15
                
                if yaw > threshold && self.lastTurnDirection != 1 {
                    self.lastTurnDirection = 1
                    self.turnsCount += 1
                    self.updateProgress()
                } else if yaw < -threshold && self.lastTurnDirection != -1 {
                    self.lastTurnDirection = -1
                    self.turnsCount += 1
                    self.updateProgress()
                } else if abs(yaw) < resetThreshold {
                    // looking center
                    self.lastTurnDirection = 0
                }
            }
    }
    
    private func updateProgress() {
        progress = min(Double(turnsCount) / Double(turnGoal), 1.0)
        if turnsCount >= turnGoal {
            cancelTracking()
            withAnimation(.easeInOut(duration: 0.5)) {
                currentStep = .result
            }
        }
    }
    
    func cancelTracking() {
        trackingCancellable?.cancel()
        ARFaceTrackingManager.shared.stopTracking()
    }
}
