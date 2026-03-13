import SwiftUI

struct HandTaskTrackingView: View {
    @State private var movements: Int = 10
    var isRightHand: Bool = false
    
    var body: some View {
        ResponseTemplateView(
            title: isRightHand ? "Gantian Tangan Kanan" : "Pelan aja ya",
            subtitle: "Sambil nikmati tuh rileksnya dulu biar enak juga kan",
            topContent: {
                Color.clear.frame(height: 20)
            },
            centerContent: {
                TrackIndicator(iconType: .hand) {
                    VStack(spacing: 2) {
                        Text("\(movements)")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(Color.App.Purple.primary)
                        
                        Text("Movements")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Color.App.Gray.primary)
                    }
                }
            },
            bottomContent: {
                VStack(spacing: 8) {
                    ProgressBar(
                        progress: 0.5,
                        color: Color.App.Purple.primary,
                        backgroundColor: Color.App.Purple.light,
                        height: 20
                    )
                    .frame(width: 300)
                    
                    HStack {
                        Spacer()
                        Text("10 Menit")
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

#Preview("Left Hand") {
    HandTaskTrackingView(isRightHand: false)
}

#Preview("Right Hand") {
    HandTaskTrackingView(isRightHand: true)
}
