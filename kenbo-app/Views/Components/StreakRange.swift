import SwiftUI

struct StreakRange: View {
    let days = ["Sen", "Sel", "Rab", "Kam", "Jum", "Sab", "Min"]
    let numbers = Array(1...7)
    
    var currentStreak: Int = 0
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 0) {
                ForEach(0..<7, id: \.self) { index in
                    VStack(spacing: 12) {
                        // Day label
                        Text(days[index])
                            .font(.custom("Montserrat-Bold", size: 18))
                            .foregroundColor(.white)
                        
                        // Check if day is within our current streak (1-indexed)
                        let isActive = numbers[index] <= currentStreak
                        
                        // Number box
                        Text("\(numbers[index])")
                            .font(.custom("Montserrat-Bold", size: isActive ? 24 : 28))
                            .foregroundColor(isActive ? Color.App.Yellow.primary : Color(hex: "C0C0C0"))
                            .frame(width: isActive ? 42 : 39, height: isActive ? 48 : 45)
                            .background(isActive ? Color.App.Yellow.light : Color.white.opacity(0.9))
                            .cornerRadius(isActive ? 14 : 16)
                            .overlay(
                                RoundedRectangle(cornerRadius: isActive ? 14 : 16)
                                    .stroke(isActive ? Color.App.Yellow.primary : Color.clear, lineWidth: isActive ? 2 : 0)
                            )
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(.vertical, 30)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(hex: "B77EF5"),
                            Color(hex: "A77BED")
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color(hex: "FFFFFF"), lineWidth: 2)
        )
        .padding(.horizontal, 16)
    }
}

#Preview {
    VStack {
        StreakRange(currentStreak: 3)
    }
    .background(Color(hex: "F7F7F7"))
}
