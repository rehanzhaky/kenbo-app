import SwiftUI

struct ProfileCard: View {
    let userName: String
    let gender: String // "Lelaki" or "Perempuan"
    let currentXP: Int
    let maxXP: Int
    let completedTasks: Int
    let totalTasks: Int
    let titleBadge: String?
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            ProfileBox {
                HStack(alignment: .top, spacing: 12) {
                    // Avatar
                    ProfileAvatar(gender: gender, size: 80)
                    
                    // Profile Info
                    ProfileInfoBox(
                        userName: userName,
                        currentXP: currentXP,
                        maxXP: maxXP,
                        completedTasks: completedTasks,
                        totalTasks: totalTasks,
                        titleBadge: titleBadge
                    )
                    
                    Spacer()
                }
            }
        }
        .buttonStyle(.plain)
        .frame(height: 120)
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
            totalTasks: 7,
            titleBadge: "Bugar",
            onTap: {}
        )
        
        ProfileCard(
            userName: "Sarah",
            gender: "Perempuan",
            currentXP: 150,
            maxXP: 300,
            completedTasks: 6,
            totalTasks: 7,
            titleBadge: nil,
            onTap: {}
        )
    }
    .background(Color(hex: "F7F7F7"))
}
