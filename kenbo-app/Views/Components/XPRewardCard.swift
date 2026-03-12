import SwiftUI

struct XPRewardCard: View {
    // Warna tema cokelat (Tanpa Hex)
    let darkBrown = Color(red: 90/255, green: 65/255, blue: 45/255)
    let darkerBrown = Color(red: 60/255, green: 40/255, blue: 25/255)
    let purpleAccent = Color(red: 191/255, green: 104/255, blue: 255/255)
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 15) {
                // Kotak placeholder kiri
                RoundedRectangle(cornerRadius: 15)
                    .fill(darkerBrown)
                    .frame(width: 80, height: 80)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.6))
                        .lineLimit(3)
                }
                
                Spacer()
                
                // Ikon Panah Ungu dalam Lingkaran Putih
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 45, height: 45)
                    
                    Image(systemName: "chevron.up.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(purpleAccent)
                }
                .offset(y: -10) // Efek melayang sedikit keluar
            }
            .padding(20)
            
            // Bagian Tombol Bawah
            VStack {
                Text("Kumpulkan")
                    .font(.system(size: 16, weight: .bold))
                Text("30 XP lagi yuk !")
                    .font(.system(size: 18, weight: .bold))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 15)
            .background(darkerBrown.cornerRadius(15))
            .padding([.horizontal, .bottom], 12)
        }
        .background(darkBrown)
        .cornerRadius(25)
        .padding(.horizontal)
    }
}

// Preview
struct XPRewardCard_Previews: PreviewProvider {
    static var previews: some View {
        XPRewardCard()
    }
}
