import SwiftUI

struct TaskCard: View {
    let icon: String
    let iconBackgroundColor: Color
    let cardBackgroundColor: Color
    let title: String
    let currentProgress: Int
    let totalProgress: Int
    let progressBarColor: Color
    let progressBarBackgroundColor: Color
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
                    
                    Image(icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                        .foregroundColor(.white)
                }
                
                // Title Text
                Text(title)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            // Progress Bar
            ZStack(alignment: .leading) {
                // Background
                Capsule()
                    .fill(progressBarBackgroundColor)
                    .frame(height: 40)
                
                // Progress
                GeometryReader { geometry in
                    Capsule()
                        .fill(progressBarColor)
                        .frame(width: geometry.size.width * progress, height: 40)
                }
                .frame(height: 40)
                
                // Progress Text
                HStack {
                    Spacer()
                    Text("\(currentProgress)/\(totalProgress)")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.trailing, 20)
                }
            }
        }
        .padding(20)
        .background(cardBackgroundColor)
        .cornerRadius(24)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color(hex: "6EE46C"), lineWidth: progress >= 1.0 ? 3 : 0)
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
            progressBarColor: Color(hex: "6CA8FF"),
            progressBarBackgroundColor: Color(hex: "D5E5FF"),
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
            progressBarColor: Color(hex: "FF9B5E"),
            progressBarBackgroundColor: Color(hex: "FFD4B3"),
            shadowColor: Color(hex: "B0763C")
        )
    }
    .padding()
    .background(Color(hex: "F7F7F7"))
}
