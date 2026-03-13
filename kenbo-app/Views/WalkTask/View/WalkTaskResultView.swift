import SwiftUI

struct WalkTaskResultView: View {
    var body: some View {
        ResponseTemplateView(
            title: "Jalan santay aja ya",
            subtitle: "Sambil lihat pemandangan atau ke kamar teman boleh kok chill aja kawan",
            topContent: {
                Color.clear.frame(height: 20)
            },
            centerContent: {
              
                VStack(spacing: 32) {
                 
                    TrackIndicator(iconType: .shoe)
                    TrackResultText(
                        calories: 30,
                        secondMetricValue: 20,
                        secondMetricLabel: "Step Goals",
                        secondMetricUnit: "Steps"
                    )
                }
                .padding(.top, 20)
            },
            bottomContent: {
                
                PrimaryButton(title: "Lanjut") {
                    // Finalize task action
                }
               
            }
        )
    }
}

#Preview {
    WalkTaskResultView()
}
