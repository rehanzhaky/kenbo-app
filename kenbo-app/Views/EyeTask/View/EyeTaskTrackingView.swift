import SwiftUI

struct EyeTaskTrackingView: View {
    @ObservedObject var viewModel: EyeTaskViewModel
    @State private var isPulsing = false

    var body: some View {
        ResponseTemplateView(
            title: "Fokuskan Matamu\nke Layar",
            subtitle: "Rileks dan ikuti gerakan yang ada di layar ya, biar matamu segar kembali",
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
                        Image(systemName: "eye.fill")
                            .font(.system(size: 48))
                            .foregroundColor(.white.opacity(0.6))
                        Text("Scanning...")
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
    EyeTaskTrackingView(viewModel: EyeTaskViewModel(onComplete: { _ in }))
}
