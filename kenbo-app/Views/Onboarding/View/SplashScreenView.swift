import SwiftUI

struct SplashScreenView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    
    /// Tracks whether we've checked UserDefaults yet.
    /// Prevents a flicker where the onboarding briefly appears before we route away.
    @State private var isReady: Bool = false
    
    var body: some View {
        Group {
            if !isReady {
                // Blank screen while we resolve the route
                Color(hex: "F7F7F7").ignoresSafeArea()
            } else if viewModel.showHome {
                HomeView(
                    userName: viewModel.userName,
                    gender: viewModel.selectedGender
                )
            } else {
                // Onboarding flow
                ZStack(alignment: .bottom) {
                    TabView(selection: $viewModel.currentPage) {
                        WelcomePageView(viewModel: viewModel)
                            .tag(0)
                        
                        SessionSelectionView(viewModel: viewModel)
                            .tag(1)
                        
                        NameInputView(viewModel: viewModel)
                            .tag(2)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    
                    CustomPageIndicator(currentPage: viewModel.currentPage, pageCount: 3)
                        .padding(.bottom, 30)
                }
                .background(Color(hex: "F7F7F7"))
            }
        }
        .onAppear {
            // Check if user has already completed onboarding
            if UserPreferences.shared.hasCompletedOnboarding {
                // Jump straight to Home with the persisted user data
                viewModel.userName       = UserPreferences.shared.userName
                viewModel.selectedGender = UserPreferences.shared.selectedGender
                withAnimation {
                    viewModel.showHome = true
                }
            }
            isReady = true
        }
    }
}

#Preview {
    SplashScreenView()
}
