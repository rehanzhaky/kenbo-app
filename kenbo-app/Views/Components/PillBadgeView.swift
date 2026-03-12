import SwiftUI

public enum PillBadgeStyle {
    case level
    case streak
    
    var backgroundColor: Color {
        switch self {
        case .level: return Color.App.Purple.primary
        case .streak: return Color.App.Orange.primary
        }
    }
    
    var shadowColor: Color {
        switch self {
        case .level: return Color.App.Purple.dark
        case .streak: return Color.App.Orange.dark
        }
    }
    
    var outlineColor: Color {
        // Based on the image, the purple has a dark purple outline, and orange has a dark orange outline.
        switch self {
        case .level: return Color.App.Purple.dark
        case .streak: return Color.App.Orange.dark
        }
    }
}

public struct PillBadgeView: View {
    public let text: String
    public let iconName: String?
    public let style: PillBadgeStyle
    
    public init(text: String, iconName: String? = nil, style: PillBadgeStyle) {
        self.text = text
        self.iconName = iconName
        self.style = style
    }
    
    public var body: some View {
        HStack(spacing: 6) {
            if let iconName = iconName, !iconName.isEmpty {
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                    .foregroundColor(.white)
            }
            
            Text(text)
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
        .background(style.backgroundColor)
        .clipShape(Capsule())
        // Apply the 3D-like bottom border/shadow effect shown in the design
        .overlay(
            Capsule()
                .stroke(style.outlineColor, lineWidth: 2)
        )
        .background(
            Capsule()
                .fill(style.shadowColor)
                .offset(y: 4) // This creates the 3D bottom-heavy shadow look
        )
    }
}

#if DEBUG
struct PillBadgeView_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 20) {
            // Level badge (no icon, purple)
            PillBadgeView(text: "Lv. 20", style: .level)
            
            // Streak badge (fire icon, orange)
            PillBadgeView(text: "5", iconName: "flame.fill", style: .streak)
        }
        .padding(40)
        .previewLayout(.sizeThatFits)
    }
}
#endif
