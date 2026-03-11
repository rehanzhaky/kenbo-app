import SwiftUI

struct OnboardingView: View {
    
    @State private var currentPage = 0
    @State private var showHome = false
    
    var body: some View {
        
        if showHome {
            HomeView()
        } else {
            VStack {
                
                TabView(selection: $currentPage) {
                    
                    OnboardingPage(
                        image: "sparkles",
                        title: "Hola, Learner Welcome to MyName",
                        description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
                    )
                    .tag(0)
                    
                    OnboardingPage(
                        image: "checkmark.circle",
                        title: "Stay Organized",
                        description: "Manage your tasks easily."
                    )
                    .tag(1)
                    
                    OnboardingPage(
                        image: "bolt.fill",
                        title: "Boost Productivity",
                        description: "Achieve more with Kenbo."
                    )
                    .tag(2)
                    
                }
                .tabViewStyle(PageTabViewStyle())
                
                Spacer()
                
                if currentPage == 2 {
                    Button(action: {
                        showHome = true
                    }) {
                        Text("Get Started")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .padding(.horizontal)
                    }
                }
                
                Spacer()
            }
        }
    }
}
