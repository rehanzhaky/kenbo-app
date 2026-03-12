import SwiftUI

struct MotivationCard: View {
    
    // Definisi Warna Tema (Sesuai Gambar Tanpa Hex)
    // Ungu Latar Belakang: (123, 75, 175)
    let backgroundPurple = Color(red: 123/255, green: 75/255, blue: 175/255)
    
    // Warna Teks Putih standar
    
    var body: some View {
        // VStack menumpuk gambar dan teks secara vertikal
        VStack(spacing: 25) {
            
            // LAYER GAMBAR: Gambar Kucing Pixel Art
            Image("pixel_cat") // Ganti dengan nama di Assets.xcassets
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(20) // Sudut membulat pada gambar
                .padding(.top, 30) // Ruang di atas gambar
            
            // LAYER JUDUL: "Yuk kita Push up!" (Bold & Bulat)
            Text("Yuk kita Push up!")
                .font(.system(size: 26, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .multilineTextAlignment(.center) // Agar teks rata tengah
            
            // LAYER DESKRIPSI: Instruksi Detail (Medium & Bulat)
            Text("Arahkan hpmu ke arah bawah sekarang dan jika sudah siap jangan lupa tekan tombolnya ya")
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundColor(.white)
                .multilineTextAlignment(.center) // Agar teks rata tengah
                .padding(.horizontal, 20) // Ruang samping teks
                .padding(.bottom, 30) // Ruang di bawah teks
        }
        // Latar Belakang Kartu (Rounded Rectangle)
        .background(
            RoundedRectangle(cornerRadius: 35, style: .continuous)
                .fill(backgroundPurple)
        )
        // Batasan ukuran kartu agar tidak terlalu lebar
        .frame(maxWidth: 320)
        // Tambahkan padding luar agar tidak mepet layar
        .padding()
    }
}

// Preview untuk melihat hasil instan di Xcode Canvas
struct MotivationCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            // Latar belakang abu-abu muda agar kartu ungu terlihat menonjol
            Color(.systemGroupedBackground).ignoresSafeArea()
            
            // Menggunakan komponen kita
            MotivationCard()
        }
    }
}
