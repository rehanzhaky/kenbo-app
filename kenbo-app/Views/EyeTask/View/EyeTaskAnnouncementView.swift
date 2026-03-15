import SwiftUI

struct EyeTaskAnnouncementView: View {
    @ObservedObject var viewModel: EyeTaskViewModel
    @State private var isEyeOpen = true

    var body: some View {
        ResponseTemplateView(
            title: "Istirahatkan Matamu",
            subtitle: "Tatap layar lurus, lalu kedipkan matamu beberapa kali sesuai instruksi. Biar mata tetap segar dan fokus!",
            topContent: {
                Color.clear.frame(height: 20)
            },
            centerContent: {
                Image(isEyeOpen ? "EyeOpen1" : "EyeClosed1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 280, height: 280)
                    .clipShape(RoundedRectangle(cornerRadius: 32))
                    .onAppear {
                        startBlinkAnimation()
                    }
            },
            bottomContent: {
                PrimaryButton(title: "Yuk") {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        viewModel.beginTracking()
                    }
                }
                .padding(.top, 20)
            }
        )
    }
    
    private func startBlinkAnimation() {
        // Schedule random blinks
        scheduleNextBlink()
    }
    
    private func scheduleNextBlink() {
        // Random interval between 2-4 seconds
        let interval = Double.random(in: 1.0...2.0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            // Quick blink
            isEyeOpen = false
            
            // Open eye again after 0.15 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                isEyeOpen = true
                // Schedule next blink
                scheduleNextBlink()
            }
        }
    }
}

#Preview {
    EyeTaskAnnouncementView(viewModel: EyeTaskViewModel(onComplete: { _ in }))
}
