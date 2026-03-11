import SwiftUI

struct SplashScreenView: View {
    @State private var currentPage = 0
    @State private var userName: String = ""
    @State private var selectedSession: String = ""
    @State private var showHome = false
    
    var body: some View {
        if showHome {
            HomeView()
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
                    NameInputPage(userName: $userName, showHome: $showHome)
                        .tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                // Custom Page Indicator
                CustomPageIndicator(currentPage: currentPage, pageCount: 3)
                    .padding(.bottom, 30)
            }
            .background(Color(UIColor.systemBackground))
        }
    }
}


// MARK: - Page 1: Welcome Page
struct WelcomePage: View {
    let userName: String
    @Binding var currentPage: Int
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            // Purple Rectangle
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(hex: "C59AE8"), Color(hex: "B88FDB")]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 280, height: 220)
            
            Spacer()
            
            // Welcome Text
            VStack(spacing: 10) {
                Text("Hola, Learner")
                    .font(.system(size: 32, weight: .bold))
                
                Text("Welcome to MyName")
                    .font(.system(size: 32, weight: .bold))
            }
            .multilineTextAlignment(.center)
            .padding(.horizontal, 30)
            
            // Description
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
                .font(.system(size: 16))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
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
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(hex: "C59AE8"), Color(hex: "B88FDB")]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 280, height: 220)
            
            Spacer()
            
            // Title
            Text("Choose your\nacademy session")
                .font(.system(size: 32, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
            
            // Session Buttons
            VStack(spacing: 16) {
                // Afternoon Button
                Button(action: {
                    selectedSession = "Afternoon"
                    // Auto navigate to next page after selection
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation {
                            currentPage = 2
                        }
                    }
                }) {
                    Text("Afternoon")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(selectedSession == "Afternoon" ? .black : .primary)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selectedSession == "Afternoon" ? Color.white : Color(UIColor.systemGray6))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(selectedSession == "Afternoon" ? Color.black : Color.clear, lineWidth: 2)
                        )
                }
                
                // Morning Button
                Button(action: {
                    selectedSession = "Morning"
                    // Auto navigate to next page after selection
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation {
                            currentPage = 2
                        }
                    }
                }) {
                    Text("Morning")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(12)
                }
            }
            .padding(.horizontal, 30)
            
            Spacer()
        }
    }
}




// MARK: - Page 3: Name Input
struct NameInputPage: View {
    @Binding var userName: String
    @Binding var showHome: Bool
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            // Purple Rectangle
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(hex: "C59AE8"), Color(hex: "B88FDB")]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 280, height: 220)
            
            Spacer()
            
            // Title
            Text("Tulis nama panggilanmu\nyuk !! biar lebih kenal nih")
                .font(.system(size: 28, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .fixedSize(horizontal: false, vertical: true)
            
            // Text Field
            TextField("Masukkan Nama Panggilan...", text: $userName)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal, 30)
            
            // Button
            Button(action: {
                if !userName.isEmpty {
                    withAnimation {
                        showHome = true
                    }
                }
            }) {
                Text("Lets go")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(12)
                    .padding(.horizontal, 30)
            }
            .disabled(userName.isEmpty)
            .opacity(userName.isEmpty ? 0.6 : 1.0)
            
            Spacer()
        }
    }
}

// MARK: - Custom Page Indicator
struct CustomPageIndicator: View {
    let currentPage: Int
    let pageCount: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<pageCount, id: \.self) { index in
                if index == currentPage {
                    // Active page - Rectangle (pill shape)
                    Capsule()
                        .fill(Color(hex: "9D6FCC"))
                        .frame(width: 32, height: 8)
                } else {
                    // Inactive page - Ellipse (circle)
                    Circle()
                        .fill(Color(hex: "D1D1D6"))
                        .frame(width: 8, height: 8)
                }
            }
        }
    }
}

// MARK: - Color Extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    SplashScreenView()
}
