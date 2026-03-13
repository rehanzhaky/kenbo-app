import SwiftUI

struct TrackText: View {
    let value: Int
    let unit: String
    
    var body: some View {
        VStack(spacing: 2) {
            Text("\(value)")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(Color.App.Purple.primary)
            
            Text(unit)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Color.App.Gray.primary)
        }
    }
}

#Preview {
    TrackText(value: 10, unit: "Steps")
}
