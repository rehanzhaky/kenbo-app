import SwiftUI

enum TrackIconType {
    case shoe, hand, head, eye
    
    var systemName: String {
        switch self {
        case .shoe: return "figure.walk"
        case .hand: return "hand.wave.fill"
        case .head: return "person.fill"
        case .eye: return "eye.fill"
        }
    }
}

struct TrackIndicator<Content: View>: View {
    let iconType: TrackIconType
    let content: Content
    
    // Internal configuration based on icon type
    private var isBust: Bool { iconType == .head }
    private var isFitting: Bool { iconType == .eye }
    
    init(iconType: TrackIconType, @ViewBuilder content: @escaping () -> Content) {
        self.iconType = iconType
        self.content = content()
    }
    
    // Convenience initializer for no content
    init(iconType: TrackIconType) where Content == EmptyView {
        self.iconType = iconType
        self.content = EmptyView()
    }
    
    var body: some View {
        ZStack {
            // Background Layer
            Circle()
                .fill(Color.white)
            
            // Content Layer
            ZStack {
                if isBust {
                    // Bust design (Head): Needs clipping for the shoulder effect
                    Image(systemName: iconType.systemName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180)
                        .foregroundColor(Color.App.Purple.primary)
                        .offset(y: 50)
                        .clipShape(Circle()) // Only clip the bust
                } else {
                    // Standard design (Shoe, Hand, Eye): No inner clipping needed
                    VStack(spacing: isFitting ? 6 : 12) {
                        Image(systemName: iconType.systemName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: isFitting ? 80 : 120, 
                                   height: isFitting ? 80 : 120)
                            .foregroundColor(Color.App.Purple.primary)
                        
                        // Content slot
                        if !(content is EmptyView) {
                            content
                        }
                    }
                    .offset(y: isFitting ? -10 : 0) // Centering adjustment
                }
            }
            
            // Border Layer
            Circle()
                .stroke(Color.App.Purple.primary, lineWidth: 6)
        }
        .frame(width: 260, height: 260)
    }
}

#Preview {
    VStack(spacing: 20) {
        HStack(spacing: 20) {
            TrackIndicator(iconType: .shoe) {
                TrackText(value: 10, unit: "Steps")
            }
            TrackIndicator(iconType: .head)
        }
        
        HStack(spacing: 20) {
            TrackIndicator(iconType: .eye) {
                VStack(spacing: 4) {
                    Text("Blink Goals")
                        .font(.system(size: 12, weight: .bold))
                    Text("20 Blink")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color.App.Purple.primary)
                }
            }
            TrackIndicator(iconType: .hand)
        }
    }
    .padding()
}
