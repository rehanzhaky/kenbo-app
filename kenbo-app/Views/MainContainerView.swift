import SwiftUI

struct MainContainerView: View {
    @State private var selectedTab: Tab = .home
    @State private var isNavBarVisible: Bool = true
    @State private var isMini: Bool = false
    @State private var lastScrollOffset: CGFloat = 0
    @State private var inactivityTask: Task<Void, Never>? = nil
    
    let userName: String
    let gender: String
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Content
            Group {
                switch selectedTab {
                case .home:
                    HomeView(userName: userName, gender: gender)
                case .rewards:
                    RewardView(userName: userName, gender: gender)
                case .settings:
                    SettingsView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { offset in
                handleScroll(offset: offset)
            }
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        resetInactivityTimer()
                    }
            )
            
            // Navigation Bar
            FloatingNavBar(selectedTab: $selectedTab, isVisible: $isNavBarVisible, isMini: $isMini)
                .onChange(of: selectedTab) { _ in
                    resetInactivityTimer()
                }
                .onChange(of: isMini) { mini in
                    if !mini {
                        resetInactivityTimer()
                    }
                }
        }
        .ignoresSafeArea(.keyboard)
        .onAppear {
            resetInactivityTimer()
        }
    }
    
    private func resetInactivityTimer() {
        inactivityTask?.cancel()
        
        // Don't auto-hide if it's already hidden or mini
        // But we want it to *become* mini after inactivity
        withAnimation {
            isMini = false
        }
        
        inactivityTask = Task {
            try? await Task.sleep(nanoseconds: 5 * 1_000_000_000) // 5 seconds
            if !Task.isCancelled {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                    isMini = true
                }
            }
        }
    }
    
    private func handleScroll(offset: CGFloat) {
        resetInactivityTimer()
        
        let delta = offset - lastScrollOffset
        
        // If scrolling down (offset decreasing) and past a threshold, hide
        if delta < -10 && offset < -50 {
            if isNavBarVisible {
                withAnimation {
                    isNavBarVisible = false
                }
            }
        } 
        // If scrolling up (offset increasing) or near top, show
        else if delta > 10 || offset > -20 {
            if !isNavBarVisible {
                withAnimation {
                    isNavBarVisible = true
                }
            }
        }
        
        lastScrollOffset = offset
    }
}

#Preview {
    MainContainerView(userName: "Funday", gender: "Lelaki")
}
