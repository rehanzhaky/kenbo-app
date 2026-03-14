import SwiftUI

struct ProfileInfoBox: View {
    let userName: String
    let currentXP: Int
    let maxXP: Int
    let completedTasks: Int
    let totalTasks: Int
    let titleBadge: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Nama dengan Badge
            HStack(alignment: .center, spacing: 8) {
                Text(userName)
                    .font(.custom("Montserrat-Bold", size: 32))
                    .foregroundColor(.black)
                

                // Dynamic Badge
                if let badge = titleBadge {
                    Text(badge)
                        .font(.custom("Montserrat-Bold", size: 10))
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color(hex: "BE71FE"))
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
            }
            
            // XP Progress Bar
            ProfileProgressBar(
                currentValue: currentXP,
                maxValue: maxXP,
                label: "XP",
                fillColor: Color(hex: "BE71FE"),
                backgroundColor: Color(hex: "E5D4F5"),
                textColor: .white,
                height: 16
            )
            .frame(width: 220, height: 16)
            
            // Task Progress Bar
            ProfileProgressBar(
                currentValue: completedTasks,
                maxValue: totalTasks,
                label: "",
                fillColor: Color(hex: "FEB871"),
                backgroundColor: Color(hex: "FFE2C4"),
                textColor: .white,
                height: 14
            )
            .frame(width: 100, height: 14)
        }
    }
}

#Preview {
    ProfileInfoBox(
        userName: "Funday",
        currentXP: 200,
        maxXP: 300,
        completedTasks: 4,
        totalTasks: 7,
        titleBadge: "Bugar"
    )
    .padding()
    .background(Color.white)
    .cornerRadius(20)

    .shadow(color: Color.App.Purple.dark, radius: 0, x: 0, y: 5)
    .padding()
    .background(Color.App.Gray.light)
}
