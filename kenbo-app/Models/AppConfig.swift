import Foundation

struct AppConfig {
    /// Set to `true` for development/testing to bypass time locks and see all features.
    /// Set to `false` for production releases.
    static let isDevelopment = true
    
    /// Set GEMINI_API_KEY in Info.plist (via .xcconfig or build settings).
    static let geminiApiKey = Bundle.main.object(forInfoDictionaryKey: "GEMINI_API_KEY") as? String ?? ""
}
