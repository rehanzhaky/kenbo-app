import SwiftUI

struct WalkTaskResultView: View {
    @ObservedObject var viewModel: WalkTaskViewModel
    
    var body: some View {
        ResponseTemplateView(
            title: "Jalan santay aja ya",
            subtitle: "Sambil lihat pemandangan atau ke kamar teman boleh kok chill aja kawan",
            topContent: {
                Color.clear.frame(height: 20)
            },
            centerContent: {
              
                VStack(spacing: 32) {
                    TrackIndicator(iconType: .shoe)
                    TrackResultText(
                        calories: 30, // Could be calculated based on steps
                        secondMetricValue: viewModel.stepsTaken,
                        secondMetricLabel: "Step Goals",
                        secondMetricUnit: "Steps"
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
    WalkTaskAnnouncementView(viewModel: WalkTaskViewModel(onComplete: { _ in }))
}
