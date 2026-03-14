import SwiftUI

struct TaskCardData: Identifiable {
    let id = UUID()
    let icon: String
    let iconBackgroundColor: Color
    let cardBackgroundColor: Color
    let title: String
    let currentProgress: Int
    let totalProgress: Int
    let shadowColor: Color
    
    // Predefined task cards
    static let healthTask = TaskCardData(
        icon: "heart-pulse",
        iconBackgroundColor: Color(hex: "8B4444"),
        cardBackgroundColor: Color(hex: "FE7171"),
        title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        currentProgress: 1,
        totalProgress: 2,
        shadowColor: Color(hex: "9C3B3B")
    )
    
    static let powerTask = TaskCardData(
        icon: "food-turkey",
        iconBackgroundColor: Color(hex: "8B5E33"),
        cardBackgroundColor: Color(hex: "FEB871"),
        title: "Complete your daily tasks and earn rewards.",
        currentProgress: 5,
        totalProgress: 5,
        shadowColor: Color(hex: "B0763C")
    )
    
    static let staminaTask = TaskCardData(
        icon: "energy",
        iconBackgroundColor: Color(hex: "1F4F54"),
        cardBackgroundColor: Color(hex: "6CDCE4"),
        title: "Track your progress and stay motivated.",
        currentProgress: 2,
        totalProgress: 4,
        shadowColor: Color(hex: "29676C")
    )
}
