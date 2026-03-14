import SwiftUI

struct WalkTaskAnnouncementView: View {
    @ObservedObject var viewModel: WalkTaskViewModel
    
    var body: some View {
        ResponseTemplateView(
            imageName: "knight_walking", // Placeholder for the character walking
            title: "Jalan Sebentar Yuk",
            subtitle: "Jangan duduk dan rebahan terus, yuk jalan-jalan dulu biar otot nggak kaku dan peredaran darah lancar!",
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
    WalkTaskAnnouncementView(viewModel: WalkTaskViewModel(onComplete: { _ in }))
}
