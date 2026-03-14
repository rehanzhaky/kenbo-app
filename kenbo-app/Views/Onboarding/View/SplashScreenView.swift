import SwiftUI

struct SplashScreenView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    
    var body: some View {
        Group {
            if viewModel.showHome {
                MainContainerView(
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
                .background(Color(hex: "F7F7F7"))
            }
        }


#Preview {
    SplashScreenView()
}
