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
    let detailContent: String
    let detailIndex: Int
}

class RewardViewModel: ObservableObject {
    @Published var userProfile: UserProfile
    @Published var rewardDescription: String
    @Published var rewards: [RewardItem] = []
    @Published var activeDetail: RewardDetailType?
    @Published var activeDetailContent: String = ""
    @Published var activeDetailIndex: Int = 0
    
    @Published var motivationItems: [String] = ["Loading..."]
    @Published var storyItems: [String] = ["Loading..."]
    @Published var titleItems: [String] = ["Ksatria Bugar"]
    
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
        // Bypass Gemini completely and load all offline dummy data
        self.motivationItems = AIService.DummyDataPool.motivations
        self.storyItems = AIService.DummyDataPool.stories
        self.titleItems = AIService.DummyDataPool.titles
        
        // Simulate a tiny loading delay for UI smoothness
        try? await Task.sleep(nanoseconds: 300_000_000)
        
        refreshRewards()
        refreshActiveDetailContent()
    }
    
    func refreshRewards() {
        let currentStreak = prefs.streak
        let currentLevel = prefs.level
        let palette: [RewardCardStyle] = [.orange, .green, .red, .blue, .purple, .teal]
        
        let motivationRewards = motivationItems.enumerated().map { index, text in
            // Motivations unlock every 1 Level
            let requiredLevel = index + 1
            let isLocked = currentLevel < requiredLevel
            return RewardItem(
                type: .motivation,
                title: "Motivasi Humor Academy #\(index + 1)",
                icon: "star.fill",
                style: palette[index % palette.count],
                buttonTitle: isLocked ? "Butuh Level \(requiredLevel)" : "Lihat Motivasi",
                isLocked: isLocked,
                unlockMessage: "Capai\nLevel \(requiredLevel) untuk membuka!",
                detailContent: text,
                detailIndex: index
            )
        }
        
        let storyRewards = storyItems.enumerated().map { index, text in
            // Stories unlock every 2 Streaks (0, 2, 4...)
            let requiredStreak = index * 2
            let isLocked = currentStreak < requiredStreak
            return RewardItem(
                type: .story,
                title: "Cerita Absurd Academy #\(index + 1)",
                icon: "book.fill",
                style: palette[(index + 1) % palette.count],
                buttonTitle: isLocked ? "Butuh Streak \(requiredStreak)" : "Buka Cerita",
                isLocked: isLocked,
                unlockMessage: "Kumpulkan\n\(max(0, requiredStreak - currentStreak)) Streak lagi yuk!",
                detailContent: text,
                detailIndex: index
            )
        }
        
        let titleRewards = titleItems.enumerated().map { index, text in
            // Titles unlock every 2 Levels starting at Level 2 (2, 4, 6...)
            let requiredLevel = (index + 1) * 2
            let isLocked = currentLevel < requiredLevel
            return RewardItem(
                type: .title,
                title: "Gelar: \(text)",
                icon: "medal.fill",
                style: palette[(index + 2) % palette.count],
                buttonTitle: isLocked ? "Butuh Level \(requiredLevel)" : "Lihat Gelar",
                isLocked: isLocked,
                unlockMessage: "Capai\nLevel \(requiredLevel) untuk gelar ini!",
                detailContent: text,
                detailIndex: index
            )
        }
        
        // Sort: Unlocked items first, then Locked items (stable sort)
        let newRewards = (motivationRewards + storyRewards + titleRewards)
        self.rewards = newRewards.sorted { 
            if $0.isLocked == $1.isLocked {
                // Keep the internal ordering if both are locked or unlocked
                return $0.detailIndex < $1.detailIndex
            }
            return !$0.isLocked && $1.isLocked 
        }
    }
    
    private func sanitizeItems(_ items: [String], fallback: String) -> [String] {
        let cleaned = items
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        return cleaned.isEmpty ? [fallback] : cleaned
    }
    
    private func trimAndDeduplicate(_ items: [String], targetCount: Int, fallback: String) -> [String] {
        var seen = Set<String>()
        let cleaned = items
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
            .filter { seen.insert($0).inserted }
        
        if cleaned.isEmpty {
            return [fallback]
        }
        
        if cleaned.count > targetCount {
            return Array(cleaned.prefix(targetCount))
        }
        
        return cleaned
    }
    
    private func refreshActiveDetailContent() {
        guard let activeDetail else { return }
        let index = max(0, activeDetailIndex)
        
        switch activeDetail {
        case .motivation:
            if motivationItems.indices.contains(index) {
                activeDetailContent = motivationItems[index]
            }
        case .story:
            if storyItems.indices.contains(index) {
                activeDetailContent = storyItems[index]
            }
        case .title:
            if titleItems.indices.contains(index) {
                activeDetailContent = titleItems[index]
            }
        }
    }
}
