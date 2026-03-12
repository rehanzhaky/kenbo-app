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
    @Published var rewards: [RewardItem]
    @Published var activeDetail: RewardDetailType?
    
    init(userName: String, gender: String) {
        // Dummy data for consistency with Home
        self.userProfile = UserProfile(
            name: userName,
            gender: gender,
            level: 20,
            streak: 5,
            currentXP: 200,
            maxXP: 300,
            completedTasks: 4,
            totalTasks: 7
        )
        
        self.rewardDescription = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the"
        
        // Mock rewards based on the screenshot
        self.rewards = [
            RewardItem(
                type: .story,
                title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                icon: "book.fill",
                style: .blue,
                buttonTitle: "Lihat",
                isLocked: false,
                unlockMessage: nil
            ),
            RewardItem(
                type: .title,
                title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                icon: "medal.fill",
                style: .green,
                buttonTitle: "Lihat",
                isLocked: false,
                unlockMessage: nil
            ),
            RewardItem(
                type: .motivation,
                title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                icon: "star.fill",
                style: .solid(primary: Color(hex: "5E412F"), dark: Color(hex: "3D2B1F")),
                buttonTitle: "Kumpulkan 30 XP lagi yuk !",
                isLocked: true,
                unlockMessage: "Kumpulkan 30 XP lagi yuk !"
            )
        ]
    }
}
