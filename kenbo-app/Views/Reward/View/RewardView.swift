import SwiftUI

struct RewardView: View {
    @StateObject private var viewModel: RewardViewModel
    
    // Drawer State
    @State private var drawerOffset: CGFloat = 0
    @State private var isExpanded: Bool = false
    
    // Constants for drawer positioning
    private let collapsedOffset: CGFloat = 240 // Positioned closer to Profile Card
    private let expandedOffset: CGFloat = 60
    
    init(userName: String, gender: String) {
        _viewModel = StateObject(wrappedValue: RewardViewModel(userName: userName, gender: gender))
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                // Background Section
                VStack(spacing: 24) {
                    // Profile Card
                    ProfileCard(
                        userName: viewModel.userProfile.name,
                        gender: viewModel.userProfile.gender,
                        currentXP: viewModel.userProfile.currentXP,
                        maxXP: viewModel.userProfile.maxXP,
                        completedTasks: viewModel.userProfile.completedTasks,
                        totalTasks: viewModel.userProfile.totalTasks
                    )
                }
                .padding(.horizontal, 20)
                .padding(.top, 40)
                .opacity(isExpanded ? 0.3 : 1.0)
                .animation(.easeInOut, value: isExpanded)
                
                // Reward Drawer
                ZStack(alignment: .top) {
                    // Background Stacked Effect
                    RoundedRectangle(cornerRadius: 35)
                        .fill(Color.App.Purple.dark)
                        .offset(y: -5)
                        .padding(.horizontal, 8)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        // Handle Bar
                        HStack {
                            Spacer()
                            RoundedRectangle(cornerRadius: 3)
                                .fill(Color.App.Gray.primary)
                                .frame(width: 40, height: 6)
                            Spacer()
                        }
                        .padding(.top, 12)
                        
                        // Title
                        Text("Reward")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.black)
                        
                        // Description
                        Text(viewModel.rewardDescription)
                            .font(.system(size: 14))
                            .foregroundColor(Color.App.Gray.primary)
                            .lineLimit(isExpanded ? nil : 3)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        // Reward List
                        ScrollView(isExpanded ? .vertical : .init()) {
                            VStack(spacing: 20) {
                                ForEach(viewModel.rewards) { reward in
                                    RewardCardView(
                                        text: reward.title,
                                        iconName: reward.icon,
                                        buttonTitle: reward.buttonTitle,
                                        style: reward.style
                                    ) {
                                        viewModel.activeDetail = reward.type
                                    }
                                }
                            }
                        }
                        .disabled(!isExpanded)
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
            .fullScreenCover(item: $viewModel.activeDetail) { type in
                switch type {
                case .motivation:
                    RewardMotivationView()
                case .story:
                    RewardStoryView()
                case .title:
                    RewardTitleView(userName: viewModel.userProfile.name)
                }
            }
        }
    }
}

#Preview {
    RewardView(userName: "Funday", gender: "Lelaki")
}
