import SwiftUI

struct RewardStoryView: View {
    @Environment(\.dismiss) var dismiss
    
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
                            Text("Cerita Lucu")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(Color.App.Purple.dark)
                            Spacer()
                        }
                        .padding(.top, 40)
                        
                        // Story Text
                        ScrollView {
                            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                                .lineSpacing(4)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 10)
                        }
                        
                        Spacer()
                        
                        // Tutup Button
                        HStack {
                            Spacer()
                            PrimaryButton(title: "Tutup") {
                                dismiss()
                            }
                            Spacer()
                        }
                        .padding(.bottom, max(geometry.safeAreaInsets.bottom, 80))
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
    RewardStoryView()
}
