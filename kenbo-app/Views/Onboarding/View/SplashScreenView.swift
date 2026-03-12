import SwiftUI

struct SplashScreenView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    
    var body: some View {
        if viewModel.showHome {
            HomeView(userName: viewModel.userName, gender: viewModel.selectedGender)
        } else {
            ZStack(alignment: .bottom) {
                TabView(selection: $viewModel.currentPage) {
                    // Page 1: Welcome Page
                    WelcomePageView(viewModel: viewModel)
                        .tag(0)
                    
                    // Page 2: Academy Session Selection
                    SessionSelectionView(viewModel: viewModel)
                        .tag(1)
                    
                    // Page 3: Name Input
                    NameInputView(viewModel: viewModel)
                        .tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                // Custom Page Indicator
                CustomPageIndicator(currentPage: viewModel.currentPage, pageCount: 3)
                    .padding(.bottom, 30)
            }
            .background(Color(hex: "F7F7F7"))
        }
    }
}

#Preview {
    SplashScreenView()
}
