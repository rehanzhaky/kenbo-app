import SwiftUI

struct EarnXPView: View {
    @Environment(\.dismiss) var dismiss
    let questID: String
    let userName: String
    let earnedAmount: Int
    let onComplete: (Int) -> Void
    
    init(questID: String, userName: String, earnedAmount: Int, onComplete: @escaping (Int) -> Void) {
        self.questID = questID
        self.userName = userName
        self.earnedAmount = earnedAmount
        self.onComplete = onComplete
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
                    // Finalize flow via delegated closure
                    onComplete(earnedAmount)
                    dismiss()
                }
            }
        )
    }
}

#Preview {
    EarnXPView(
        questID: "quest_walk",
        userName: "Fandy",
        earnedAmount: 250,
        onComplete: { _ in }
    )
}
