import SwiftUI

struct SplashScreenView: View {
    @State private var currentPage = 0
    @State private var userName: String = ""
    @State private var selectedSession: String = ""
    @State private var selectedGender: String = "Lelaki"
    @State private var showHome = false
    
    var body: some View {
        if showHome {
            HomeView(userName: userName, gender: selectedGender)
        } else {
            ZStack(alignment: .bottom) {
                TabView(selection: $currentPage) {
                    // Page 1: Welcome Page
                    WelcomePage(userName: userName, currentPage: $currentPage)
                        .tag(0)
                    
                    // Page 2: Academy Session Selection
                    SessionSelectionPage(selectedSession: $selectedSession, currentPage: $currentPage)
                        .tag(1)
                    
                    // Page 3: Name Input
                    NameInputPage(userName: $userName, selectedGender: $selectedGender, showHome: $showHome)
                        .tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                // Custom Page Indicator
                CustomPageIndicator(currentPage: currentPage, pageCount: 3)
                    .padding(.bottom, 30)
            }
            .background(Color(hex: "F7F7F7"))
        }
    }
}


// MARK: - Page 1: Welcome Page
struct WelcomePage: View {
    let userName: String
    @Binding var currentPage: Int
    
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
            VStack() {
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
                withAnimation {
                    currentPage = 1
                }
            }
        }
    }
}

// MARK: - Page 2: Session Selection
struct SessionSelectionPage: View {
    @Binding var selectedSession: String
    @Binding var currentPage: Int
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            // Purple Rectangle
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
                    selectedSession = "Afternoon"
                    // Auto navigate to next page after selection
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation {
                            currentPage = 2
                        }
                    }
                }
                
                // Morning Button
                PrimaryButton(title: "Morning") {
                    selectedSession = "Morning"
                    // Auto navigate to next page after selection
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation {
                            currentPage = 2
                        }
                    }
                }
            }
            
            Spacer()
        }
    }
}




// MARK: - Page 3: Name Input
struct NameInputPage: View {
    @Binding var userName: String
    @Binding var selectedGender: String
    @Binding var showHome: Bool
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            // Purple Rectangle
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
            CustomTextField(placeholder: "Masukkan Nama Panggilan...", text: $userName)
                .frame(width: 328)
            
            // Gender Selection
            HStack(spacing: 40) {
                RadioButtonWithLabel(label: "Lelaki", isSelected: selectedGender == "Lelaki") {
                    selectedGender = "Lelaki"
                }
                
                RadioButtonWithLabel(label: "Perempuan", isSelected: selectedGender == "Perempuan") {
                    selectedGender = "Perempuan"
                }
            }
            
            // Button
            PrimaryButton(title: "Lets go", isDisabled: userName.isEmpty) {
                if !userName.isEmpty {
                    withAnimation {
                        showHome = true
                    }
                }
            }
            
            Spacer()
        }
    }
}

#Preview {
    SplashScreenView()
}
