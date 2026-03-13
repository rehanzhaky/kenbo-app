import SwiftUI

struct ResponseTemplateView<TopContent: View, CenterContent: View, BottomContent: View>: View {
    let title: String
    let subtitle: String
    
    let topContent: TopContent
    let centerContent: CenterContent
    let bottomContent: BottomContent
    
    let backgroundColor: Color
    let titleColor: Color
    let subtitleColor: Color
    
    // Core initializer for maximum flexibility
    init(
        title: String,
        subtitle: String,
        backgroundColor: Color = .white,
        titleColor: Color = .black,
        subtitleColor: Color = Color.App.Gray.primary,
        @ViewBuilder topContent: () -> TopContent,
        @ViewBuilder centerContent: () -> CenterContent,
        @ViewBuilder bottomContent: () -> BottomContent
    ) {
        self.title = title
        self.subtitle = subtitle
        self.backgroundColor = backgroundColor
        self.titleColor = titleColor
        self.subtitleColor = subtitleColor
        self.topContent = topContent()
        self.centerContent = centerContent()
        self.bottomContent = bottomContent()
    }
    
    // Optimized initializer for standard image-based center content (Announcement pages)
    init(
        imageName: String,
        title: String,
        subtitle: String,
        backgroundColor: Color = .white,
        titleColor: Color = .black,
        subtitleColor: Color = Color.App.Gray.primary,
        @ViewBuilder topContent: () -> TopContent,
        @ViewBuilder bottomContent: () -> BottomContent
    ) where CenterContent == AnyView {
        self.init(
            title: title,
            subtitle: subtitle,
            backgroundColor: backgroundColor,
            titleColor: titleColor,
            subtitleColor: subtitleColor,
            topContent: topContent,
            centerContent: {
                AnyView(
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 280, height: 280)
                        .clipShape(RoundedRectangle(cornerRadius: 32)) // More premium radius
                )
            },
            bottomContent: bottomContent
        )
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Top Slot
            topContent
                .padding(.top, 20)
            
            Spacer(minLength: 20)
            
            // Center Slot
            centerContent
                .frame(maxWidth: .infinity)
            
            Spacer(minLength: 32)
            
            // Title & Subtitle
            VStack(spacing: 12) {
                Text(title)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(titleColor)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                
                Text(subtitle)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(subtitleColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32) // More breathing room
                    .lineSpacing(2)
            }
            
            Spacer(minLength: 40)
            
            // Bottom Slot
            bottomContent
                .padding(.bottom, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColor.ignoresSafeArea())
    }
}

#Preview {
    ResponseTemplateView(
        imageName: "night_sky",
        title: "Enjoy Dulu Yuk",
        subtitle: "Pegang handphone di tanganmu ya lalu putar pergelangan tanganmu biar rileks dulu nih yee",
        topContent: { Color.clear.frame(height: 20) },
        bottomContent: {
            PrimaryButton(title: "Yuk") {}
                .padding(.horizontal, 40)
        }
    )
}
