import SwiftUI

struct EyeTaskResultView: View {
    @ObservedObject var viewModel: EyeTaskViewModel

    var body: some View {
        ResponseTemplateView(
            title: "Bagus Banget",
            subtitle: "Kamu telah melakukan peregangan area mata mu semoga sehat terus ya",
            topContent: {
                Color.clear.frame(height: 20)
            },
            centerContent: {
                TrackIndicator(iconType: .eye) {
                    VStack(spacing: 4) {
                        Text("Blink Goals")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.black)
                        
                        HStack(alignment: .lastTextBaseline, spacing: 4) {
                            Text("20")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(Color.App.Purple.primary)
                            
                            Text("Blink")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(Color.App.Gray.primary)
                        }
                    }
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
    EyeTaskResultView(viewModel: EyeTaskViewModel(onComplete: { _ in }))
}
