import SwiftUI

struct HeadTaskAnnouncementView: View {
    var body: some View {
        ResponseTemplateView(
            imageName: "enjoy_truck", // Placeholder for truck pixel art
            title: "Enjoy Dulu Yuk",
            subtitle: "Pegang handphone di tanganmu ya lalu putar pergelangan tanganmu biar rileks dulu nih yee",
            topContent: {
                Color.clear.frame(height: 20)
            },
            bottomContent: {
                PrimaryButton(title: "Yuk") {
                    // Navigate to HeadTaskTrackingView
                }
                .padding(.top, 20)
            }
        )
    }
}

#Preview {
    HeadTaskAnnouncementView()
}
