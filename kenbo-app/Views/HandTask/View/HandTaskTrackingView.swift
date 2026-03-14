import SwiftUI

struct HandTaskTrackingView: View {
    @ObservedObject var viewModel: HandTaskViewModel
    
    var body: some View {
        ResponseTemplateView(
            title: "Putar Pergelangan\nTanganmu",
            subtitle: "Sambil nikmati tuh rileksnya dulu biar enak juga kan",
            topContent: {
                Color.clear.frame(height: 20)
            },
            centerContent: {
                TrackIndicator(iconType: .hand) {
                    VStack(spacing: 2) {
                        Text("\(viewModel.rotationCount)")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(Color.App.Purple.primary)
                        
                        Text("Putaran")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Color.App.Gray.primary)
                    }
                }
            },
            bottomContent: {
                VStack(spacing: 8) {
                    ProgressBar(
                        progress: viewModel.progress,
                        color: Color.App.Purple.primary,
                        backgroundColor: Color.App.Purple.light,
                        height: 20
                    )
                    .frame(width: 300)
                    
                    HStack {
                        Spacer()
                        Text(viewModel.progressLabel)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(Color.App.Purple.light)
                    }
                    .frame(width: 300)
                }
                .padding(.top, 40)
            }
        )
    }
}

#Preview {
    HandTaskTrackingView(viewModel: HandTaskViewModel(onComplete: { _ in }))
}
