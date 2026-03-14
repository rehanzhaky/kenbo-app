import Foundation
import Combine

/// Typed wrapper around UserDefaults for all user-persisted data.
final class UserPreferences: ObservableObject {
    
    static let shared = UserPreferences()
    private init() {}
    
    private let defaults = UserDefaults.standard
    
    // MARK: - Keys
    private enum Keys {
        // Onboarding
        static let hasCompletedOnboarding = "hasCompletedOnboarding"
        static let userName               = "userName"
        static let selectedGender         = "selectedGender"
        static let selectedSession        = "selectedSession"
        // Game State
        static let currentXP              = "currentXP"
        static let level                  = "level"
        static let streak                 = "streak"
        static let lastOpenedDate         = "lastOpenedDate"
        // Stats
        static let health                 = "statHealth"
        static let stamina                = "statStamina"
        static let power                  = "statPower"
        // Daily Tasks
        static let completedTaskIDs       = "completedTaskIDs"
        static let lastTaskResetDate      = "lastTaskResetDate"
        // Title Badge
        static let titleBadge             = "titleBadge"
    }
    
    // MARK: - Onboarding
    
    var hasCompletedOnboarding: Bool {
        get { defaults.bool(forKey: Keys.hasCompletedOnboarding) }
        set { defaults.set(newValue, forKey: Keys.hasCompletedOnboarding) }
    }
    
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
    
    // MARK: - Game State (XP & Level)
    // XP table: level N requires N * 100 XP to advance (LV1→LV2 = 100, LV2→LV3 = 200, etc.)
    
    var currentXP: Int {
        get { defaults.integer(forKey: Keys.currentXP) }          // default 0
        set { defaults.set(newValue, forKey: Keys.currentXP) }
    }
    
    var level: Int {
        get {
            let v = defaults.integer(forKey: Keys.level)
            return v == 0 ? 1 : v                                  // first launch = LV 1
        }
        set { defaults.set(newValue, forKey: Keys.level) }
    }
    
    /// XP needed to reach the NEXT level from the current one.
    var xpForNextLevel: Int { level * 100 }
    
    @Published var showLevelUpAlert: Bool = false
    @Published var newlyReachedLevel: Int = 1
    
    /// Add XP and resolve level-ups automatically.
    func addXP(_ amount: Int) {
        var xp    = currentXP + amount
        var lv    = level
        let initialLv = level
        
        while xp >= lv * 100 {
            xp -= lv * 100
            lv  += 1
        }
        currentXP = xp
        level     = lv
        
        if lv > initialLv {
            newlyReachedLevel = lv
            showLevelUpAlert = true
        }
    }
    
    // MARK: - Streak (24-hour cycle)
    
    var streak: Int {
        get { defaults.integer(forKey: Keys.streak) }  // 0 = never started (pre-onboarding)
        set { defaults.set(newValue, forKey: Keys.streak) }
    }
    
    private var lastOpenedDate: Date? {
        get { defaults.object(forKey: Keys.lastOpenedDate) as? Date }
        set { defaults.set(newValue, forKey: Keys.lastOpenedDate) }
    }
    
    /// Call on every app open (after onboarding is complete).
    /// Returns whether the streak was incremented.
    @discardableResult
    func recordAppOpen() -> Bool {
        // Streak only counts after user has completed setup
        guard hasCompletedOnboarding else { return false }

        let now      = Date()
        let calendar = Calendar.current
        
        defer { lastOpenedDate = now }

        guard let last = lastOpenedDate else { 
            // First time opening after onboarding
            streak = 1
            return true
        }

        // Compare midnight to midnight accurately
        let startOfLast = calendar.startOfDay(for: last)
        let startOfNow = calendar.startOfDay(for: now)
        let daysSince = calendar.dateComponents([.day], from: startOfLast, to: startOfNow).day ?? 0

        switch daysSince {
        case 1:
            streak += 1       // opened exactly next day ✅
            return true
        case let d where d > 1:
            streak = 1        // missed a day – reset to 1
            return false
        default:
            return false      // same day – no change
        }
    }
    
    // MARK: - Character Stats (max is always 300)
    
    static let statMax: Int = 300
    
    var health: Int {
        get {
            let v = defaults.integer(forKey: Keys.health)
            return v == 0 ? UserPreferences.statMax : v
        }
        set { defaults.set(min(UserPreferences.statMax, max(0, newValue)), forKey: Keys.health) }
    }
    
    var stamina: Int {
        get {
            let v = defaults.integer(forKey: Keys.stamina)
            return v == 0 ? UserPreferences.statMax : v
        }
        set { defaults.set(min(UserPreferences.statMax, max(0, newValue)), forKey: Keys.stamina) }
    }
    
    var power: Int {
        get {
            let v = defaults.integer(forKey: Keys.power)
            return v == 0 ? UserPreferences.statMax : v
        }
        set { defaults.set(min(UserPreferences.statMax, max(0, newValue)), forKey: Keys.power) }
    }
    
    /// Decay stats by `amount` when no tasks were completed on a given day.
    /// Each missed day reduces every stat by 20 points.
    func applyDecay(missedDays: Int) {
        guard missedDays > 0 else { return }
        let decay = 20 * missedDays
        health  = health  - decay
        stamina = stamina - decay
        power   = power   - decay
    }
    
    // MARK: - Daily Task Completion
    
    /// IDs of tasks completed today.
    var completedTaskIDs: [String] {
        get { defaults.stringArray(forKey: "completedTaskIDs") ?? [] }
        set { defaults.set(newValue, forKey: "completedTaskIDs") }
    }
    
    private var lastTaskResetDate: Date? {
        get { defaults.object(forKey: "lastTaskResetDate") as? Date }
        set { defaults.set(newValue, forKey: "lastTaskResetDate") }
    }
    
    /// Resets completed task list if a new calendar day has started.
    func resetDailyTasksIfNeeded() {
        let calendar = Calendar.current
        let now      = Date()
        if let last = lastTaskResetDate,
           !calendar.isDate(last, inSameDayAs: now) {
            completedTaskIDs  = []
        }
        lastTaskResetDate = now
    }
    
    func markTaskCompleted(id: String) {
        var ids = completedTaskIDs
        if !ids.contains(id) {
            ids.append(id)
            completedTaskIDs = ids
        }
    }
    
    // MARK: - Title Badge
    
    /// The user's earned title. nil = not yet unlocked.
    @Published var titleBadge: String? = nil
    
    func loadTitleBadge() {
        titleBadge = defaults.string(forKey: "titleBadge")
    }
    
    func unlockTitleBadge(_ title: String) {
        if titleBadge == nil {
            titleBadge = title
            defaults.set(title, forKey: "titleBadge")
        }
    }
    
    func equipTitleBadge(_ title: String) {
        titleBadge = title
        defaults.set(title, forKey: "titleBadge")
    }
    
    // MARK: - Reward Collection (Phase 5)
    
    @Published var unlockedMotivationCount: Int = 1
    @Published var unlockedStoryCount: Int = 1
    
    func loadRewardCounts() {
        unlockedMotivationCount = max(1, defaults.integer(forKey: "unlockedMotivationCount"))
        unlockedStoryCount = max(1, defaults.integer(forKey: "unlockedStoryCount"))
    }
    
    func unlockNextMotivation() {
        unlockedMotivationCount += 1
        defaults.set(unlockedMotivationCount, forKey: "unlockedMotivationCount")
    }
    
    func unlockNextStory() {
        unlockedStoryCount += 1
        defaults.set(unlockedStoryCount, forKey: "unlockedStoryCount")
    }
    
    // MARK: - Reset (for testing / logout)
    
    func resetAll() {
        defaults.dictionaryRepresentation().keys.forEach { defaults.removeObject(forKey: $0) }
        titleBadge = nil
        unlockedMotivationCount = 1
        unlockedStoryCount = 1
    }
}
