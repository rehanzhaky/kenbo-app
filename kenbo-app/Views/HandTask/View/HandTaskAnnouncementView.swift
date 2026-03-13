import SwiftUI

struct HandTaskAnnouncementView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ResponseTemplateView(
            imageName: "hand_stretch", // Placeholder for hand stretching pixel art
            title: "Peregangan Yuk",
            subtitle: "Pegang handphone di tanganmu ya lalu putar pergelangan tanganmu biar rileks dulu nih yee",
            topContent: {
                Color.clear.frame(height: 20)
            },
            bottomContent: {
                PrimaryButton(title: "Gass") {
                    // Navigate to HandTaskTrackingView
                }
                .padding(.top, 20)
            }
        )
    }
}

#Preview {
    HandTaskAnnouncementView()
}
