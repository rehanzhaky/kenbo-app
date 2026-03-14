import SwiftUI
import UIKit

struct ShareView: View {
    // Placeholder state for share action
    @State private var isSharing: Bool = false

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                // Profile Header
                ProfileCard(
                    userName: "Funday",
                    gender: "Lelaki",
                    currentXP: 200,
                    maxXP: 300,
                    completedTasks: 4,
                    totalTasks: 7
                )
                .padding(.top, 16)

                // Character stats card
                ProfileDetailCardView(
                    imageName: "link_sprite",
                    healthCurrent: 200,
                    healthMax: 300,
                    powerCurrent: 200,
                    powerMax: 300,
                    staminaCurrent: 200,
                    staminaMax: 300,
                    onInfoTapped: {
                        // TODO: implement info action
                    },
                    onShareTapped: {
                        isSharing = true
                    }
                )

                // Message
                VStack(spacing: 10) {
                    Text("Yuk jaga kesehatan")
                        .font(.custom("Montserrat-Bold", size: 28))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)

                    Text("Mari kita jaga tubuh agar tetap sehat dengan cara yang menyenangkan bersama kenbo.")
                        .font(.custom("Montserrat-Regular", size: 16))
                        .foregroundColor(Color.App.Gray.primary)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .padding(.horizontal, 20)
                }
                .padding(.top, 16)

                // Actions
                VStack(spacing: 16) {
                    PrimaryButton(title: "Bagikan") {
                        isSharing = true
                    }

                    SecondaryButton(title: "Ga jadi deh") {
                        // TODO: implement cancel
                    }
                }
                .padding(.bottom, 40)
            }
            .padding(.horizontal, 20)
        }
        .background(Color.white.ignoresSafeArea())
        .sheet(isPresented: $isSharing) {
            ActivityView(activityItems: ["Ayo jaga kesehatan bersama Kenbo!"])
        }
    }
}

// Simple wrapper for iOS share sheet
struct ActivityView: UIViewControllerRepresentable {
    let activityItems: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

#Preview {
    ShareView()
}
