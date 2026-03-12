import SwiftUI

struct ProfileAvatar: View {
    let gender: String // "Lelaki" or "Perempuan"
    let size: CGFloat
    let showBorder: Bool
    
    init(gender: String, size: CGFloat = 80, showBorder: Bool = false) {
        self.gender = gender
        self.size = size
        self.showBorder = showBorder
    }
    
    var avatarImage: String {
        gender == "Lelaki" ? "Mask-Boy" : "Mask-Girl"
    }
    
    var body: some View {
        Image(avatarImage)
            .resizable()
            .scaledToFill()
            .frame(width: size, height: size)
            .clipShape(Circle())
            .overlay(
                showBorder ? Circle()
                    .stroke(Color(hex: "74409F"), lineWidth: 3) : nil
            )
    }
}

#Preview {
    HStack(spacing: 20) {
        ProfileAvatar(gender: "Lelaki")
        ProfileAvatar(gender: "Perempuan")
        ProfileAvatar(gender: "Lelaki", size: 120, showBorder: true)
    }
    .padding()
    .background(Color(hex: "F7F7F7"))
}
