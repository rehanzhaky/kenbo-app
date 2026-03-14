import SwiftUI
import Combine

// MARK: - Task Steps
enum EyeTaskStep {
    case announcement
    case tracking
    case result
    case earnXP
}

class EyeTaskViewModel: ObservableObject {

    // MARK: - Navigation
    @Published var currentStep: EyeTaskStep = .announcement
    @Published var isDismissed: Bool = false

    // MARK: - Tracking state
    @Published var progress: Double = 0.0          // 0.0 → 1.0
    @Published var blinksCount: Int = 0

    let blinkGoal: Int

    private var trackingCancellable: AnyCancellable?
    private var previousBlinkState = false
    let onComplete: (Int) -> Void
    
    var xpEarned: Int { 100 }

    init(blinkGoal: Int = 10, onComplete: @escaping (Int) -> Void) {
        self.blinkGoal = blinkGoal
        self.onComplete = onComplete
    }

    // MARK: - Step Navigation

    func beginTracking() {
        currentStep = .tracking
        blinksCount = 0
        progress = 0.0
        previousBlinkState = false
        
        ARFaceTrackingManager.shared.startTracking()
        startBlinkTracking()
    }

    func finishTask() {
        cancelTracking()
        currentStep = .earnXP
    }

    // MARK: - Tracking Logic

    private func startBlinkTracking() {
        trackingCancellable?.cancel()
        trackingCancellable = ARFaceTrackingManager.shared.$isBothBlinking
            .receive(on: RunLoop.main)
            .sink { [weak self] isBlinking in
                guard let self = self else { return }
                
                // Count a blink when state transitions from open to closed
                if isBlinking && !self.previousBlinkState {
                    self.blinksCount += 1
                    self.progress = min(Double(self.blinksCount) / Double(self.blinkGoal), 1.0)
                    
                    if self.blinksCount >= self.blinkGoal {
                        self.cancelTracking()
                        withAnimation(.easeInOut(duration: 0.5)) {
                            self.currentStep = .result
                        }
                    }
                }
                self.previousBlinkState = isBlinking
            }
    }

    func cancelTracking() {
        trackingCancellable?.cancel()
        ARFaceTrackingManager.shared.stopTracking()
    }

    // MARK: - Helpers

    var progressLabel: String {
        return "\(blinksCount)/\(blinkGoal) Kedipan"
    }
}
