import SwiftUI

struct HeadTaskResultView: View {
    var body: some View {
        ResponseTemplateView(
            title: "Bagus Banget",
            subtitle: "Kamu telah melakukan peregangan area leher mu semoga sehat terus ya",
            topContent: {
                Color.clear.frame(height: 20)
            },
            centerContent: {
                VStack(spacing: 32) {
                    TrackIndicator(iconType: .head)
                    
                    TrackResultText(
                        calories: 30,
                        secondMetricValue: 20,
                        secondMetricLabel: "Exercised Goals",
                        secondMetricUnit: "Rotation"
                    )
                }
                .padding(.top, 20)
            },
            bottomContent: {
                PrimaryButton(title: "Lanjut") {
                    // Finalize head task action
                }
            }
        )
    }
}

#Preview {
    HeadTaskResultView()
}
