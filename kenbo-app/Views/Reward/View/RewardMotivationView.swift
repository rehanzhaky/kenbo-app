import SwiftUI

struct RewardMotivationView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.App.white.ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Motivation Card
                VStack(spacing: 24) {
                    Image("cat_motivation") // Placeholder for motivation image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 250, height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.top, 24)
                    
                    VStack(spacing: 8) {
                        Text("Yuk kita Push up!")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("Arahkan hpmu ke arah bawah sekarang dan jika sudah siap jangan lupa tekan tombolnya ya")
                            .font(.system(size: 14))
                            .foregroundColor(.white.opacity(0.8))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                    }
                    .padding(.bottom, 32)
                }
                .background(Color.App.Purple.dark)
                .cornerRadius(12)
                .padding(.horizontal, 40)
                
                // Close Button
                PrimaryButton(title: "Tutup") {
                    dismiss()
                }
                .padding(.top, 20)
            }
        }
    }
}

#Preview {
    RewardMotivationView()
}
