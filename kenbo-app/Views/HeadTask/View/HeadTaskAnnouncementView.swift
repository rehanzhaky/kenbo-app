import SwiftUI

struct HeadTaskAnnouncementView: View {
    @ObservedObject var viewModel: HeadTaskViewModel
    
    var body: some View {
        ResponseTemplateView(
            imageName: "enjoy_truck", // Placeholder for truck pixel art
            title: "Peregangan\nLeher Dulu",
            subtitle: "Rileks sejenak! Ikuti instruksi untuk memutar kepalamu perlahan ke kiri dan kanan biar leher nggak pegal.",
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
