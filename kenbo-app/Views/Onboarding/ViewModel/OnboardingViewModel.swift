import SwiftUI
import Combine

class OnboardingViewModel: ObservableObject {
    
    // MARK: - Navigation
    @Published var currentPage: Int = 0
    @Published var showHome: Bool = false
    
    // MARK: - User Data (backed by UserPreferences)
    @Published var userName: String {
        didSet { UserPreferences.shared.userName = userName }
    }
    
    @Published var selectedGender: String {
        didSet { UserPreferences.shared.selectedGender = selectedGender }
    }
    
    @Published var selectedSession: String {
        didSet { UserPreferences.shared.selectedSession = selectedSession }
    }
    
    // MARK: - Init
    init() {
        // Load any previously saved values
        userName        = UserPreferences.shared.userName
        selectedGender  = UserPreferences.shared.selectedGender
        selectedSession = UserPreferences.shared.selectedSession
    }
    
    // MARK: - Navigation Helpers
    
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
    
    // MARK: - Step Actions
    
    /// Called when the user picks a session. Saves the choice and advances.
    func selectSession(_ session: String) {
        selectedSession = session           // persisted via didSet
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.navigateToNextPage()
        }
    }
    
    /// Called on the final screen. Persists everything and signals completion.
    func finishOnboarding() {
        guard !userName.isEmpty else { return }
        UserPreferences.shared.hasCompletedOnboarding = true
        withAnimation {
            showHome = true
        }
    }
}
