import SwiftUI
import Combine

class OnboardingViewModel: ObservableObject {
    @Published var currentPage: Int = 0
    @Published var userName: String = ""
    @Published var selectedSession: String = ""
    @Published var selectedGender: String = "Lelaki"
    @Published var showHome: Bool = false
    
    func navigateToNextPage() {
        withAnimation {
            currentPage += 1
        }
    }
    
    func navigateToPage(_ page: Int) {
        withAnimation {
            currentPage = page
        }
    }
    
    func selectSession(_ session: String) {
        selectedSession = session
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.navigateToNextPage()
        }
    }
    
    func finishOnboarding() {
        guard !userName.isEmpty else { return }
        withAnimation {
            showHome = true
        }
    }
}
