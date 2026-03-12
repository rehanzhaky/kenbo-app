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
                    .frame(width: 86, height: 86)
                
                // Main circle
                Circle()
                    .fill(color)
                    .frame(width: 70, height: 70)
                
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .foregroundColor(.white)
            }
            .zIndex(1)
            
            // Progress Capsule
            ZStack(alignment: .leading) {
                // Background
                Capsule()
                    .fill(lightColor)
                    .frame(height: 70)
                
                // Progress
                GeometryReader { geometry in
                    Capsule()
                        .fill(color)
                        .frame(width: geometry.size.width * progress, height: 70)
                }
                .frame(height: 70)
                
                // Text
                HStack {
                    Spacer()
                    Text("\(current)/\(max) \(unit)")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.trailing, 24)
                }
            }
            .padding(.leading, -35)
        }
        .frame(height: 86)
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
