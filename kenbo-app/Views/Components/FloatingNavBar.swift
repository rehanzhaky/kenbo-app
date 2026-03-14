import SwiftUI

enum Tab: String {
    case home = "Home"
    case rewards = "Reward"
    case settings = "Settings"
    
    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .rewards: return "star.fill"
        case .settings: return "person.fill"
        }
    }
}

struct FloatingNavBar: View {
    @Binding var selectedTab: Tab
    @Binding var isVisible: Bool
    @Binding var isMini: Bool
    
    var body: some View {
        HStack {
            if isMini {
                // Mini State
                Button {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                        isMini = false
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color.App.Purple.dark)
                        .frame(width: 50, height: 50)
                        .background(
                            ZStack {
                                BlurView(style: .systemThinMaterialLight)
                                Capsule()
                                    .stroke(Color.white.opacity(0.5), lineWidth: 0.5)
                            }
                        )
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 5, y: 0)
                }
                .transition(.move(edge: .leading).combined(with: .opacity))
                .padding(.leading, 10)
                Spacer()
            } else {
                // Full State
                Spacer()
                HStack(spacing: 40) {
                    tabButton(for: .home)
                    tabButton(for: .rewards)
                    tabButton(for: .settings)
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 15)
                .background(
                    ZStack {
                        // Glassmorphism effect - Light version
                        BlurView(style: .systemThinMaterialLight)
                            .clipShape(Capsule())
                        
                        Capsule()
                            .stroke(Color.white.opacity(0.5), lineWidth: 0.5)
                    }
                )
                .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 10)
                .transition(.asymmetric(
                    insertion: .move(edge: .leading).combined(with: .opacity),
                    removal: .move(edge: .leading).combined(with: .opacity)
                ))
                Spacer()
            }
        }
        .offset(y: isVisible ? 0 : 150)
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isVisible)
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isMini)
        .padding(.bottom, 20)
    }
    
    private func tabButton(for tab: Tab) -> some View {
        Button {
            withAnimation(.spring()) {
                selectedTab = tab
            }
        } label: {
            VStack(spacing: 4) {
                Image(systemName: tab.icon)
                    .font(.system(size: 24))
                    .foregroundColor(selectedTab == tab ? Color.App.Purple.dark : Color.App.Gray.primary.opacity(0.6))
                
                if selectedTab == tab {
                    Text(tab.rawValue)
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(Color.App.Purple.dark)
                }
            }
        }
        .buttonStyle(.plain)
    }
}

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

#Preview {
    ZStack {
        Color.App.Gray.light.ignoresSafeArea()
        VStack {
            Spacer()
            FloatingNavBar(selectedTab: .constant(.home), isVisible: .constant(true), isMini: .constant(false))
        }
    }
}
