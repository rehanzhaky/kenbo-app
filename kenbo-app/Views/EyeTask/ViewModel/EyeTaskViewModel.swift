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
    @Published var timeRemaining: Int              // countdown seconds

    /// Total duration of one tracking session in seconds
    let totalDuration: Int

    private var timer: AnyCancellable?
    let onComplete: (Int) -> Void
    
    var xpEarned: Int { 100 }

    init(totalDuration: Int = 10, onComplete: @escaping (Int) -> Void) {
        self.totalDuration  = totalDuration
        self.timeRemaining  = totalDuration
        self.onComplete     = onComplete
    }

    // MARK: - Step Navigation

    func beginTracking() {
        currentStep = .tracking
        startTimer()
    }

    func finishTask() {
        cancelTimer()
        currentStep = .earnXP
    }

    // MARK: - Timer Logic

    private func startTimer() {
        timer?.cancel()
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self else { return }
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                    self.progress = Double(self.totalDuration - self.timeRemaining) / Double(self.totalDuration)
                } else {
                    self.timer?.cancel()
                    withAnimation(.easeInOut(duration: 0.5)) {
                        self.currentStep = .result
                    }
                }
            }
    }

    func cancelTimer() {
        timer?.cancel()
    }

    // MARK: - Helpers

    var timeLabel: String {
        let m = timeRemaining / 60
        let s = timeRemaining % 60
        return m > 0 ? "\(m) Menit \(String(format: "%02d", s)) Detik" : "\(s) Detik"
    }
}
