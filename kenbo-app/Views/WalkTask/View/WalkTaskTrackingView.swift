import SwiftUI

struct WalkTaskTrackingView: View {
    @ObservedObject var viewModel: WalkTaskViewModel
    
    var body: some View {
        ResponseTemplateView(
            title: "Jalan santay aja ya",
            subtitle: "Sambil lihat pemandangan atau ke kamar teman boleh kok chill aja kawan",
            topContent: {
                Color.clear.frame(height: 20)
            },
            centerContent: {
                TrackIndicator(iconType: .shoe) {
                    TrackText(value: viewModel.stepsTaken, unit: "Steps")
                }
                .onTapGesture {
                    // Hidden helper for Simulator testing
                    #if targetEnvironment(simulator)
                    viewModel.invokeDebugStep()
                    #endif
                }
            },
            bottomContent: {
                VStack(spacing: 8) {
                    ProgressBar(
                        progress: viewModel.progress,
                        color: Color.App.Purple.primary,
                        backgroundColor: Color.App.Purple.light,
                        height: 20,
                        text: "\(viewModel.stepsTaken) / \(viewModel.stepGoal) Steps",
                        textColor: .white
                    )
                    .frame(width: 300)
                }
                .padding(.top, 40)
            }
        )
    }
}

#Preview {
    WalkTaskTrackingView(viewModel: WalkTaskViewModel(onComplete: { _ in }))
}
