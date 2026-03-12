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
    let id = UUID()
    let title: String
    let icon: String // Asset image name or system name, here using asset names from screenshot (e.g. food-turkey)
    let iconBackgroundColor: Color
    let cardBackgroundColor: Color
    let currentProgress: Int
    let totalProgress: Int
    let progressBarColor: Color
    let progressBarBackgroundColor: Color
    let shadowColor: Color
}

class HomeViewModel: ObservableObject {
    @Published var userProfile: UserProfile
    @Published var characterStats: CharacterStats
    @Published var questDescription: String
    @Published var questTasks: [QuestTask]
    
    init(userName: String, gender: String) {
        // Dummy data for slicing purposes based on the screenshot
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
        
        self.characterStats = CharacterStats(
            healthCurrent: 200,
            healthMax: 300,
            powerCurrent: 200,
            powerMax: 300,
            staminaCurrent: 200,
            staminaMax: 300,
            imageName: "link_sprite"
        )
        
        self.questDescription = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the"
        
        self.questTasks = [
            QuestTask(
                title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                icon: "heart-pulse",
                iconBackgroundColor: Color.App.Red.dark,
                cardBackgroundColor: Color.App.Red.primary,
                currentProgress: 1,
                totalProgress: 2,
                progressBarColor: Color.App.Blue.primary,
                progressBarBackgroundColor: Color.App.Blue.light,
                shadowColor: Color.App.Red.dark
            ),
            QuestTask(
                title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                icon: "food-turkey",
                iconBackgroundColor: Color.App.Orange.dark,
                cardBackgroundColor: Color.App.Orange.primary,
                currentProgress: 0,
                totalProgress: 2,
                progressBarColor: Color.App.Green.primary,
                progressBarBackgroundColor: Color.App.Green.light,
                shadowColor: Color.App.Orange.dark
            )
        ]
    }
}
