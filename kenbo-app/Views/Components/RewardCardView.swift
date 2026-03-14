import SwiftUI

public enum RewardCardStyle {
    case solid(primary: Color, dark: Color)
    case plain(element: Color)
    
    public static let orange = RewardCardStyle.solid(primary: Color.App.Orange.primary, dark: Color.App.Orange.dark)
    public static let plainOrange = RewardCardStyle.plain(element: Color.App.Orange.dark)
    public static let green = RewardCardStyle.solid(primary: Color.App.Green.primary, dark: Color.App.Green.dark)
    public static let red = RewardCardStyle.solid(primary: Color.App.Red.primary, dark: Color.App.Red.dark)
    public static let blue = RewardCardStyle.solid(primary: Color.App.Blue.primary, dark: Color.App.Blue.dark)
    public static let purple = RewardCardStyle.solid(primary: Color.App.Purple.primary, dark: Color.App.Purple.dark)
    public static let teal = RewardCardStyle.solid(primary: Color.App.Teal.primary, dark: Color.App.Teal.dark)
    
    var backgroundColor: Color {
        switch self {
        case .solid(let primary, _): return primary
        case .plain: return .clear
        }
    }
    
    var elementColor: Color {
        switch self {
        case .solid(_, let dark): return dark
        case .plain(let element): return element
        }
    }
    
    var textColor: Color {
        switch self {
        case .solid: return .white
        case .plain: return .black
        }
    }
}
public struct RewardCardView: View {
    public let text: String
    public let iconName: String?
    public let buttonTitle: String
    public let style: RewardCardStyle
    public let isLocked: Bool
    public let unlockMessage: String?
    public let action: () -> Void
    
    public init(
        text: String,
        iconName: String? = nil,
        buttonTitle: String = "Lihat",
        style: RewardCardStyle,
        isLocked: Bool = false,
        unlockMessage: String? = nil,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.iconName = iconName
        self.buttonTitle = buttonTitle
        self.style = style
        self.isLocked = isLocked
        self.unlockMessage = unlockMessage
        self.action = action
    }
    
    public var body: some View {
        ZStack {
            // Unlocked Content Layout (Always present but hidden if locked)
            VStack(spacing: 16) {
                HStack(alignment: .top, spacing: 16) {
                    // Icon Box
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(style.elementColor)
                            .shadow(color: Color.black.opacity(0.15), radius: 0, x: 0, y: 3)
                        
                        if let iconName = iconName, !iconName.isEmpty {
                            Image(systemName: iconName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.white)
                        }
                    }
                    .frame(width: 60, height: 60)
                    
                    // Text
                    Text(text)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(style.textColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 4)
                }
                
                // Button
                Button(action: action) {
                    Text(buttonTitle)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(style.elementColor)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.15), radius: 0, x: 0, y: 3)
                }
                .buttonStyle(PlainButtonStyle()) // prevents blue tinting
            }
            .blur(radius: isLocked ? 8 : 0) // Apply blur when locked
            .opacity(isLocked ? 0.7 : 1.0) // Slightly dim the blurred content
            
            // Locked Overlay Layout
            if isLocked {
                VStack(spacing: 16) {
                    // White Circle with Icon
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 60, height: 60)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        
                        // Select icon based on unlock message (xp vs streak)
                        if let msg = unlockMessage, msg.lowercased().contains("xp") {
                            Image(systemName: "arrow.up")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(Color.App.Purple.primary)
                        } else {
                            Image(systemName: "flame.fill")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(Color.App.Orange.primary)
                        }
                    }
                    
                    // Unlock Requirement Text
                    if let message = unlockMessage {
                        let parts = message.components(separatedBy: "\n")
                        VStack(spacing: 4) {
                            if parts.count > 1 {
                                Text(parts[0])
                                Text(parts[1])
                            } else {
                                Text(message)
                            }
                        }
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    }
                }
            }
        }
        .padding(16)
        .background(style.backgroundColor)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2) // Optional: add a slight shadow to the whole card
    }
}

#if DEBUG
struct RewardCardView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(spacing: 24) {
               
                
                RewardCardView(
                    text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                    iconName: "medal.fill",
                    style: .green
                ) {}
                
                RewardCardView(
                    text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                    iconName: "star.fill",
                    style: .red
                ) {}
                
                RewardCardView(
                    text: "Unlocked Reward",
                    iconName: "book.fill",
                    style: .blue
                ) {}
                
                RewardCardView(
                    text: "Locked Reward Content",
                    iconName: "lock.fill",
                    style: .blue,
                    isLocked: true,
                    unlockMessage: "Capai Streak 3 Hari"
                ) {}
            }
            .padding()
        }
        .previewLayout(.sizeThatFits)
    }
}
#endif
