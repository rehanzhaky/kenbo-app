import SwiftUI

struct EyeTaskAnnouncementView: View {
    @ObservedObject var viewModel: EyeTaskViewModel

    var body: some View {
        ResponseTemplateView(
            imageName: "night_sky",
            title: "Enjoy Dulu Yuk",
            subtitle: "Pegang handphone di tanganmu ya lalu putar pergelangan tanganmu biar rileks dulu nih yee",
            topContent: {
                Color.clear.frame(height: 20)
            },
            bottomContent: {
                PrimaryButton(title: "Yuk") {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        viewModel.beginTracking()
                    }
                }
                .padding(.top, 20)
            }
        )
    }
}

#Preview {
    EyeTaskAnnouncementView(viewModel: EyeTaskViewModel(onComplete: { _ in }))
}
