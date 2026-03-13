
import SwiftUI

struct ProfileBox<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color(hex: "74409F"), radius: 0, x: 0, y: 5)
    }
}

#Preview {
    ProfileBox {
        Text("Hello, World!")
    }
    .padding()
    .background(Color(hex: "F7F7F7"))
}
