import SwiftUI

public struct EarnTitleView: View {
    public let title: String
    
    public init(title: String) {
        self.title = title
    }
    
    public var body: some View {
        OutlinedText(
            text: title,
            font: .system(size: 34, weight: .black, design: .rounded),
            lineWidth: 1.5,
            outlineColor: Color.App.Purple.dark,
            fillColor: .white
        )
    }
}

#if DEBUG
struct EarnTitleView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 40) {
            EarnTitleView(title: "Si Bugar")
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
#endif
