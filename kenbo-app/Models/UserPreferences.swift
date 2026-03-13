import Foundation

/// Typed wrapper around UserDefaults for all user-persisted onboarding data.
final class UserPreferences {
    
    static let shared = UserPreferences()
    private init() {}
    
    private let defaults = UserDefaults.standard
    
    // MARK: - Keys
    private enum Keys {
        static let hasCompletedOnboarding = "hasCompletedOnboarding"
        static let userName               = "userName"
        static let selectedGender         = "selectedGender"
        static let selectedSession        = "selectedSession"
    }
    
    // MARK: - Onboarding
    
    var hasCompletedOnboarding: Bool {
        get { defaults.bool(forKey: Keys.hasCompletedOnboarding) }
        set { defaults.set(newValue, forKey: Keys.hasCompletedOnboarding) }
    }
    
    // MARK: - User Info
    
    var userName: String {
        get { defaults.string(forKey: Keys.userName) ?? "" }
        set { defaults.set(newValue, forKey: Keys.userName) }
    }
    
    var selectedGender: String {
        get { defaults.string(forKey: Keys.selectedGender) ?? "Lelaki" }
        set { defaults.set(newValue, forKey: Keys.selectedGender) }
    }
    
    var selectedSession: String {
        get { defaults.string(forKey: Keys.selectedSession) ?? "" }
        set { defaults.set(newValue, forKey: Keys.selectedSession) }
    }
    
    // MARK: - Reset (for testing / logout)
    
    func resetOnboarding() {
        defaults.removeObject(forKey: Keys.hasCompletedOnboarding)
        defaults.removeObject(forKey: Keys.userName)
        defaults.removeObject(forKey: Keys.selectedGender)
        defaults.removeObject(forKey: Keys.selectedSession)
    }
}
