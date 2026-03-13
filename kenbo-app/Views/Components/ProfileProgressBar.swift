import SwiftUI

struct ProfileProgressBar: View {
    let progress: Double // 0.0 to 1.0
    let currentValue: Int
    let maxValue: Int
    let label: String // "XP" or ""
    let fillColor: Color
    let backgroundColor: Color
    let textColor: Color
    let height: CGFloat
    
    init(
        currentValue: Int,
        maxValue: Int,
        label: String = "",
        fillColor: Color,
        backgroundColor: Color,
        textColor: Color = .white,
        height: CGFloat = 50
    ) {
        self.currentValue = currentValue
        self.maxValue = maxValue
        self.progress = min(max(Double(currentValue) / Double(maxValue), 0.0), 1.0)
        self.label = label
        self.fillColor = fillColor
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.height = height
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Background Capsule
                Capsule()
                    .fill(backgroundColor)
                    .frame(height: height)
                
                // Progress Fill
                Capsule()
                    .fill(fillColor)
                    .frame(width: geometry.size.width * progress, height: height)
                
                // Text Label
                HStack {
                    Spacer()
                    Text("\(currentValue)/\(maxValue)\(label.isEmpty ? "" : " \(label)")")
                        .font(.custom("Montserrat-Bold", size: height * 0.42))
                        .foregroundColor(textColor)
                        .padding(.trailing, height * 0.4)
                }
            }
        }
        .frame(height: height)
    }
}

#Preview {
    VStack(spacing: 20) {
        // XP Progress Bar
        ProfileProgressBar(
            currentValue: 200,
            maxValue: 300,
            label: "XP",
            fillColor: Color(hex: "BE71FE"),
            backgroundColor: Color(hex: "E5D4F5"),
            textColor: .white,
            height: 50
        )
        .frame(width: 600)
        
        // Task Progress Bar
        ProfileProgressBar(
            currentValue: 4,
            maxValue: 7,
            label: "",
            fillColor: Color(hex: "E5B996"),
            backgroundColor: Color(hex: "F5E5D4"),
            textColor: .white,
            height: 35
        )
        .frame(width: 380)
    }
    .padding()
    .background(Color(hex: "F7F7F7"))
}
