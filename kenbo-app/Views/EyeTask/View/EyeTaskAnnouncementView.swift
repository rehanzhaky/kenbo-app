import SwiftUI

struct EyeTaskAnnouncementView: View {
    @ObservedObject var viewModel: EyeTaskViewModel

    var body: some View {
        ResponseTemplateView(
            imageName: "night_sky",
            title: "Istirahatkan Matamu",
            subtitle: "Tatap layar lurus, lalu kedipkan matamu beberapa kali sesuai instruksi. Biar mata tetap segar dan fokus!",
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
