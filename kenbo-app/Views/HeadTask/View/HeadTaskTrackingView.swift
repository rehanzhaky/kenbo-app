import SwiftUI

struct HeadTaskTrackingView: View {
    @ObservedObject var viewModel: HeadTaskViewModel
    @State private var isPulsing = false
    
    var body: some View {
        ResponseTemplateView(
            title: "Putar Kepala\ndulu ya",
            subtitle: "Sambil nikmati tuh rileksnya dulu biar enak juga kan",
            backgroundColor: Color.App.Purple.primary,
            titleColor: .white,
            subtitleColor: Color.App.Purple.light,
            topContent: {
                Color.clear.frame(height: 20)
            },
            centerContent: {
                ZStack {
                    // Outer pulse ring
                    Circle()
                        .stroke(Color.white.opacity(0.25), lineWidth: 12)
                        .frame(width: 280, height: 280)
                        .scaleEffect(isPulsing ? 1.08 : 1.0)
                        .opacity(isPulsing ? 0.4 : 0.7)
                        .animation(
                            .easeInOut(duration: 1.2).repeatForever(autoreverses: true),
                            value: isPulsing
                        )

                    // Real Camera Scan
                    ARFaceView()
                        .frame(width: 260, height: 260)
                        .clipShape(Circle())
                    
                    Circle()
                        .stroke(Color.white, lineWidth: 6)
                        .frame(width: 260, height: 260)
                        
                    // Scan line animation
                    VStack(spacing: 4) {
                        Image(systemName: "face.smiling.fill")
                            .font(.system(size: 48))
                            .foregroundColor(.white.opacity(0.6))
                        Text("Tengok Kiri & Kanan...")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white.opacity(0.7))
                    }
                }
                .onAppear { isPulsing = true }
            },
            bottomContent: {
                VStack(spacing: 8) {
                    ProgressBar(
                        progress: viewModel.progress,
                        color: .white,
                        backgroundColor: Color.App.Purple.light.opacity(0.5),
                        height: 20,
                        text: viewModel.progressLabel,
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
    HeadTaskTrackingView(viewModel: HeadTaskViewModel(onComplete: { _ in }))
}
