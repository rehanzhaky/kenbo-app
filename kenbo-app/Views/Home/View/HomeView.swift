//
//  HomeView.swift
//  kenbo-app
//
//  Created by Raihan Zhaky Al Hafizh on 11/03/26.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    
    // Drawer State
    @State private var drawerOffset: CGFloat = 0
    @State private var lastOffset: CGFloat = 0
    @State private var isExpanded: Bool = false
    
    // Constants for drawer positioning
    private let collapsedOffset: CGFloat = 680 // Increased to show all profile UI
    private let expandedOffset: CGFloat = 100
    
    init(userName: String, gender: String) {
        _viewModel = StateObject(wrappedValue: HomeViewModel(userName: userName, gender: gender))
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                // Main Static Content (Scrollable under drawer)
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        // Header
                        HStack {
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
                            onInfoTapped: {},
                            onShareTapped: {}
                        )
                        
                        // Padding to ensure content isn't hidden by the collapsed drawer
                        Color.clear.frame(height: 150)
                    }
                    .padding(.horizontal, 20)
                }
                .disabled(isExpanded) // Disable scroll when drawer is up
                .opacity(isExpanded ? 0.3 : 1.0)
                .animation(.easeInOut, value: isExpanded)
                
                // Quest Drawer (Interactive Section)
                ZStack(alignment: .top) {
                    // Background Layers (Stacked Effect)
                    RoundedRectangle(cornerRadius: 35)
                        .fill(Color.App.Purple.dark)
                        .offset(y: -5)
                        .padding(.horizontal, 8)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        // Handle Bar for Dragging
                        HStack {
                            Spacer()
                            RoundedRectangle(cornerRadius: 3)
                                .fill(Color.App.Gray.primary)
                                .frame(width: 40, height: 6)
                            Spacer()
                        }
                        .padding(.top, 12)
                        
                        // Quest Title
                        Text("Quest")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.black)
                        
                        // Quest Description
                        Text(viewModel.questDescription)
                            .font(.system(size: 14))
                            .foregroundColor(Color.App.Gray.primary)
                            .lineLimit(isExpanded ? nil : 3)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        // Quest List (Vertical)
                        ScrollView(isExpanded ? .vertical : .init()) {
                            VStack(spacing: 20) {
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
                                }
                            }
                        }
                        .disabled(!isExpanded) // Only scroll if expanded
                    }
                    .padding(.horizontal, 32)
                    .padding(.bottom, 100)
                    .background(Color.white)
                    .clipShape(RoundedCornerShape(radius: 48, corners: [.topLeft, .topRight]))
                }
                .offset(y: drawerOffset == 0 ? (isExpanded ? expandedOffset : collapsedOffset) : drawerOffset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            let startPos = isExpanded ? expandedOffset : collapsedOffset
                            let newOffset = startPos + value.translation.height
                            
                            // Resist pulling too far up or down
                            if newOffset > expandedOffset {
                                drawerOffset = newOffset
                            }
                        }
                        .onEnded { value in
                            let velocity = value.predictedEndTranslation.height
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                                if velocity < -100 || drawerOffset < (collapsedOffset + expandedOffset) / 2 {
                                    isExpanded = true
                                    drawerOffset = 0
                                } else {
                                    isExpanded = false
                                    drawerOffset = 0
                                }
                            }
                        }
                )
            }
            .background(Color.App.Gray.light)
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

// Helper Shape for specific corners
struct RoundedCornerShape: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
    HomeView(userName: "Funday", gender: "Lelaki")
}
