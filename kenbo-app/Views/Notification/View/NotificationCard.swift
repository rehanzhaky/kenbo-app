import SwiftUI

struct NotificationCard: View {
    let userName: String
    let gender: String
    let message: String
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .top, spacing: 16) {
                // Avatar
                ProfileAvatar(gender: gender, size: min(geometry.size.width * 0.28, 120))
                    .padding(.leading, 6)
                
                // Content
                VStack(alignment: .leading, spacing: 6) {
                    // Title
                    Text("Hallo \(userName)")
                        .font(.custom("Montserrat-Bold", size: min(geometry.size.width * 0.08, 32)))
                        .foregroundColor(.black)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                    
                    // Message
                    Text(message)
                        .font(.custom("Montserrat-Regular", size: min(geometry.size.width * 0.04, 16)))
                        .foregroundColor(.black)
                        .lineSpacing(3)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.trailing, 12)
                .padding(.vertical, 6)
            }
            .padding(.horizontal, geometry.size.width * 0.04)
            .padding(.vertical, geometry.size.height * 0.12)
            .background(Color.white)
            .cornerRadius(35)
            .overlay(
                RoundedRectangle(cornerRadius: 35)
                    .stroke(Color.black, lineWidth: 3)
            )
        }
        .frame(height: 180)
        .padding(.horizontal, 16)
    }
}

#Preview {
    VStack {
        NotificationCard(
            userName: "Rehannn",
            gender: "Lelaki",
            message: "ini adalah test pesan notifikasi"
        )
    }
    .background(Color(hex: "F7F7F7"))
}
