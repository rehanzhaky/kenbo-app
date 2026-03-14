import Foundation
import SwiftUI
import Combine

// MARK: - Models
enum RewardDetailType: String, Identifiable {
    case motivation
    case story
    case title
    
    var id: String { self.rawValue }
}

struct RewardItem: Identifiable {
    let id = UUID()
    let type: RewardDetailType
    let title: String
    let icon: String
    let style: RewardCardStyle
    let buttonTitle: String
    let isLocked: Bool
    let unlockMessage: String?
}

class RewardViewModel: ObservableObject {
    @Published var userProfile: UserProfile
    @Published var rewardDescription: String
    @Published var rewards: [RewardItem] = []
    @Published var activeDetail: RewardDetailType?
    
    @Published var motivationContent: String = "Loading..."
    @Published var storyContent: String = "Loading..."
    
    private let prefs = UserPreferences.shared
    private let ai = AIService.shared
    
    init(userName: String, gender: String) {
        // Fetch real profile data
        self.userProfile = UserProfile(
            name: userName,
            gender: gender,
            level: prefs.level,
            streak: prefs.streak,
            currentXP: prefs.currentXP,
            maxXP: prefs.xpForNextLevel,
            completedTasks: 0, // Not needed deep for reward page
            totalTasks: 0,
            titleBadge: prefs.titleBadge
        )
        
        self.rewardDescription = "Koleksi pencapaian dan cerita seru dari petualanganmu di Kenbo. Teruslah bergerak untuk membuka lebih banyak!"
        self.refreshRewards()
        
        // Initial AI load
        Task {
            await loadAIContent()
        }
    }
    
    @MainActor
    func loadAIContent() async {
        // Parallel fetch for speed
        async let motivation = ai.generateContent(prompt: ai.generateMotivationPrompt())
        async let story = ai.generateContent(prompt: ai.generateStoryPrompt())
        
        self.motivationContent = await motivation ?? "Semangat terus ya xixi!"
        self.storyContent = await story ?? "Sekali ksatria tetap ksatria, walau lupa angkat besi xixi."
    }
    
    func refreshRewards() {
        let currentXP = prefs.currentXP
        let currentStreak = prefs.streak
        
        let styles: [RewardCardStyle] = [.orange, .green, .red, .blue, .purple, .teal]
        
        // Always include the core ones first to ensure they are visible
        var newRewards: [RewardItem] = [
            RewardItem(
                type: .motivation,
                title: "Motivasi Humor Academy #\(prefs.unlockedMotivationCount)",
                icon: "star.fill",
                style: .orange,
                buttonTitle: "Lihat Motivasi",
                isLocked: false,
                unlockMessage: nil
            ),
            RewardItem(
                type: .story,
                title: "Cerita Absurd Academy #\(prefs.unlockedStoryCount)",
                icon: "book.fill",
                style: .blue,
                buttonTitle: currentStreak >= 3 ? "Buka Cerita" : "Butuh Streak 3 Hari",
                isLocked: currentStreak < 3,
                unlockMessage: "Kumpulkan\n\(3 - currentStreak) Streak lagi yuk!"
            ),
            RewardItem(
                type: .title,
                title: "Gelar Ksatria Bugar",
                icon: "medal.fill",
                style: .green,
                buttonTitle: prefs.titleBadge != nil ? "Lihat Gelar" : "Selesaikan Semua Quest",
                isLocked: prefs.titleBadge == nil,
                unlockMessage: "Kumpulkan\nXP lebih banyak lagi yuk!"
            )
        ]
        
        // Generate additional random items to fill out the list
        for i in 1...7 {
            let typeOptions: [RewardDetailType] = [.motivation, .story, .title]
            let randomType = typeOptions.randomElement()!
            let randomStyle = styles.randomElement()!
            
            // Randomly lock some items for visual variety
            let isRandomLocked = Bool.random()
            
            let itemTitle: String
            let itemIcon: String
            switch randomType {
            case .motivation: itemTitle = "Motivasi Humor Extra #\(i)"; itemIcon = "star.fill"
            case .story: itemTitle = "Cerita Sampingan #\(i)"; itemIcon = "book.fill"
            case .title: itemTitle = "Gelar Misteri #\(i)"; itemIcon = "medal.fill"
            }
            
            newRewards.append(
                RewardItem(
                    type: randomType,
                    title: itemTitle,
                    icon: itemIcon,
                    style: randomStyle,
                    buttonTitle: isRandomLocked ? "Terkunci" : "Lihat",
                    isLocked: isRandomLocked,
                    unlockMessage: "Kumpulkan\n\(Int.random(in: 10...50) * 10) XP lagi yuk!"
                )
            )
        }
        
        // Sort: Unlocked items first, then Locked items
        newRewards.sort { !$0.isLocked && $1.isLocked }
        
        self.rewards = newRewards
    }
}
