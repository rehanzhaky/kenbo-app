import SwiftUI

struct HeadTaskAnnouncementView: View {
    @ObservedObject var viewModel: HeadTaskViewModel
    
    var body: some View {
        ResponseTemplateView(
            imageName: "enjoy_truck", // Placeholder for truck pixel art
            title: "Putar Kepala\nKiri & Kanan",
            subtitle: "Rileks sejenak, ikuti instruksi putar kepalamu ke kiri dan kanan untuk menyegarkan lehermu.",
            topContent: {
                Color.clear.frame(height: 20)
            },
            bottomContent: {
                PrimaryButton(title: "Yuk") {
                    viewModel.beginTracking()
                }
                .padding(.top, 20)
            }
        )
    }
}

#Preview {
    HeadTaskAnnouncementView(viewModel: HeadTaskViewModel(onComplete: { _ in }))
}
