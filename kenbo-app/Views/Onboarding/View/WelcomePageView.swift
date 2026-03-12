import SwiftUI

struct WelcomePageView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            // Splash Image
            Image("Splash1")
                .resizable()
                .scaledToFit()
                .frame(width: 280, height: 220)
                .cornerRadius(20)
            
            // Welcome Text
            VStack {
                Text("Hola, Learner")
                    .font(.system(size: 32, weight: .bold))
                
                Text("Welcome to Kenbo")
                    .font(.system(size: 32, weight: .bold))
            }
            .multilineTextAlignment(.center)
            .padding(.horizontal, 30)
            .padding(.top, 45)
            
            // Description
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
                .font(.system(size: 16))
                .foregroundColor(Color(hex: "000000"))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 60)
                .padding(.top, 18)
            
            Spacer()
            Spacer()
        }
        .onAppear {
            // Auto navigate to session selection after 2.5 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                viewModel.navigateToNextPage()
            }
        }
    }
}
