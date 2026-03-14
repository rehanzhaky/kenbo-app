import SwiftUI

struct InfoView: View {
    let userName: String
    let gender: String
    let onDismiss: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                // Header
                VStack(alignment: .leading, spacing: 12) {
                    Text("Info")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.black)
                    
                    HStack(spacing: 8) {
                        PillBadgeView(text: "Lv. 20", style: .level)
                        PillBadgeView(text: "5", iconName: "flame.fill", style: .streak)
                    }
                }
                .padding(.top, 20)
                
                Text("Level dan Streak membantu kamu melacak kemajuan harianmu dalam meningkatkan kesehatan mata, leher, dan tubuh.")
                    .font(.system(size: 14))
                    .foregroundColor(Color.App.Gray.primary)
                
                // Profile Section
                ProfileCard(
                    userName: userName,
                    gender: gender,
                    currentXP: 200,
                    maxXP: 300,
                    completedTasks: 4,
                    totalTasks: 7,
                    titleBadge: "Si Bugar",
                    onTap: {}
                )
                
                Text("Profil kamu menampilkan ringkasan XP yang terkumpul serta jumlah tugas yang telah kamu selesaikan hari ini.")
                    .font(.system(size: 14))
                    .foregroundColor(Color.App.Gray.primary)
                
                // Character Stats Section
                ProfileDetailCardView(
                    imageName: "link_sprite",
                    healthCurrent: 200, healthMax: 300,
                    powerCurrent: 250, powerMax: 300,
                    staminaCurrent: 180, staminaMax: 300,
                    onInfoTapped: {},
                    onShareTapped: {}
                )
                
                Text("Statistik karakter kamu terdiri dari Health, Power, dan Stamina. Statistik ini akan meningkat seiring dengan keberhasilanmu menyelesaikan berbagai misi.")
                    .font(.system(size: 14))
                    .foregroundColor(Color.App.Gray.primary)
                
                // Task Section - Incomplete
                TaskCard(
                    icon: "system:heart.text.square.fill",
                    iconBackgroundColor: Color(hex: "8B4444"),
                    cardBackgroundColor: Color(hex: "FE7171"),
                    title: "Selesaikan misi harian untuk menjaga kesehatan mata dan tubuh kamu setiap saat.",
                    currentProgress: 1,
                    totalProgress: 2,
                    unit: "Kali",
                    shadowColor: Color(hex: "9C3B3B")
                )
                
                // Task Section - Complete
                TaskCard(
                    icon: "system:checkmark.seal.fill",
                    iconBackgroundColor: Color(hex: "8B5E33"),
                    cardBackgroundColor: Color(hex: "FEB871"),
                    title: "Misi yang telah selesai akan memberikan bonus XP untuk meningkatkan level kamu.",
                    currentProgress: 5,
                    totalProgress: 5,
                    unit: "Kali",
                    shadowColor: Color(hex: "B0763C")
                )
                
                Text("Cek daftar misi di bagian bawah untuk melihat apa saja yang perlu dilakukan. Setiap misi yang selesai akan memberimu XP!")
                    .font(.system(size: 14))
                    .foregroundColor(Color.App.Gray.primary)
                
                // Rewards Section
                VStack(spacing: 20) {
                    RewardCardView(
                        text: "Kumpulkan hadiah spesial dengan rajin menyelesaikan misi setiap harinya.",
                        iconName: "book.fill",
                        style: .blue
                    ) {}
                    
                    RewardCardView(
                        text: "Dapatkan hadiah terkunci",
                        iconName: "lock.fill",
                        style: .purple,
                        isLocked: true,
                        unlockMessage: "Kumpulkan\n30 XP lagi yuk!"
                    ) {}
                    
                    RewardCardView(
                        text: "Dapatkan hadiah terkunci",
                        iconName: "lock.fill",
                        style: .red,
                        isLocked: true,
                        unlockMessage: "Kumpulkan\n5 Streak lagi yuk!"
                    ) {}
                }
                
                Text("Jangan lupa untuk mengecek menu Reward! Banyak hadiah menarik yang menunggu untuk kamu buka dengan mencapai target tertentu.")
                    .font(.system(size: 14))
                    .foregroundColor(Color.App.Gray.primary)
                
                // Close Button
                PrimaryButton(title: "Tutup") {
                    onDismiss()
                }
                .padding(.top, 10)
                
                Spacer(minLength: 50)
            }
            .padding(.horizontal, 24)
        }
        .background(Color.App.Gray.light)
    }
}

#Preview {
    InfoView(userName: "Funday", gender: "Lelaki", onDismiss: {})
}
