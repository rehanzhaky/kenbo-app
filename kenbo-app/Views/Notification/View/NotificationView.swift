import SwiftUI

struct NotificationView: View {
    let userName: String
    let gender: String
    @StateObject private var viewModel = NotificationViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background
                Color(hex: "F7F7F7")
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: geometry.size.height * 0.02) {
                        // Header
                        Text("Notifikasi")
                            .font(.custom("Montserrat-Bold", size: min(geometry.size.width * 0.07, 28)))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, geometry.size.width * 0.06)
                            .padding(.top, geometry.size.height * 0.025)
                            .padding(.bottom, geometry.size.height * 0.01)
                        
                        // Main Notification Card
                        NotificationCard(
                            userName: userName,
                            gender: gender,
                            message: "ini adalah test pesan notifikasi"
                        )
                        
                        // Additional notifications if any
                        ForEach(viewModel.notifications) { notification in
                            NotificationCard(
                                userName: notification.userName,
                                gender: gender,
                                message: notification.message
                            )
                        }
                        
                        Spacer(minLength: geometry.size.height * 0.025)
                    }
                    .padding(.bottom, geometry.size.height * 0.04)
                }
            }
        }
    }
}

#Preview {
    NotificationView(
        userName: "Rehannn",
        gender: "Lelaki"
    )
}
