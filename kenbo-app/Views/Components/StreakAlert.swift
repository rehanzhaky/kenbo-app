import SwiftUI

struct StreakAlert: View {
    // Parameter fleksibel agar badge ini bisa dipakai untuk angka lain
    let streakCount: Int
    
    // Definisi Warna Tema (Sesuai Gambar Tanpa Hex)
    // Ungu Terang: (191, 104, 255)
    let badgePurple = Color(red: 191/255, green: 104/255, blue: 255/255)
    
    // Oranye Api: (255, 149, 0)
    let flameOrange = Color(red: 255/255, green: 149/255, blue: 0/255)
    
    var body: some View {
        // VStack menumpuk ikon dan teks secara vertikal
        VStack(spacing: 20) {
            
            // LAYER IKON: Api di dalam Lingkaran Putih
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 80, height: 80) // Ukuran lingkaran putih
                
                // Jika kamu menggunakan SF Symbol (Native Apple)
                Image(systemName: "flame.fill")
                    .font(.system(size: 45)) // Ukuran ikon api SF Symbol
                    .foregroundColor(flameOrange)
                
                // Jika kamu menggunakan gambar aset buatan sendiri, gunakan ini:
                // Image("api") // Ganti "api" dengan nama di Assets.xcassets
                //     .resizable()
                //     .aspectRatio(contentMode: .fit)
                //     .frame(width: 45)
                //     .foregroundColor(flameOrange) // Berlaku jika gambar tersebut template image
            }
            .padding(.top, 25) // Ruang di atas lingkaran
            
            // LAYER TEKS: Angka dan Keterangan (Putih & Bold)
            Text("\(streakCount) Streak\nBeruntun")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .multilineTextAlignment(.center) // Agar teks rata tengah
                .padding(.bottom, 25) // Ruang di bawah teks
                .padding(.horizontal, 20) // Ruang samping teks
        }
        // Latar Belakang Kartu (Rounded Rectangle)
        .background(
            RoundedRectangle(cornerRadius: 35, style: .continuous)
                .fill(badgePurple)
        )
        // Batasan ukuran kartu agar tidak terlalu lebar
        .frame(maxWidth: 220)
        // Tambahkan padding luar agar tidak mepet layar
        .padding()
    }
}

// Preview untuk melihat hasil instan di Xcode Canvas
struct StreakAlert_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            // Latar belakang abu-abu muda agar badge ungu terlihat menonjol
            Color(.systemGroupedBackground).ignoresSafeArea()
            
            // Menggunakan komponen kita
            StreakAlert(streakCount: 5)
        }
    }
}
