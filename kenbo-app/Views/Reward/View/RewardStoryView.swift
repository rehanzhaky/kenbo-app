import SwiftUI

struct RewardStoryView: View {
    @Environment(\.dismiss) var dismiss
    let content: String
    let onRefresh: () -> Void
    
    // Drawer State
    @State private var drawerOffset: CGFloat = 0
    @State private var isExpanded: Bool = false
    
    // Constants for drawer positioning
    private let collapsedOffset: CGFloat = 200
    private let expandedOffset: CGFloat = 60
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                // Background
                Color.App.Purple.dark.ignoresSafeArea()
                
                // Content Drawer
                ZStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 24) {
                        // Title
                        HStack {
                            Spacer()
                            Text("Cerita Absurd Academy")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(Color.App.Purple.dark)
                            Spacer()
                        }
                        .padding(.top, 40)
                        
                        // Story Text
                        ScrollView {
                            Text(content)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.black.opacity(0.8))
                                .lineSpacing(6)
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal, 10)
                        }
                        
                        Spacer()
                        
                        // Action Buttons
                        VStack(spacing: 12) {
                            PrimaryButton(title: "Cerita Lain Kuy xixi") {
                                onRefresh()
                            }
                            
                            Button("Tutup") {
                                dismiss()
                            }
                            .foregroundColor(Color.App.Gray.primary)
                            .font(.system(size: 16, weight: .bold))
                        }
                        .padding(.bottom, max(geometry.safeAreaInsets.bottom, 40))
                    }
                    .padding(.horizontal, 32)
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
        }
    }
}

#Preview {
    RewardStoryView(content: "Once upon a time xixi...", onRefresh: {})
}
