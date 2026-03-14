import SwiftUI

struct LevelUpOverlayView: View {
    let newLevel: Int
    let onDismiss: () -> Void
    
    @State private var bounceBase = false
    @State private var showParticles = false
    
    var body: some View {
        ZStack {
            // Dark transparent background
            Color.black.opacity(0.6)
                .ignoresSafeArea()
                .onTapGesture {
                    onDismiss()
                }
            
            VStack(spacing: 32) {
                Text("Level Up!")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 4)
                
                // Badge Animation Container
                ZStack {
                    // Celebration particles
                    if showParticles {
                        Circle()
                            .stroke(Color.yellow, lineWidth: 4)
                            .frame(width: 150, height: 150)
                            .scaleEffect(1.5)
                            .opacity(0.0)
                            .animation(.easeOut(duration: 0.8).repeatForever(autoreverses: false), value: showParticles)
                    }
                    
                    // The level badge
                    ZStack {
                        Circle()
                            .fill(Color.App.Yellow.primary)
                            .frame(width: 140, height: 140)
                            .shadow(color: Color.black.opacity(0.2), radius: 0, x: 0, y: 8)
                        
                        Circle()
                            .stroke(Color.white, lineWidth: 6)
                            .frame(width: 120, height: 120)
                        
                        VStack(spacing: -5) {
                            Text("Lv")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                            Text("\(newLevel)")
                                .font(.system(size: 56, weight: .heavy))
                                .foregroundColor(.white)
                        }
                    }
                    .scaleEffect(bounceBase ? 1.0 : 0.5)
                    .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0), value: bounceBase)
                }
                
                Text("Karaktermu makin kuat! Teruskan rutinitas sehatmu biar levelnya mentok.")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                PrimaryButton(title: "Mantap!") {
                    onDismiss()
                }
                .padding(.top, 20)
            }
        }
        .onAppear {
            bounceBase = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                showParticles = true
            }
        }
    }
}

#Preview {
    LevelUpOverlayView(newLevel: 2, onDismiss: {})
}
