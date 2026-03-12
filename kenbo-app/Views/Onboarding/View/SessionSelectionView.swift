import SwiftUI

struct SessionSelectionView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            // Splash Image
            Image("Splash1")
                .resizable()
                .scaledToFit()
                .frame(width: 280, height: 220)
                .cornerRadius(20)
            
            Spacer()
            
            // Title
            Text("Choose your\nacademy session")
                .font(.system(size: 32, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
            
            // Session Buttons
            VStack(spacing: 16) {
                // Afternoon Button
                SecondaryButton(title: "Afternoon") {
                    viewModel.selectSession("Afternoon")
                }
                
                // Morning Button
                PrimaryButton(title: "Morning") {
                    viewModel.selectSession("Morning")
                }
            }
            
            Spacer()
        }
    }
}
