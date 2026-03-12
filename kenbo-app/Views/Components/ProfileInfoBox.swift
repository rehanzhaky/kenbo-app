import SwiftUI

struct ProfileInfoBox: View {
    let userName: String
    let currentXP: Int
    let maxXP: Int
    let completedTasks: Int
    let totalTasks: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Name Row with Badge
            HStack(spacing: 8) {
                Text(userName)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.black)
                
                // "Si Bugar" Badge
                Text("Si Bugar")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.App.Purple.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
            
            // XP Progress Bar
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 8) {
                    Image(systemName: "star.fill")
                        .foregroundColor(Color.App.Purple.primary)
                        .font(.system(size: 16))
                    
                    ProgressBar(
                        progress: Double(currentXP) / Double(maxXP),
                        color: Color.App.Purple.primary,
                        backgroundColor: Color.App.Purple.light,
                        height: 12
                    )
                    
                    Text("\(currentXP)/\(maxXP) XP")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(Color.App.Purple.primary)
                }
            }
            
            // Task Progress Bar
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 8) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(Color.App.Green.primary)
                        .font(.system(size: 16))
                    
                    ProgressBar(
                        progress: Double(completedTasks) / Double(totalTasks),
                        color: Color.App.Green.primary,
                        backgroundColor: Color.App.Green.light,
                        height: 12
                    )
                    
                    Text("\(completedTasks)/\(totalTasks) Tasks")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(Color.App.Green.primary)
                }
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
    .shadow(color: Color.App.Purple.dark, radius: 0, x: 0, y: 5)
    .padding()
    .background(Color.App.Gray.light)
}
