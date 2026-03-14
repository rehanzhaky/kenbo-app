import SwiftUI

struct StatBarCard: View {
    let title: String
    let icon: String
    let current: Int
    let max: Int
    let color: Color
    let lightColor: Color
    let outerCircleColor: Color
    let unit: String
    
    var progress: Double {
        Double(current) / Double(max)
    }
    
    var body: some View {
        HStack(spacing: 0) {
            // Icon Circle on left
            ZStack {
                // Outer circle
                Circle()
                    .fill(outerCircleColor)
                    .frame(width: 60, height: 60)
                
                // Main circle
                Circle()
                    .fill(color)
                    .frame(width: 50, height: 50)
                
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22, height: 22)
                    .foregroundColor(.white)
            }
            .zIndex(1)
            
            // Progress Capsule
            ZStack(alignment: .leading) {
                // Background
                Capsule()
                    .fill(lightColor)
                    .frame(height: 50)
                
                // Progress
                GeometryReader { geometry in
                    Capsule()
                        .fill(color)
                        .frame(width: geometry.size.width * progress, height: 50)
                }
                .frame(height: 50)
                
                // Text
                HStack {
                    Spacer()
                    Text("\(current)/\(max) \(unit)")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.trailing, 16)
                }
            }
            .padding(.leading, -25)
        }
        .frame(height: 60)
    }
}

#Preview {
    StatBarCard(
        title: "Health",
        icon: "heart-pulse",
        current: 200,
        max: 300,
        color: Color(hex: "FE7171"),
        lightColor: Color(hex: "FFC5C5"),
        outerCircleColor: Color(hex: "9C3B3B"),
        unit: "HP"
    )
    .padding()
    .background(Color(hex: "F7F7F7"))
}
