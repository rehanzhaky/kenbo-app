//
//  HomeView.swift
//  kenbo-app
//
//  Created by Raihan Zhaky Al Hafizh on 11/03/26.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    
    init(userName: String, gender: String) {
        _viewModel = StateObject(wrappedValue: HomeViewModel(userName: userName, gender: gender))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                HStack {
                    // KENBO Logo text for now, assuming no image asset for logo
                        // A simple faux stroke effect
                    
                    Spacer()
                    
                    HStack(spacing: 8) {
                        PillBadgeView(text: "Lv. \(viewModel.userProfile.level)", style: .level)
                        PillBadgeView(text: "\(viewModel.userProfile.streak)", iconName: "flame.fill", style: .streak)
                    }
                }
                .padding(.top, 10)
                
                // Profile Card
                ProfileCard(
                    userName: viewModel.userProfile.name,
                    gender: viewModel.userProfile.gender,
                    currentXP: viewModel.userProfile.currentXP,
                    maxXP: viewModel.userProfile.maxXP,
                    completedTasks: viewModel.userProfile.completedTasks,
                    totalTasks: viewModel.userProfile.totalTasks
                )
                
                // Profile Title
                Text("Profile")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                
                // Profile Detail Section
                ProfileDetailCardView(
                    imageName: viewModel.characterStats.imageName,
                    healthCurrent: viewModel.characterStats.healthCurrent,
                    healthMax: viewModel.characterStats.healthMax,
                    powerCurrent: viewModel.characterStats.powerCurrent,
                    powerMax: viewModel.characterStats.powerMax,
                    staminaCurrent: viewModel.characterStats.staminaCurrent,
                    staminaMax: viewModel.characterStats.staminaMax,
                    onInfoTapped: {
                        // Action
                    },
                    onShareTapped: {
                        // Action
                    }
                )
                
                // Quest Title
                Text("Quest")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.top, 8)
                
                // Quest Description
                Text(viewModel.questDescription)
                    .font(.system(size: 14))
                    .foregroundColor(Color.App.Gray.primary)
                
                // Quest List (Horizontal Carousel)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(viewModel.questTasks) { task in
                            TaskCard(
                                icon: task.icon,
                                iconBackgroundColor: task.iconBackgroundColor,
                                cardBackgroundColor: task.cardBackgroundColor,
                                title: task.title,
                                currentProgress: task.currentProgress,
                                totalProgress: task.totalProgress,
                                progressBarColor: task.progressBarColor,
                                progressBarBackgroundColor: task.progressBarBackgroundColor,
                                shadowColor: task.shadowColor
                            )
                            .frame(width: 320) // Set a width for the cards in the carousel
                        }
                    }
                }
            }
            .padding(20)
            .padding(.bottom, 40) // extra bottom padding for scroll
        }
        .background(Color.App.Gray.light)
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            // Optional: load data if needed
        }
    }
}

#Preview {
    HomeView(userName: "Funday", gender: "Lelaki")
}
