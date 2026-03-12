import SwiftUI

struct ProgressBar: View {
    let progress: Double // 0.0 to 1.0
    let color: Color
    let backgroundColor: Color
    let height: CGFloat
    let text: String?
    
    init(
        progress: Double,
        color: Color = Color(hex: "BE71FE"),
        backgroundColor: Color = Color(hex: "E5D4F5"),
        height: CGFloat = 50,
        text: String? = nil
    ) {
        self.progress = min(max(progress, 0.0), 1.0)
        self.color = color
        self.backgroundColor = backgroundColor
        self.height = height
        self.text = text
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            // Background
            Capsule()
                .fill(backgroundColor)
                .frame(height: height)
            
            // Progress
            GeometryReader { geometry in
                Capsule()
                    .fill(color)
                    .frame(width: geometry.size.width * progress, height: height)
            }
            .frame(height: height)
            
            // Optional Text
            if let text = text {
                HStack {
                    Spacer()
                    Text(text)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.trailing, 20)
                }
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        ProgressBar(
            progress: 0.7,
            text: "Loading ..."
        )
        
        ProgressBar(
            progress: 0.5,
            color: Color(hex: "6EE46C"),
            backgroundColor: Color(hex: "B5F2B4"),
            text: "50%"
        )
        
        ProgressBar(
            progress: 0.3,
            color: Color(hex: "FE7171"),
            backgroundColor: Color(hex: "FFC5C5"),
            height: 40
        )
    }
    .padding()
    .background(Color(hex: "F7F7F7"))
}
