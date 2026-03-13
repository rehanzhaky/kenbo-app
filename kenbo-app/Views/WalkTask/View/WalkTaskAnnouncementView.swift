import SwiftUI

struct WalkTaskAnnouncementView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ResponseTemplateView(
            imageName: "knight_walking", // Placeholder for the character walking
            title: "Jalan sebentar yuk",
            subtitle: "Jangan duduk dan rebahan terus yuk jalan jalan dulu lah biar enak sedikit ada peregangan wkwk",
            topContent: {
                Color.clear.frame(height: 20)
            },
            bottomContent: {
                PrimaryButton(title: "Gass") {
                    // Navigate to next page action
                }
                .padding(.top, 20)
            }
        )
    }
}

#Preview {
    WalkTaskAnnouncementView()
}
