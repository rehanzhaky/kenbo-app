import SwiftUI

public enum RewardCardStyle {
    case solid(primary: Color, dark: Color)
    case plain(element: Color)
    
    public static let orange = RewardCardStyle.solid(primary: Color.App.Orange.primary, dark: Color.App.Orange.dark)
    public static let plainOrange = RewardCardStyle.plain(element: Color.App.Orange.dark)
    public static let green = RewardCardStyle.solid(primary: Color.App.Green.primary, dark: Color.App.Green.dark)
    public static let red = RewardCardStyle.solid(primary: Color.App.Red.primary, dark: Color.App.Red.dark)
    public static let blue = RewardCardStyle.solid(primary: Color.App.Blue.primary, dark: Color.App.Blue.dark)
    
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
    public let action: () -> Void
    
    public init(
        text: String,
        iconName: String? = nil,
        buttonTitle: String = "Lihat",
        style: RewardCardStyle,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.iconName = iconName
        self.buttonTitle = buttonTitle
        self.style = style
        self.action = action
    }
    
    public var body: some View {
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
        .padding(16)
        .background(style.backgroundColor)
        .cornerRadius(16)
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
                    text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                    iconName: "book.fill",
                    style: .blue
                ) {}
            }
            .padding()
        }
        .previewLayout(.sizeThatFits)
    }
}
#endif
