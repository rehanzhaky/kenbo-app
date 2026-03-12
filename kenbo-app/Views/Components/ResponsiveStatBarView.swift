import SwiftUI

public struct ResponsiveStatBarView: View {
    public let title: String
    public let style: StatBarStyle
    public let current: Int
    public let maxValue: Int
    public let unit: String
    public let customIcon: String?
    
    // Height determines the overall size. All other dimensions are proportional to it.
    public let height: CGFloat
    
    public init(
        title: String,
        style: StatBarStyle,
        current: Int,
        max: Int,
        unit: String,
        customIcon: String? = nil,
        height: CGFloat = 36
    ) {
        self.title = title
        self.style = style
        self.current = current
        self.maxValue = max
        self.unit = unit
        self.customIcon = customIcon
        self.height = height
    }
    
    public var body: some View {
        let barHeight = height * 0.66
        let circleSize = height
        let progress = min(max(CGFloat(current) / CGFloat(max(maxValue, 1)), 0), 1)
        
        VStack(alignment: .leading, spacing: height * 0.1) {
            // Title
            Text(title)
                .font(.system(size: max(height * 0.45, 10), weight: .semibold))
                .foregroundColor(.black)
                .padding(.leading, circleSize) // Align text with the bar start
            
            // Bar Construction
            HStack(spacing: -(circleSize / 2)) {
                
                // Left Icon Circle
                ZStack {
                    Circle()
                        .fill(style.primaryColor)
                    
                    Circle()
                        .stroke(style.darkColor, lineWidth: max(height * 0.08, 1))
                    
                    if let icon = customIcon ?? (style.defaultIcon == "" ? nil : style.defaultIcon) {
                        Image(systemName: icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: circleSize * 0.5, height: circleSize * 0.5)
                            .foregroundColor(.white)
                    }
                }
                .frame(width: circleSize, height: circleSize)
                .zIndex(1) // Ensure circle stays on top of the bar track
                
                // Track & Progress
                ZStack(alignment: .leading) {
                    // Background Track
                    Capsule()
                        .fill(style.lightColor)
                    
                    // Foreground Track (Progress)
                    GeometryReader { geometry in
                        Capsule()
                            .fill(style.primaryColor)
                            .frame(width: geometry.size.width * progress)
                            .animation(.easeInOut, value: progress)
                    }
                    
                    // Text value inside bar
                    Text("\(current)/\(maxValue) \(unit)")
                        .font(.system(size: max(barHeight * 0.5, 8), weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, barHeight * 0.5)
                }
                .frame(height: barHeight)
            }
        }
    }
}

#if DEBUG
struct ResponsiveStatBarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 30) {
            // Default size
            ResponsiveStatBarView(title: "Health", style: .health, current: 200, max: 300, unit: "HP", customIcon: "waveform.path.ecg")
            
            // Scaled up
            ResponsiveStatBarView(title: "Power", style: .power, current: 150, max: 300, unit: "PW", customIcon: "flame.fill", height: 60)
            
            // Scaled down
            ResponsiveStatBarView(title: "Stamina", style: .stamina, current: 50, max: 300, unit: "ST", customIcon: "bolt.fill", height: 24)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
#endif
