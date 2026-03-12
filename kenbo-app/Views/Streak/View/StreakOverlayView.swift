import SwiftUI

struct StreakOverlayView: View {
    @ObservedObject var viewModel: StreakViewModel
    var onDismiss: () -> Void
    
    var body: some View {
        ZStack {
            // Background Purple Gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "BE71FE"),
                    Color(hex: "A77BED")
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                // Flame Icon
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 140, height: 140)
                    
                    Image(systemName: "flame.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .foregroundColor(Color(hex: "F5A65B"))
                }
                .padding(.bottom, 30)
                
                // Streak Count Text
                Text("\(viewModel.currentStreak) Streak")
                    .font(.custom("Montserrat-Bold", size: 36))
                    .foregroundColor(.white)
                
                Text("Beruntun")
                    .font(.custom("Montserrat-Bold", size: 36))
                    .foregroundColor(.white)
                    .padding(.bottom, 40)
                
                // Streak Range Component
                StreakRange()
                    .padding(.bottom, 50)
                
                // Congratulation Text
                Text("Wow Kamu Streak lagi")
                    .font(.custom("Montserrat-Bold", size: 28))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 16)
                
                // Description Text
                Text("Arahkan hpmu ke arah bawah sekarang\ndan jika sudah siap jangan lupa tekan\ntombolnya ya")
                    .font(.custom("Montserrat-Regular", size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 60)
                
                // Button
                SecondaryButton(title: "Yokk Gass") {
                    onDismiss()
                }
                .padding(.bottom, 40)
                
                Spacer()
            }
        }
    }
}

#Preview {
    StreakOverlayView(
        viewModel: StreakViewModel(),
        onDismiss: {}
    )
}
