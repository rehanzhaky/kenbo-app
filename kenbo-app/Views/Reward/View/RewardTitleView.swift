import SwiftUI

struct RewardTitleView: View {
    @Environment(\.dismiss) var dismiss
    let userName: String
    let title: String
    
    var body: some View {
        ResponseTemplateView(
            imageName: "link_sprite",
            title: "Selamat Untukmu\n\(userName)",
            subtitle: "Kamu telah berhasil mendapatkan gelar baru karena konsistensimu xixi!",
            topContent: {
                EarnTitleView(title: title)
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
    RewardTitleView(userName: "Fandy", title: "Ksatria Bugar")
}
