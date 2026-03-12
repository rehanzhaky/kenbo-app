import SwiftUI

struct TitleBadge: View {
    let prefix: String
    let title: String
    let backgroundColor: Color
    let textColor: Color
    let borderColor: Color
    let borderWidth: CGFloat
    let cornerRadius: CGFloat
    let fontSize: CGFloat
    let padding: EdgeInsets
    
    init(
        prefix: String = "si",
        title: String,
        backgroundColor: Color = Color(hex: "74409F"),
        textColor: Color = .white,
        borderColor: Color = .white,
        borderWidth: CGFloat = 3,
        cornerRadius: CGFloat = 20,
        fontSize: CGFloat = 32,
        padding: EdgeInsets = EdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24)
    ) {
        self.prefix = prefix
        self.title = title
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
        self.fontSize = fontSize
        self.padding = padding
    }
    
    var body: some View {
        HStack(spacing: 8) {
            Text(prefix)
                .font(.system(size: fontSize, weight: .bold))
                .foregroundColor(textColor)
            
            Text(title)
                .font(.system(size: fontSize, weight: .bold))
                .foregroundColor(textColor)
        }
        .padding(padding)
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(borderColor, lineWidth: borderWidth)
        )
    }
}

// Predefined title badges
extension TitleBadge {
    static func bugar() -> TitleBadge {
        TitleBadge(title: "Bugar")
    }
    
    static func rajin() -> TitleBadge {
        TitleBadge(title: "Rajin")
    }
    
    static func sehat() -> TitleBadge {
        TitleBadge(title: "Sehat")
    }
    
    static func pintar() -> TitleBadge {
        TitleBadge(title: "Pintar")
    }
}

#Preview {
    VStack(spacing: 20) {
        TitleBadge.bugar()
        TitleBadge.rajin()
        TitleBadge.sehat()
        TitleBadge.pintar()
        
        // Custom
        TitleBadge(
            prefix: "si",
            title: "Bugar",
            backgroundColor: Color(hex: "BE71FE"),
            borderColor: Color.white
        )
    }
    .padding()
    .background(Color(hex: "F7F7F7"))
}
