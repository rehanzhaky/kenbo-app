import SwiftUI

struct StreakMissionCard: View {
    // Warna tema abu-abu (Tanpa Hex)
    let cardGray = Color(red: 95/255, green: 95/255, blue: 95/255)
    let flameOrange = Color(red: 255/255, green: 149/255, blue: 0/255)
    
    var body: some View {
        VStack(spacing: 20) {
            // Ikon Api dalam Lingkaran Putih
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 60, height: 60)
                
                Image(systemName: "flame.fill")
                    .font(.system(size: 30))
                    .foregroundColor(flameOrange)
            }
            
            VStack(spacing: 5) {
                Text("Kumpulkan")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                Text("5 Streak lagi yuk !")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
            }
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 30)
        .background(cardGray)
        .cornerRadius(35)
        .padding(.horizontal)
    }
}
// Preview
struct StreakMissionCard_Previews: PreviewProvider {
    static var previews: some View {
        StreakMissionCard()
    }
}

