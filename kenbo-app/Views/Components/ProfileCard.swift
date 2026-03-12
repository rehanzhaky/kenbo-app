import SwiftUI

struct ProfileCard: View {
    let userName: String
    let gender: String // "Lelaki" or "Perempuan"
    let currentXP: Int
    let maxXP: Int
    let completedTasks: Int
    let totalTasks: Int
    
    var body: some View {
        ProfileBox {
            HStack(spacing: 16) {
                // Avatar
                ProfileAvatar(gender: gender, size: 80)
                
                // Profile Info
                ProfileInfoBox(
                    userName: userName,
                    currentXP: currentXP,
                    maxXP: maxXP,
                    completedTasks: completedTasks,
                    totalTasks: totalTasks
                )
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        ProfileCard(
            userName: "Funday",
            gender: "Lelaki",
            currentXP: 200,
            maxXP: 300,
            completedTasks: 4,
            totalTasks: 7
        )
        
        ProfileCard(
            userName: "Sarah",
            gender: "Perempuan",
            currentXP: 150,
            maxXP: 300,
            completedTasks: 6,
            totalTasks: 7
        )
    }
    .background(Color(hex: "F7F7F7"))
}
