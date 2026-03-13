import SwiftUI

struct WalkTaskTrackingView: View {
    @State private var steps: Int = 10
    
    var body: some View {
        ResponseTemplateView(
            title: "Jalan santay aja ya",
            subtitle: "Sambil lihat pemandangan atau ke kamar teman boleh kok chill aja kawan",
            topContent: {
                Color.clear.frame(height: 20)
            },
            centerContent: {
                TrackIndicator(iconType: .shoe) {
                    TrackText(value: steps, unit: "Steps")
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

#Preview {
    WalkTaskTrackingView()
}
