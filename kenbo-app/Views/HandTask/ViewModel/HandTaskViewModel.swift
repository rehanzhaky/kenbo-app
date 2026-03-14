import SwiftUI
import CoreMotion
import Combine

enum HandTaskStep {
    case announcement
    case tracking
    case result
    case earnXP
}

class HandTaskViewModel: ObservableObject {
    @Published var currentStep: HandTaskStep = .announcement
    @Published var isDismissed: Bool = false
    
    // Tracking state
    @Published var progress: Double = 0.0
    @Published var rotationCount: Int = 0
    let rotationGoal: Int
    
    private let motionManager = CMMotionManager()
    private var isTracking = false
    
    // Variables to track rotation direction changes
    private var lastRollSign: Int = 0 
    
    let onComplete: (Int) -> Void
    var xpEarned: Int { 150 }
    
    var progressLabel: String {
        return "\(rotationCount)/\(rotationGoal) Putaran"
    }
    
    init(rotationGoal: Int = 10, onComplete: @escaping (Int) -> Void) {
        self.rotationGoal = rotationGoal
        self.onComplete = onComplete
    }
    
    func beginTracking() {
        currentStep = .tracking
        startGyroscope()
    }
    
    func finishTask() {
        stopGyroscope()
        currentStep = .earnXP
    }
    
    func cancelTracking() {
        stopGyroscope()
        isDismissed = true
    }
    
    private func startGyroscope() {
        guard motionManager.isDeviceMotionAvailable else {
            print("Device motion is not available on this device.")
            return
        }
        
        motionManager.deviceMotionUpdateInterval = 0.1
        isTracking = true
        rotationCount = 0
        progress = 0.0
        lastRollSign = 0
        
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (data, error) in
            guard let self = self, let data = data, error == nil else { return }
            
            // Using roll (rotation around the longitudinal axis) to detect wrist twists
            let roll = data.attitude.roll
            let threshold: Double = 0.5 // Radians (approx 28 degrees)
            
            if roll > threshold && self.lastRollSign != 1 {
                self.lastRollSign = 1
                self.incrementRotation()
            } else if roll < -threshold && self.lastRollSign != -1 {
                self.lastRollSign = -1
                self.incrementRotation()
            } else if abs(roll) < 0.2 {
                self.lastRollSign = 0 // Reset when back to roughly neutral
            }
        }
    }
    
    private func incrementRotation() {
        rotationCount += 1
        progress = min(Double(rotationCount) / Double(rotationGoal), 1.0)
        
        if rotationCount >= rotationGoal {
            completeTracking()
        }
    }
    
    private func stopGyroscope() {
        if isTracking {
            motionManager.stopDeviceMotionUpdates()
            isTracking = false
        }
    }
    
    private func completeTracking() {
        stopGyroscope()
        withAnimation(.easeInOut(duration: 0.5)) {
            currentStep = .result
        }
    }
}
