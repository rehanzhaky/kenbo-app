import SwiftUI

struct HeadTaskAnnouncementView: View {
    @ObservedObject var viewModel: HeadTaskViewModel
    @State private var isShowingLeftNeck = true
    
    var body: some View {
        ResponseTemplateView(
            title: "Peregangan\nLeher Dulu",
            subtitle: "Rileks sejenak! Ikuti instruksi untuk memutar kepalamu perlahan ke kiri dan kanan biar leher nggak pegal.",
            topContent: {
                Color.clear.frame(height: 20)
            },
            centerContent: {
                Image(isShowingLeftNeck ? "NeckLeft1" : "NeckRight1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 280, height: 280)
                    .clipShape(RoundedRectangle(cornerRadius: 32))
                    .animation(.easeInOut(duration: 0.6), value: isShowingLeftNeck)
                    .onAppear {
                        startNeckAnimation()
                    }
            },
            bottomContent: {
                PrimaryButton(title: "Yuk") {
                    viewModel.beginTracking()
                }
                .padding(.top, 20)
            }
        )
    }
    
    private func startNeckAnimation() {
        Timer.scheduledTimer(withTimeInterval: 1.2, repeats: true) { _ in
            isShowingLeftNeck.toggle()
        }
    }
}

#Preview {
    HeadTaskAnnouncementView(viewModel: HeadTaskViewModel(onComplete: { _ in }))
}
