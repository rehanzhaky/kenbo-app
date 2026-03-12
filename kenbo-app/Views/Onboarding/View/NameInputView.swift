import SwiftUI

struct NameInputView: View {
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
            Text("Tulis nama panggilanmu\nyuk !! biar lebih kenal nih")
                .font(.system(size: 28, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .fixedSize(horizontal: false, vertical: true)
            
            // Text Field
            CustomTextField(placeholder: "Masukkan Nama Panggilan...", text: $viewModel.userName)
                .frame(width: 328)
            
            // Gender Selection
            HStack(spacing: 40) {
                RadioButtonWithLabel(label: "Lelaki", isSelected: viewModel.selectedGender == "Lelaki") {
                    viewModel.selectedGender = "Lelaki"
                }
                
                RadioButtonWithLabel(label: "Perempuan", isSelected: viewModel.selectedGender == "Perempuan") {
                    viewModel.selectedGender = "Perempuan"
                }
            }
            
            // Button
            PrimaryButton(title: "Lets go", isDisabled: viewModel.userName.isEmpty) {
                viewModel.finishOnboarding()
            }
            
            Spacer()
        }
    }
}
