import SwiftUI

struct TaskCard: View {
    let icon: String
    let iconBackgroundColor: Color
    let cardBackgroundColor: Color
    let title: String
    let currentProgress: Int
    let totalProgress: Int
    let unit: String
    let shadowColor: Color
    
    var progress: Double {
        Double(currentProgress) / Double(totalProgress)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Icon and Title Row
            HStack(alignment: .top, spacing: 16) {
                // Icon
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(iconBackgroundColor)
                        .frame(width: 70, height: 70)
                    
                    if icon.hasPrefix("system:") {
                        Image(systemName: String(icon.dropFirst(7)))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.white)
                    } else {
                        Image(icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.white)
                    }
                }
                
                // Title Text
                Text(title)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            // Progress Bar (Handles both incomplete and complete states)
            ProgressBar(
                progress: progress,
                color: progress >= 1.0 ? Color.App.Green.primary : Color(hex: "6CA8FF"),
                backgroundColor: progress >= 1.0 ? Color.App.Green.light : Color(hex: "D5E5FF"),
                height: 40,
                text: progress >= 1.0 ? "Selesai" : "\(currentProgress)/\(totalProgress) \(unit)",
                textColor: .white
            )
        }
        .padding(20)
        .background(cardBackgroundColor)
        .cornerRadius(24)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(progress >= 1.0 ? Color(hex: "6EE46C") : Color.clear, lineWidth: progress >= 1.0 ? 3 : 0)
        )
        .shadow(color: progress >= 1.0 ? Color.clear : shadowColor, radius: 0, x: 0, y: 5)
    }
}

#Preview {
    VStack(spacing: 20) {
        // Incomplete Task Card
        TaskCard(
            icon: "heart-pulse",
            iconBackgroundColor: Color(hex: "8B4444"),
            cardBackgroundColor: Color(hex: "FE7171"),
            title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            currentProgress: 1,
            totalProgress: 2,
            unit: "Detik",
            shadowColor: Color(hex: "9C3B3B")
        )
        
        // Completed Task Card (100%)
        TaskCard(
            icon: "food-turkey",
            iconBackgroundColor: Color(hex: "8B5E33"),
            cardBackgroundColor: Color(hex: "FEB871"),
            title: "Complete your daily tasks and earn rewards.",
            currentProgress: 5,
            totalProgress: 5,
            unit: "Steps",
            shadowColor: Color(hex: "B0763C")
        )
    }
    .padding()
    .background(Color(hex: "F7F7F7"))
}
