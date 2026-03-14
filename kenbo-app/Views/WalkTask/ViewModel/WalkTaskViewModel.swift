import SwiftUI
import CoreMotion
import Combine

enum WalkTaskStep {
    case announcement
    case tracking
    case result
    case earnXP
}

class WalkTaskViewModel: ObservableObject {
    @Published var currentStep: WalkTaskStep = .announcement
    @Published var isDismissed: Bool = false
    
    // Tracking state
    @Published var stepsTaken: Int = 0
    let stepGoal: Int = 25
    
    var progress: Double {
        return min(Double(stepsTaken) / Double(stepGoal), 1.0)
    }
    
    var xpEarned: Int {
        return stepsTaken * 10
    }
    
    let onComplete: (Int) -> Void
    private let pedometer = CMPedometer()
    private var isTracking = false
    
    init(onComplete: @escaping (Int) -> Void) {
        self.onComplete = onComplete
    }
    
    func beginTracking() {
        currentStep = .tracking
        startPedometer()
    }
    
    func finishTask() {
        stopPedometer()
        currentStep = .earnXP
    }
    
    func cancelTask() {
        stopPedometer()
        isDismissed = true
    }
    
    private func startPedometer() {
        guard CMPedometer.isStepCountingAvailable() else {
            print("Pedometer not available on this device.")
            // For simulator fallback, we could auto-complete or add a debug button
            return
        }
        
        isTracking = true
        pedometer.startUpdates(from: Date()) { [weak self] pedometerData, error in
            guard let self = self, let data = pedometerData, error == nil else {
                print("Pedometer error: \(String(describing: error))")
                return
            }
            
            DispatchQueue.main.async {
                self.stepsTaken = data.numberOfSteps.intValue
                
                if self.stepsTaken >= self.stepGoal {
                    self.completeTracking()
                }
            }
        }
    }
    
    private func stopPedometer() {
        if isTracking {
            pedometer.stopUpdates()
            isTracking = false
        }
    }
    
    private func completeTracking() {
        stopPedometer()
        withAnimation(.easeInOut(duration: 0.5)) {
            currentStep = .result
        }
    }
    
    // Fallback for Simulator testing
    func invokeDebugStep() {
        stepsTaken += 5
        if stepsTaken >= stepGoal {
            completeTracking()
        }
    }
}
