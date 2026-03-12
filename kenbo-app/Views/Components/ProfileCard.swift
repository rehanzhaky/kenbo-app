import SwiftUI

struct ProfileCard: View {
    let userName: String
    let gender: String // "Lelaki" or "Perempuan"
    let currentXP: Int
    let maxXP: Int
    let completedTasks: Int
    let totalTasks: Int
    
    var avatarImage: String {
        gender == "Lelaki" ? "Mask-Boy" : "Mask-Girl"
    }
    
    var xpProgress: Double {
        Double(currentXP) / Double(maxXP)
    }
    
    var taskProgress: Double {
        Double(completedTasks) / Double(totalTasks)
    }
    
    var body: some View {
        HStack(spacing: 16) {
            // Avatar
            Image(avatarImage)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
//                .overlay(
//                    Circle()
//                        .stroke(Color(hex: "74409F"), lineWidth: 3)
//                )
            
            // Name and Progress Bars
            VStack(alignment: .leading, spacing: 12) {
                // Name
                Text(userName)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                
                // XP Progress Bar
                ZStack(alignment: .leading) {
                    // Background
                    Capsule()
                        .fill(Color(hex: "E5D4F5"))
                        .frame(height: 28)
                    
                    // Progress
                    GeometryReader { geometry in
                        Capsule()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color(hex: "BE71FE"), Color(hex: "9D6FCC")]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: geometry.size.width * xpProgress, height: 28)
                    }
                    .frame(height: 28)
                    
                    // XP Text
                    HStack {
                        Spacer()
                        Text("\(currentXP)/\(maxXP) xp")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.trailing, 12)
                    }
                }
                .frame(height: 28)
                
                // Task Progress Bar
                ZStack(alignment: .leading) {
                    // Background
                    Capsule()
                        .fill(Color(hex: "F5E8D4"))
                        .frame(height: 28)
                    
                    // Progress
                    GeometryReader { geometry in
                        Capsule()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color(hex: "FFB88C"), Color(hex: "FFA366")]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: geometry.size.width * taskProgress, height: 28)
                    }
                    .frame(height: 28)
                    
                    // Task Text
                    HStack {
                        Spacer()
                        Text("\(completedTasks)/\(totalTasks)")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.trailing, 12)
                    }
                }
                .frame(height: 28)
            }
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color(hex: "74409F"), radius: 0, x: 0, y: 5)
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
        .padding()
        
        ProfileCard(
            userName: "Sarah",
            gender: "Perempuan",
            currentXP: 150,
            maxXP: 300,
            completedTasks: 6,
            totalTasks: 7
        )
        .padding()
    }
    .background(Color(hex: "F7F7F7"))
}
