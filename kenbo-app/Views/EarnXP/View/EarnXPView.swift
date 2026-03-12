import SwiftUI

struct EarnXPView: View {
    @Environment(\.dismiss) var dismiss
    let userName: String
    let earnedAmount: Int
    
    init(userName: String, earnedAmount: Int = 20) {
        self.userName = userName
        self.earnedAmount = earnedAmount
    }
    
    var body: some View {
        ResponseTemplateView(
            imageName: "knight_xp", // Placeholder for the knight pixel art
            title: "Congratulation\n\(userName)",
            subtitle: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            topContent: {
                EarnBadgeView(amount: earnedAmount)
            },
            bottomContent: {
                PrimaryButton(title: "Yeayy") {
                    dismiss()
                }
            }
        )
    }
}

#Preview {
    EarnXPView(userName: "Fandy")
}
