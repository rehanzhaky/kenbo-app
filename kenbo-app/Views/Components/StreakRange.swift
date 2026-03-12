import SwiftUI

struct StreakRange: View {
    let days = ["Sen", "Sel", "Rab", "Kam", "Jum", "Sab", "Min"]
    let numbers = Array(1...7)
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 0) {
                ForEach(0..<7, id: \.self) { index in
                    VStack(spacing: 12) {
                        // Day label
                        Text(days[index])
                            .font(.custom("Montserrat-Bold", size: 18))
                            .foregroundColor(.white)
                        
                        // Number box
                        Text("\(numbers[index])")
                            .font(.custom("Montserrat-Bold", size: 28))
                            .foregroundColor(Color(hex: "C0C0C0"))
                            .frame(width: 39, height: 45)
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(16)
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
        StreakRange()
    }
    .background(Color(hex: "F7F7F7"))
}
