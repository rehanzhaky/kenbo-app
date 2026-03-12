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
            HStack(spacing: 8) {
                Image(systemName: "star.fill")
                    .foregroundColor(Color(hex: "BE71FE"))
                    .font(.system(size: 14, weight: .bold))
                
                ProgressBar(
                    progress: Double(currentXP) / Double(maxXP),
                    color: Color(hex: "BE71FE"),
                    backgroundColor: Color(hex: "E5D4F5"),
                    height: 20
                )
                
                Text("\(currentXP)/\(maxXP) XP")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Color(hex: "BE71FE"))
            }
            
            // Task Progress Bar
            HStack(spacing: 8) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(Color(hex: "6EE46C"))
                    .font(.system(size: 14, weight: .bold))
                
                ProgressBar(
                    progress: Double(completedTasks) / Double(totalTasks),
                    color: Color(hex: "6EE46C"),
                    backgroundColor: Color(hex: "B5F2B4"),
                    height: 20
                )
                
                Text("\(completedTasks)/\(totalTasks) Tasks")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Color(hex: "6EE46C"))
            }
            

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
