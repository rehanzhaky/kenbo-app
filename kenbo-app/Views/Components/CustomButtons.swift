import SwiftUI

// MARK: - Primary Button (Purple background, white text)
struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    var isDisabled: Bool = false
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.custom("Montserrat-Bold", size: 22))
                .foregroundColor(.white)
                .frame(width: 328, height: 63)
                .background(Color(hex: "BE71FE"))
                .cornerRadius(10)
                .shadow(color: Color(hex: "74409F"), radius: 0, x: 0, y: 5)
        }
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.6 : 1.0)
    }
}

// MARK: - Secondary Button (White background, purple text with purple border)
struct SecondaryButton: View {
    let title: String
    let action: () -> Void
    var isDisabled: Bool = false
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.custom("Montserrat-Bold", size: 22))
                .foregroundColor(Color(hex: "BE71FE"))
                .frame(width: 328, height: 63)
                .background(Color(hex: "FFFFFF"))
                .cornerRadius(10)
                .shadow(color: Color(hex: "74409F"), radius: 0, x: 0, y: 5)
        }
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.6 : 1.0)
    }
}

#Preview {
    VStack(spacing: 20) {
        PrimaryButton(title: "Text button") {
            print("Primary button tapped")
        }
        
        SecondaryButton(title: "Text button") {
            print("Secondary button tapped")
        }
    }
    .padding()
}
