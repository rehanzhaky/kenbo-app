import SwiftUI

struct HandTaskAnnouncementView: View {
    @ObservedObject var viewModel: HandTaskViewModel
    
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
                    viewModel.beginTracking()
                }
                .padding(.top, 20)
            }
        )
    }
}

#Preview {
    HandTaskAnnouncementView(viewModel: HandTaskViewModel(onComplete: { _ in }))
}
