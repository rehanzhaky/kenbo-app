import SwiftUI

struct PurpleTextField: View {
    @Binding var text: String
    let placeholder: String
    
    // Definisi Warna (Tanpa Hex)
    let innerBorderColor = Color(red: 100/255, green: 50/255, blue: 139/255) // Ungu Gelap
    let outerGlowColor = Color(red: 64/255, green: 156/255, blue: 255/255)   // Biru Muda
    
    var body: some View {
        TextField(placeholder, text: $text)
            .font(.system(size: 20, weight: .medium, design: .rounded))
            .padding(.horizontal, 20)
            .padding(.vertical, 18)
            .background(
                ZStack {
                    // Layer 1: Latar belakang putih
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                    
                    // Layer 2: Outline Biru Luar (Efek Glow/Seleksi)
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(outerGlowColor, lineWidth: 6)
                        .blur(radius: 1) // Sedikit blur agar tidak terlalu tajam
                    
                    // Layer 3: Border Ungu Dalam
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(innerBorderColor, lineWidth: 4)
                }
            )
            .padding(.horizontal)
    }
}

// Preview
struct PurpleTextField_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(red: 245/255, green: 245/255, blue: 245/255).ignoresSafeArea()
            PurpleTextField(text: .constant("Hafizh"), placeholder: "Tulis nama")
        }
    }
}
