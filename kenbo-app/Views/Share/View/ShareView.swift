import SwiftUI

struct ShareView: View {
    let userName: String
    let gender: String
    let characterStats: CharacterStats
    let userProfile: UserProfile
    let onDismiss: () -> Void
    
    @State private var isSharing = false
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 32) {
                    // Header Branding
                    HStack(spacing: 12) {
                        Image("avatar_male") // Using default for now
                            .resizable()
                            .frame(width: 44, height: 44)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.App.Purple.dark, lineWidth: 1))
                        
                        Text("KENBO")
                            .font(.system(size: 28, weight: .black))
                            .foregroundColor(Color.App.Purple.dark)
                    }
                    .padding(.top, 40)
                    
                    // Profile Card Preview
                    ProfileCard(
                        userName: userProfile.name,
                        gender: userProfile.gender,
                        currentXP: userProfile.currentXP,
                        maxXP: userProfile.maxXP,
                        completedTasks: userProfile.completedTasks,
                        totalTasks: userProfile.totalTasks,
                        titleBadge: "Si Bugar", // Placeholder or dynamic if available
                        onTap: {}
                    )
                    
                    // Character Detail Preview (Hide buttons)
                    ProfileDetailCardView(
                        imageName: characterStats.imageName,
                        healthCurrent: characterStats.healthCurrent,
                        healthMax: characterStats.healthMax,
                        powerCurrent: characterStats.powerCurrent,
                        powerMax: characterStats.powerMax,
                        staminaCurrent: characterStats.staminaCurrent,
                        staminaMax: characterStats.staminaMax,
                        onInfoTapped: {},
                        onShareTapped: {},
                        showButtons: false
                    )
                    
                    // Engagement Text
                    VStack(spacing: 16) {
                        Text("Yuk jaga kesehatan")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.black)
                        
                        Text("Mari kita jaga tubuh agar tetap sehat dengan cara yang menyenangkan bersama kenbo.")
                            .font(.system(size: 16))
                            .foregroundColor(Color.App.Gray.primary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                    }
                    
                    Spacer(minLength: 50)
                }
                .padding(.horizontal, 24)
            }
            
            // Bottom Buttons
            VStack(spacing: 16) {
                PrimaryButton(title: "Bagikan") {
                    isSharing = true
                }
                
                SecondaryButton(title: "Ga jadi deh") {
                    onDismiss()
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
            .background(Color.white)
        }
        .background(Color.white) // Using white for a card-like clean feel for sharing
        .sheet(isPresented: $isSharing) {
            let message = "Ayo jaga kesehatan bareng aku di Kenbo! 🚀 Aku sudah mencapai Level \(userProfile.level) dengan \(userProfile.streak) hari Streak. Yuk, join sekarang!"
            ShareSheet(activityItems: [message])
        }
    }
}

#Preview {
    ShareView(
        userName: "Funday",
        gender: "Lelaki",
        characterStats: CharacterStats(
            healthCurrent: 200, healthMax: 300,
            powerCurrent: 200, powerMax: 300,
            staminaCurrent: 200, staminaMax: 300,
            imageName: "link_sprite"
        ),
        userProfile: UserProfile(
            name: "Funday",
            gender: "Lelaki",
            level: 20,
            streak: 5,
            currentXP: 200,
            maxXP: 300,
            completedTasks: 4,
            totalTasks: 7,
            titleBadge: "Si Bugar"
        ),
        onDismiss: {}
    )
}
