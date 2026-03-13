import SwiftUI

struct EyeTaskAnnouncementView: View {
    var body: some View {
        ResponseTemplateView(
            imageName: "night_sky", // Placeholder for night sky pixel art
            title: "Enjoy Dulu Yuk",
            subtitle: "Pegang handphone di tanganmu ya lalu putar pergelangan tanganmu biar rileks dulu nih yee",
            topContent: {
                Color.clear.frame(height: 20)
            },
            bottomContent: {
                PrimaryButton(title: "Yuk") {
                    // Navigate to EyeTaskTrackingView
                }
                .padding(.top, 20)
            }
        )
    }
}

#Preview {
    EyeTaskAnnouncementView()
}
