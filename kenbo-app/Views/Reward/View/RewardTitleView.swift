import SwiftUI

struct RewardTitleView: View {
    @Environment(\.dismiss) var dismiss
    let userName: String
    
    var body: some View {
        ResponseTemplateView(
            imageName: "link_sprite",
            title: "Congratulation\n\(userName)",
            subtitle: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            topContent: {
                EarnTitleView(title: "Si Bugar")
            },
            bottomContent: {
                PrimaryButton(title: "Tutup") {
                    dismiss()
                }
            }
        )
    }
}

#Preview {
    RewardTitleView(userName: "Fandy")
}
