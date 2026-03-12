import SwiftUI

/// A reusable component that renders heavily outlined text.
/// It works by layering text views slightly offset in multiple directions.
struct OutlinedText: View {
    let text: String
    let font: Font
    let lineWidth: CGFloat
    let outlineColor: Color
    let fillColor: Color
    
    var body: some View {
        ZStack {
            Group {
                Text(text).offset(x: lineWidth, y: lineWidth)
                Text(text).offset(x: -lineWidth, y: -lineWidth)
                Text(text).offset(x: -lineWidth, y: lineWidth)
                Text(text).offset(x: lineWidth, y: -lineWidth)
                Text(text).offset(x: lineWidth, y: 0)
                Text(text).offset(x: -lineWidth, y: 0)
                Text(text).offset(x: 0, y: lineWidth)
                Text(text).offset(x: 0, y: -lineWidth)
            }
            .foregroundColor(outlineColor)
            .font(font)
            
            Text(text)
                .foregroundColor(fillColor)
                .font(font)
        }
    }
}

/// The specific up-arrow icon from the "Earn Exp" design
struct ExpArrowIcon: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.App.Purple.primary)
                .frame(width: 60, height: 60)
            
            VStack(spacing: 2) {
                Image(systemName: "arrowtriangle.up.fill")
                    .resizable()
                    .frame(width: 20, height: 15)
                    .foregroundColor(.white)
                
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 14, height: 3)
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 14, height: 3)
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 14, height: 3)
            }
        }
    }
}

public struct EarnBadgeView: View {
    public let amount: Int
    
    public init(amount: Int) {
        self.amount = amount
    }
    
    public var body: some View {
        HStack(spacing: 16) {
            ExpArrowIcon()
            
            OutlinedText(
                text: "\(amount) EXP +",
                font: .system(size: 34, weight: .black, design: .rounded),
                lineWidth: 1.5,
                outlineColor: Color.App.Purple.dark,
                fillColor: .white
            )
        }
    }
}

#if DEBUG
struct EarnBadgeView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 40) {
            EarnBadgeView(amount: 20)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
#endif
