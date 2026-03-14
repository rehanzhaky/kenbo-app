import SwiftUI

struct HandTaskResultView: View {
    @ObservedObject var viewModel: HandTaskViewModel
    
    var body: some View {
        ResponseTemplateView(
            title: "Jalan santay aja ya",
            subtitle: "Sambil lihat pemandangan atau ke kamar teman boleh kok chill aja kawan",
            topContent: {
                Color.clear.frame(height: 20)
            },
            centerContent: {
                VStack(spacing: 32) {
                    TrackIndicator(iconType: .hand)
                    
                    TrackResultText(
                        calories: 30,
                        secondMetricValue: 20,
                        secondMetricLabel: "Movement Goals",
                        secondMetricUnit: "Movement"
                    )
                }
                .padding(.top, 20)
            },
            bottomContent: {
                PrimaryButton(title: "Lanjut") {
                    viewModel.finishTask()
                }
            }
        )
    }
}

#Preview {
    HandTaskResultView(viewModel: HandTaskViewModel(onComplete: { _ in }))
}
