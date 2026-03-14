import Foundation
import SwiftUI
import Combine

// MARK: - Models
struct UserProfile {
    let name: String
    let gender: String // "Lelaki" or "Perempuan"
    let level: Int
    let streak: Int
    let currentXP: Int
    let maxXP: Int
    let completedTasks: Int
    let totalTasks: Int
    let titleBadge: String?    // nil = not yet earned
}

struct CharacterStats {
    let healthCurrent: Int
    let healthMax: Int
    let powerCurrent: Int
    let powerMax: Int
    let staminaCurrent: Int
    let staminaMax: Int
    let imageName: String
}

struct QuestTask: Identifiable {
    let id: String                   // stable string ID for persistence
    let title: String
    let icon: String
    let iconBackgroundColor: Color
    let cardBackgroundColor: Color
    let totalProgress: Int
    let unit: String
    let shadowColor: Color
    /// XP awarded when this task session is completed
    let xpReward: Int
    /// How many points each stat recovers when done
    let statRestore: Int
    
    /// A closure that returns the hour (0-23) this task unlocks, based on the user's session.
    let unlockHour: (String) -> Int
    
    var currentProgress: Int = 0    // computed from UserPreferences
}

enum TaskType: String, Identifiable {
    case eye, head, hand, walk
    var id: String { self.rawValue }
}

class HomeViewModel: ObservableObject {
    @Published var userProfile: UserProfile
    @Published var characterStats: CharacterStats
    @Published var questDescription: String
    @Published var questTasks: [QuestTask]
    @Published var activeTask: TaskType?

    private let prefs = UserPreferences.shared
    private let statMax = UserPreferences.statMax

    // MARK: - Quest catalogue (static, progress injected on init)
    private static let catalogue: [QuestTask] = [
        QuestTask(
            id: "quest_walk",
            title: "Regangkan kakimu dan jalan santai sebentar.",
            icon: "system:figure.walk",
            iconBackgroundColor: Color(hex: "096A88"),
            cardBackgroundColor: Color(hex: "0A88AE"),
            totalProgress: 25,
            unit: "Steps",
            shadowColor: Color(hex: "075F7A"),
            xpReward: 30,
            statRestore: 20,
            // Morning: 08:00, Afternoon: 13:00
            unlockHour: { session in session == "Morning" ? 8 : 13 }
        ),
        QuestTask(
            id: "quest_eye",
            title: "Lakukan peregangan mata agar tetap segar dan fokus.",
            icon: "system:eye.fill",
            iconBackgroundColor: Color(hex: "D14747"),
            cardBackgroundColor: Color(hex: "FA6F71"),
            totalProgress: 10,
            unit: "Detik",
            shadowColor: Color(hex: "C44C4C"),
            xpReward: 30,
            statRestore: 20,
            // Morning: 09:00, Afternoon: 14:00
            unlockHour: { session in session == "Morning" ? 9 : 14 }
        ),
        QuestTask(
            id: "quest_head",
            title: "Putar leher perlahan agar otot tidak tegang.",
            icon: "system:person.bust",
            iconBackgroundColor: Color(hex: "5659BE"),
            cardBackgroundColor: Color(hex: "6A6DDE"),
            totalProgress: 10,
            unit: "Gerakan",
            shadowColor: Color(hex: "4648A3"),
            xpReward: 30,
            statRestore: 20,
            // Morning: 10:00, Afternoon: 15:00
            unlockHour: { session in session == "Morning" ? 10 : 15 }
        ),
        QuestTask(
            id: "quest_hand",
            title: "Gerakkan pergelangan tanganmu agar rileks dan bebas pegal.",
            icon: "system:hand.raised.fill",
            iconBackgroundColor: Color(hex: "E18E3E"),
            cardBackgroundColor: Color(hex: "FCB364"),
            totalProgress: 10,
            unit: "Gerakan",
            shadowColor: Color(hex: "C98236"),
            xpReward: 30,
            statRestore: 20,
            // Morning: 11:00, Afternoon: 16:00
            unlockHour: { session in session == "Morning" ? 11 : 16 }
        )
    ]

    init(userName: String, gender: String) {
        // 1. Record app open for streak + decay logic
        let prefs    = UserPreferences.shared
        let calendar = Calendar.current
        let now      = Date()

        // Compute missed days for stat decay (before recordAppOpen updates lastOpenedDate)
        var missedDays = 0
        if let last = UserDefaults.standard.object(forKey: "lastOpenedDate") as? Date {
            let days = calendar.dateComponents([.day], from: last, to: now).day ?? 0
            if days > 1 { missedDays = days - 1 }
        }

        prefs.recordAppOpen()
        prefs.resetDailyTasksIfNeeded()

        if missedDays > 0 {
            prefs.applyDecay(missedDays: missedDays)
        }

        // 2. Build quest tasks with today's progress injected, and filter by current time
        let completedIDs = prefs.completedTaskIDs
        let currentHour = calendar.component(.hour, from: now)
        let session = prefs.selectedSession

        // DEV MODE: Unlock all tasks for testing instead of using QuestScheduler
        let unlockedTasks = HomeViewModel.catalogue
        
        let tasks: [QuestTask] = unlockedTasks.map { task in
            var t = task
            let done = completedIDs.filter { $0.hasPrefix(task.id) }.count
            t.currentProgress = done > 0 ? task.totalProgress : 0
            return t
        }

        let completedCount = tasks.filter { $0.currentProgress >= $0.totalProgress }.count

        // 3. Populate published properties from UserPreferences
        self.userProfile = UserProfile(
            name: userName,
            gender: gender,
            level: prefs.level,
            streak: prefs.streak,
            currentXP: prefs.currentXP,
            maxXP: prefs.xpForNextLevel,
            completedTasks: completedCount,
            totalTasks: tasks.count,
            titleBadge: prefs.titleBadge
        )

        self.characterStats = CharacterStats(
            healthCurrent: prefs.health,
            healthMax: UserPreferences.statMax,
            powerCurrent: prefs.power,
            powerMax: UserPreferences.statMax,
            staminaCurrent: prefs.stamina,
            staminaMax: UserPreferences.statMax,
            imageName: "link_sprite"
        )

        self.questDescription = "Selesaikan quest harianmu dan jaga statistik karaktermu tetap prima agar tetap kuat setiap hari."
        self.questTasks = tasks
        
        // 4. Schedule local notifications
        QuestScheduler.shared.scheduleNotifications(for: HomeViewModel.catalogue, session: session)
    }

    // MARK: - Task Completion

    /// Call this when a user finishes one session of a quest.
    func completeTask(id: String, earnedXP: Int) {
        let sessionKey = "\(id)_\(UUID().uuidString)"  // unique per session
        prefs.markTaskCompleted(id: sessionKey)
        prefs.addXP(earnedXP)

        // Restore stats
        let restore = statRestore(for: id)
        prefs.health  = prefs.health  + restore
        prefs.stamina = prefs.stamina + restore
        prefs.power   = prefs.power   + restore

        // Refresh published state
        refreshState()
        
        // Dismiss the active task modal
        activeTask = nil
    }

    private func xpReward(for id: String) -> Int {
        HomeViewModel.catalogue.first { $0.id == id }?.xpReward ?? 20
    }

    private func statRestore(for id: String) -> Int {
        HomeViewModel.catalogue.first { $0.id == id }?.statRestore ?? 10
    }

    private func refreshState() {
        let completedIDs = prefs.completedTaskIDs
        let currentHour = Calendar.current.component(.hour, from: Date())
        let session = prefs.selectedSession
        
        // DEV MODE: Unlock all tasks for testing instead of using QuestScheduler
        let unlockedTasks = HomeViewModel.catalogue
        
        var tasks: [QuestTask] = unlockedTasks.map { task in
            var t = task
            let done = completedIDs.filter { $0.hasPrefix(task.id) }.count
            t.currentProgress = done > 0 ? task.totalProgress : 0
            return t
        }
        let completedCount = tasks.filter { $0.currentProgress >= $0.totalProgress }.count

        // Award first title badge if all quests are now completed
        let allDone = tasks.filter { $0.currentProgress >= $0.totalProgress }.count == tasks.count
        if allDone { prefs.unlockTitleBadge("Bugar") }

        userProfile = UserProfile(
            name: userProfile.name,
            gender: userProfile.gender,
            level: prefs.level,
            streak: prefs.streak,
            currentXP: prefs.currentXP,
            maxXP: prefs.xpForNextLevel,
            completedTasks: completedCount,
            totalTasks: tasks.count,
            titleBadge: prefs.titleBadge
        )
        characterStats = CharacterStats(
            healthCurrent: prefs.health,
            healthMax: UserPreferences.statMax,
            powerCurrent: prefs.power,
            powerMax: UserPreferences.statMax,
            staminaCurrent: prefs.stamina,
            staminaMax: UserPreferences.statMax,
            imageName: characterStats.imageName
        )
        questTasks = tasks
    }
}
