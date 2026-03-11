import SwiftUI

struct PurpleButton: View {
    // Parameter yang bisa disesuaikan
    let title: String
    let action: () -> Void
    
    // Spesifikasi Warna (Sesuai Gambar)
    let primaryColor = Color(red: 191/255, green: 104/255, blue: 255/255) // Ungu Terang
    let shadowColor = Color(red: 100/255, green: 50/255, blue: 139/255)    // Ungu Gelap Kaku
    
    // Dimensi (Bisa disesuaikan tapi ini standar yang bagus)
    let cornerRadius: CGFloat = 20
    let elevationOffset: CGFloat = 8 // Ketebalan elevasi/shadow
    
    var body: some View {
        Button(action: action) {
            // Kita menggunakan ZStack untuk menumpuk elemen
            ZStack {
                // LAYER 1: Bayangan / Elevasi Bawah (Warna Ungu Gelap)
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(shadowColor)
                    // Geser ke bawah untuk menciptakan efek 3D kaku
                    .offset(y: elevationOffset)

                // LAYER 2: Tombol Utama Atas (Warna Ungu Terang)
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(primaryColor)
                    
                // LAYER 3: Teks di Atas Tombol
                Text(title)
                    // Teks sangat tebal dan bulat sesuai gambar
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
            }
            .frame(height: 60) // Tinggi tombol standar yang nyaman
        }
        // Pastikan frame Button-nya pas dengan ZStack
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        // Tambahkan padding vertikal ekstra agar shadow offset tidak terpotong
        .padding(.vertical, elevationOffset / 2)
    }
}

// Preview untuk melihat hasil instan di Xcode
struct PurpleButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            // Menggunakan komponen
            PurpleButton(title: "MULAI SEKARANG") {
                print("Elevated Button Tapped")
            }
            Spacer()
        }
        .background(Color(.systemGroupedBackground)) // Background abu-abu muda agar tombol terlihat
    }
}
