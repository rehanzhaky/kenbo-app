import SwiftUI

struct RewardMotivationView: View {
    @Environment(\.dismiss) var dismiss
    let content: String
    let onRefresh: () -> Void
    
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
                        Text("Motivasi Hari Ini")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text(content)
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.white.opacity(0.9))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                            .italic()
                    }
                    .padding(.bottom, 32)
                }
                .background(Color.App.Purple.dark)
                .cornerRadius(12)
                .padding(.horizontal, 40)
                
                // Action Buttons
                VStack(spacing: 12) {
                    PrimaryButton(title: "Cari Motivasi Lain xixi") {
                        onRefresh()
                    }
                    
                    Button("Tutup") {
                        dismiss()
                    }
                    .foregroundColor(Color.App.Gray.primary)
                    .font(.system(size: 16, weight: .bold))
                }
                .padding(.top, 20)
            }
        }
    }
}

#Preview {
    RewardMotivationView(content: "Semangat xixi!", onRefresh: {})
}
