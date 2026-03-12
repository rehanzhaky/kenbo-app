import SwiftUI
import Combine

class StreakViewModel: ObservableObject {
    @Published var currentStreak: Int = 7
    @Published var showOverlay: Bool = false
    
    func dismissOverlay() {
        withAnimation {
            showOverlay = false
        }
    }
    
    func showStreakOverlay() {
        withAnimation {
            showOverlay = true
        }
    }
}
