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
    public enum Variant {
        case standard
        case overlayIcon
    }

    public let variant: Variant
    public let text: String
    public let descriptionText: String?
    public let iconName: String?
    public let buttonTitle: String
    public let style: RewardCardStyle
    public let isLocked: Bool
    public let action: () -> Void
    
    public init(
        text: String,
        descriptionText: String? = nil,
        iconName: String? = nil,
        buttonTitle: String = "Lihat",
        style: RewardCardStyle,
        isLocked: Bool = false,
        variant: Variant = .standard,
        action: @escaping () -> Void
    ) {
        self.variant = variant
        self.text = text
        self.descriptionText = descriptionText
        self.iconName = iconName
        self.buttonTitle = buttonTitle
        self.style = style
        self.isLocked = isLocked
        self.action = action
    }
    
    public var body: some View {
        Group {
            if variant == .standard {
                standardBody
            } else {
                overlayIconBody
            }
        }
        .padding(16)
        .background(style.backgroundColor)
        .cornerRadius(16)
    }

    private var standardBody: some View {
        VStack(spacing: 16) {
            HStack(alignment: .top, spacing: 16) {
                // Icon Box
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(style.elementColor)
                        .shadow(color: Color.black.opacity(0.15), radius: 0, x: 0, y: 3)

                    if isLocked {
                        Image(systemName: "lock.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                    } else if let iconName = iconName, !iconName.isEmpty {
                        Image(systemName: iconName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                    }
                }
                .frame(width: 60, height: 60)

                // Text
                VStack(alignment: .leading, spacing: 6) {
                    Text(text)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(style.textColor)
                        .multilineTextAlignment(.leading)

                    if let descriptionText = descriptionText {
                        Text(descriptionText)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(style.textColor.opacity(0.8))
                            .multilineTextAlignment(.leading)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 4)
            }

            // Button
            Button(action: action) {
                Text(isLocked ? "Terkunci" : buttonTitle)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(style.elementColor)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.15), radius: 0, x: 0, y: 3)
            }
            .buttonStyle(PlainButtonStyle()) // prevents blue tinting
            .disabled(isLocked)
            .opacity(isLocked ? 0.6 : 1.0)
        }
    }

    private var overlayIconBody: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 16) {
                Spacer().frame(height: 34)

                HStack(alignment: .top, spacing: 16) {
                    // Left icon box (dark overlay)
                    RoundedRectangle(cornerRadius: 16)
                        .fill(style.elementColor.opacity(0.35))
                        .frame(width: 70, height: 70)
                        .overlay(
                            Group {
                                if isLocked {
                                    Image(systemName: "lock.fill")
                                        .resizable()
                                } else if let iconName = iconName, !iconName.isEmpty {
                                    Image(systemName: iconName)
                                        .resizable()
                                }
                            }
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white.opacity(0.85))
                        )

                    VStack(alignment: .leading, spacing: 6) {
                        Text(text)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(style.textColor.opacity(0.85))
                            .multilineTextAlignment(.leading)

                        if let descriptionText = descriptionText {
                            Text(descriptionText)
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(style.textColor.opacity(0.7))
                                .multilineTextAlignment(.leading)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 16)

                Button(action: action) {
                    Text(isLocked ? "Terkunci" : buttonTitle)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(style.elementColor)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.15), radius: 0, x: 0, y: 3)
                }
                .buttonStyle(PlainButtonStyle())
                .disabled(isLocked)
                .opacity(isLocked ? 0.6 : 1.0)
            }

            // Center overlay icon (big circle)
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 70, height: 70)
                    .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 3)

                if isLocked {
                    Image(systemName: "lock.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                        .foregroundColor(style.elementColor)
                } else if let iconName = iconName, !iconName.isEmpty {
                    Image(systemName: iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                        .foregroundColor(style.elementColor)
                }
            }
            .offset(y: -34)
        }
    }
}

#if DEBUG
struct RewardCardView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(spacing: 24) {
               
                
                RewardCardView(
                    text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                    descriptionText: "Lorem ipsum is simply dummy text of the printing and typesetting industry.",
                    iconName: "medal.fill",
                    style: .green
                ) {}
                
                RewardCardView(
                    text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                    descriptionText: "Lorem ipsum is simply dummy text of the printing and typesetting industry.",
                    iconName: "star.fill",
                    style: .red,
                    isLocked: true
                ) {}
                
                RewardCardView(
                    text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                    descriptionText: "Lorem ipsum is simply dummy text of the printing and typesetting industry.",
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
