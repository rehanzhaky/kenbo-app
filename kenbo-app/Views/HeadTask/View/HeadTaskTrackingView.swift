import SwiftUI

struct HeadTaskTrackingView: View {
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
                    // Camera Scanning Placeholder
                    Circle()
                        .fill(Color(hex: "D9D9D9")) // Gray placeholder
                        .frame(width: 260, height: 260)
                    
                    Circle()
                        .stroke(Color.white, lineWidth: 6)
                        .frame(width: 260, height: 260)
                }
            },
            bottomContent: {
                VStack(spacing: 8) {
                    ProgressBar(
                        progress: 0.5,
                        color: .white,
                        backgroundColor: Color.App.Purple.light.opacity(0.5),
                        height: 20,
                        text: "1 Menit",
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
    HeadTaskTrackingView()
}
