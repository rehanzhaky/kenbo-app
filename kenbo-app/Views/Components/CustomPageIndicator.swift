import SwiftUI

struct CustomPageIndicator: View {
    let currentPage: Int
    let pageCount: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<pageCount, id: \.self) { index in
                if index == currentPage {
                    // Active page - Rectangle (pill shape)
                    Capsule()
                        .fill(Color(hex: "9D6FCC"))
                        .frame(width: 32, height: 8)
                } else {
                    // Inactive page - Ellipse (circle)
                    Circle()
                        .fill(Color(hex: "9D6FCC"))
                        .frame(width: 8, height: 8)
                }
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        CustomPageIndicator(currentPage: 0, pageCount: 3)
        CustomPageIndicator(currentPage: 1, pageCount: 3)
        CustomPageIndicator(currentPage: 2, pageCount: 3)
    }
}
