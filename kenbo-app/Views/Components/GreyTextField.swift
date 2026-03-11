import SwiftUI

struct GreyTextField: View {
    @Binding var text: String // Menggunakan Binding agar data bisa dikirim balik ke layar utama
    let placeholder: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .font(.system(size: 18, weight: .medium, design: .rounded))
            .padding(.horizontal, 20)
            .padding(.vertical, 18)
            // Latar belakang abu-abu muda sesuai gambar
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(red: 240/255, green: 240/255, blue: 240/255))
            )
            .padding(.horizontal)
    }
}

// Preview untuk melihat hasil
struct GreyTextField_Previews: PreviewProvider {
    static var previews: some View {
        // Kita gunakan .constant untuk preview saja
        GreyTextField(text: .constant(""), placeholder: "Masukkan Nama Panggilan...")
    }
}
