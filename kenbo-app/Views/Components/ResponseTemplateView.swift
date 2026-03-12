import SwiftUI

struct ResponseTemplateView<TopContent: View, BottomContent: View>: View {
    let imageName: String
    let title: String
    let subtitle: String
    
    let topContent: TopContent
    let bottomContent: BottomContent
    
    init(
        imageName: String,
        title: String,
        subtitle: String,
        @ViewBuilder topContent: () -> TopContent,
        @ViewBuilder bottomContent: () -> BottomContent
    ) {
        self.imageName = imageName
        self.title = title
        self.subtitle = subtitle
        self.topContent = topContent()
        self.bottomContent = bottomContent()
    }
    
    var body: some View {
        VStack(spacing: 32) {
            // Top Content Slot
            topContent
            
            // Central Image
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 280, height: 280)
                .clipShape(RoundedRectangle(cornerRadius: 24))
            
            // Title and Subtitle
            VStack(spacing: 12) {
                Text(title)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                
                Text(subtitle)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Color.App.Gray.primary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
            }
            
            // Bottom Content Slot
            bottomContent
        }
        .padding(.vertical, 40)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

#Preview {
    ResponseTemplateView(
        imageName: "link_sprite", // Using an existing asset name from project
        title: "Congratulation\nFandy",
        subtitle: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        topContent: {
            // Example of using the "Si Bugar" badge style as top content
            Text("Si Bugar")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(Color.App.Purple.primary)
                .padding(.top, 20)
        },
        bottomContent: {
            // Example of using a button as bottom content
            Button(action: {}) {
                Text("Tutup")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 70)
                    .background(Color.App.Purple.dark)
                    .cornerRadius(16)
                    .shadow(color: Color.App.Purple.dark, radius: 0, x: 0, y: 5)
            }
            .padding(.horizontal, 40)
            .padding(.top, 20)
        }
    )
}
