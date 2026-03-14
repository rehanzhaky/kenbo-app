import SwiftUI

struct InfoView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 12) {
                    HStack {
                        Text("Info")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.black)
                        Spacer()
                    }

                    HStack(spacing: 10) {
                        PillBadgeView(text: "Lv. 20", style: .level)
                        PillBadgeView(text: "5", iconName: "flame.fill", style: .streak)
                        Spacer()
                    }

                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the")
                        .font(.system(size: 14))
                        .foregroundColor(Color.App.Gray.primary)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                }

                // Profile Card
                ProfileCard(
                    userName: "Funday",
                    gender: "Lelaki",
                    currentXP: 200,
                    maxXP: 300,
                    completedTasks: 4,
                    totalTasks: 7
                )

                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry and has been the")
                    .font(.system(size: 14))
                    .foregroundColor(Color.App.Gray.primary)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)

                // Character detail card
                ProfileDetailCardView(
                    imageName: "link_sprite",
                    healthCurrent: 200,
                    healthMax: 300,
                    powerCurrent: 200,
                    powerMax: 300,
                    staminaCurrent: 200,
                    staminaMax: 300,
                    onInfoTapped: {},
                    onShareTapped: {}
                )

                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry and has been the")
                    .font(.system(size: 14))
                    .foregroundColor(Color.App.Gray.primary)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)

                // Task cards section
                VStack(spacing: 16) {
                    TaskCard(
                        icon: "heart-pulse",
                        iconBackgroundColor: Color(hex: "8B4444"),
                        cardBackgroundColor: Color(hex: "FE7171"),
                        title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                        currentProgress: 1,
                        totalProgress: 2,
                        progressBarColor: Color(hex: "6CA8FF"),
                        progressBarBackgroundColor: Color(hex: "D5E5FF"),
                        shadowColor: Color(hex: "9C3B3B")
                    )

                    TaskCard(
                        icon: "food-turkey",
                        iconBackgroundColor: Color(hex: "8B5E33"),
                        cardBackgroundColor: Color(hex: "FEB871"),
                        title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                        currentProgress: 5,
                        totalProgress: 5,
                        progressBarColor: Color(hex: "FF9B5E"),
                        progressBarBackgroundColor: Color(hex: "FFD4B3"),
                        shadowColor: Color(hex: "B0763C")
                    )
                }

                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the")
                    .font(.system(size: 14))
                    .foregroundColor(Color.App.Gray.primary)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)

                // Reward cards section
                VStack(spacing: 16) {
                    // Standard reward card (blue)
                    RewardCardView(
                        text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                        descriptionText: "Lorem ipsum is simply dummy text of the printing and typesetting industry.",
                        iconName: "book.fill",
                        buttonTitle: "Lihat",
                        style: .blue,
                        variant: .standard
                    ) {}

                    // Overlay-style reward cards
                    RewardCardView(
                        text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                        descriptionText: "Lorem ipsum is simply dummy text of the printing and typesetting industry.",
                        iconName: "arrow.up",
                        buttonTitle: "Kumpulkan 30 XP lagi yuk!",
                        style: .red,
                        isLocked: false,
                        variant: .overlayIcon
                    ) {}

                    RewardCardView(
                        text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                        descriptionText: "Lorem ipsum is simply dummy text of the printing and typesetting industry.",
                        iconName: "flame.fill",
                        buttonTitle: "Kumpulkan 5 Streak lagi yuk!",
                        style: .orange,
                        isLocked: true,
                        variant: .overlayIcon
                    ) {}
                }

                PrimaryButton(title: "Tutup") {
                    // TODO: close or dismiss action
                }
                .padding(.bottom, 40)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
        .background(Color.white.ignoresSafeArea())
    }
}

#Preview {
    InfoView()
}
