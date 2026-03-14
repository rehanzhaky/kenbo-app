import SwiftUI

struct RewardTitleView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject private var prefs = UserPreferences.shared
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
                VStack(spacing: 16) {
                    PrimaryButton(
                        title: prefs.titleBadge == title ? "Gelar Dipakai" : "Pakai Gelar",
                        action: {
                            prefs.equipTitleBadge(title)
                        },
                        isDisabled: prefs.titleBadge == title
                    )
                    
                    SecondaryButton(title: "Tutup") {
                        dismiss()
                    }
                }
            }
        )
    }
}

#Preview {
    RewardTitleView(userName: "Fandy", title: "Ksatria Bugar")
}
