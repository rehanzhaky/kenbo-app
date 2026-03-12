import SwiftUI

struct ProfileInfoBox: View {
    let userName: String
    let currentXP: Int
    let maxXP: Int
    let completedTasks: Int
    let totalTasks: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Name
            Text(userName)
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.black)
            
            // XP Progress Bar
            ProfileProgressBar.xpBar(current: currentXP, max: maxXP)
            
            // Task Progress Bar
            ProfileProgressBar.taskBar(current: completedTasks, max: totalTasks)
        }
    }
}

#Preview {
    ProfileInfoBox(
        userName: "Funday",
        currentXP: 200,
        maxXP: 300,
        completedTasks: 4,
        totalTasks: 7
    )
    .padding()
    .background(Color.white)
    .cornerRadius(20)
    .shadow(color: Color(hex: "74409F"), radius: 0, x: 0, y: 5)
    .padding()
    .background(Color(hex: "F7F7F7"))
}
