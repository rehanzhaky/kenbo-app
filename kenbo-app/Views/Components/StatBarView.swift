import SwiftUI

public enum StatBarStyle {
    case health
    case power
    case stamina
    
    var primaryColor: Color {
        switch self {
        case .health: return Color.App.Red.primary
        case .power: return Color.App.Green.primary
        case .stamina: return Color.App.Blue.primary
        }
    }
    
    var lightColor: Color {
        switch self {
        case .health: return Color.App.Red.light
        case .power: return Color.App.Green.light
        case .stamina: return Color.App.Blue.light
        }
    }
    
    var darkColor: Color {
        switch self {
        case .health: return Color.App.Red.dark
        case .power: return Color.App.Green.dark
        case .stamina: return Color.App.Blue.dark
        }
    }
    
    var defaultIcon: String {
        switch self {
        case .health: return "heart.text.square.fill" // Approximation
        case .power: return "flame.fill" // Approximation
        case .stamina: return "bolt.fill"
        }
    }
}

public struct StatBarView: View {
    public let title: String
    public let style: StatBarStyle
    public let current: Int
    public let max: Int
    public let unit: String
    public let customIcon: String?
    
    public init(
        title: String,
        style: StatBarStyle,
        current: Int,
        max: Int,
        unit: String,
        customIcon: String? = nil
    ) {
        self.title = title
        self.style = style
        self.current = current
        self.max = max
        self.unit = unit
        self.customIcon = customIcon
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)
                .padding(.leading, 36) // align with the bar start, past the circle
            
            GeometryReader { geometry in
                let progress = CGFloat(current) / CGFloat(max)
                let barHeight: CGFloat = 24
                let circleSize: CGFloat = 36
                
                ZStack(alignment: .leading) {
                    // Background bar (light)
                    Capsule()
                        .fill(style.lightColor)
                        .frame(height: barHeight)
                        .padding(.leading, circleSize / 2)
                    
                    // Foreground bar (primary)
                    Capsule()
                        .fill(style.primaryColor)
                        .frame(width: (geometry.size.width - circleSize / 2) * progress + circleSize / 2, height: barHeight)
                        .padding(.leading, circleSize / 2)
                        .animation(.easeInOut, value: progress)
                    
                    // Text value
                    Text("\(current)/\(max) \(unit)")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 12)
                    
                    // Left Icon Circle
                    ZStack {
                        Circle()
                            .fill(style.primaryColor)
                        
                        Circle()
                            .stroke(style.darkColor, lineWidth: 3)
                        
                        Image(systemName: customIcon ?? style.defaultIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                            .foregroundColor(.white)
                    }
                    .frame(width: circleSize, height: circleSize)
                    .offset(x: 0)
                }
            }
            .frame(height: 36) // accommodates the circle size
        }
    }
}

#if DEBUG
struct StatBarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            StatBarView(title: "Health", style: .health, current: 200, max: 300, unit: "HP", customIcon: "waveform.path.ecg")
            StatBarView(title: "Power", style: .power, current: 200, max: 300, unit: "PW", customIcon: "takeoutbox.fill")
            StatBarView(title: "Stamina", style: .stamina, current: 200, max: 300, unit: "ST", customIcon: "bolt.fill")
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
#endif
