import SwiftUI

struct WhiteButton: View {
    let title: String
    let action: () -> Void
    
    // Nilai RGB Ungu Gelap (64328B) dalam desimal:
    // R: 100/255, G: 50/255, B: 139/255
    let purpleTheme = Color(red: 100/255, green: 50/255, blue: 139/255)
    
    var body: some View {
        Button(action: action) {
            ZStack {
                // LAYER 1: Bayangan / Elevasi Bawah (Ungu Gelap)
                RoundedRectangle(cornerRadius: 20)
                    .fill(purpleTheme)
                    .offset(y: 8)

                // LAYER 2: Tombol Utama Atas (Putih Bersih)
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    
                // LAYER 3: Teks (Ungu Gelap)
                Text(title)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(purpleTheme)
            }
            .frame(height: 60)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
    }
}

// Preview untuk melihat hasil instan di Xcode
struct WhiteButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            // Menggunakan komponen
            WhiteButton(title: "TEXT BUTTON") {
                print("Elevated Button Tapped")
            }
            Spacer()
        }
        .background(Color(.systemGroupedBackground)) // Background abu-abu muda agar tombol terlihat
    }
}
