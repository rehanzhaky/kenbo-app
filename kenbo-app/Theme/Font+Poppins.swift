import SwiftUI

extension Font {
    enum PoppinsWeight: String {
        case regular = "Poppins-Regular"
        case medium = "Poppins-Medium"
        case semiBold = "Poppins-SemiBold"
        case bold = "Poppins-Bold"
        case extraBold = "Poppins-ExtraBold"
        case black = "Poppins-Black"
        case light = "Poppins-Light"
        case thin = "Poppins-Thin"
    }
    
    static func poppins(_ weight: PoppinsWeight = .regular, size: CGFloat) -> Font {
        return .custom(weight.rawValue, size: size)
    }
    
    // Semantic helpers
    static func poppinsBold(size: CGFloat) -> Font { .poppins(.bold, size: size) }
    static func poppinsSemiBold(size: CGFloat) -> Font { .poppins(.semiBold, size: size) }
    static func poppinsMedium(size: CGFloat) -> Font { .poppins(.medium, size: size) }
    static func poppinsRegular(size: CGFloat) -> Font { .poppins(.regular, size: size) }
}

// Shortcut ViewModifier for even cleaner use
extension View {
    func poppins(_ weight: Font.PoppinsWeight = .regular, size: CGFloat) -> some View {
        self.font(.poppins(weight, size: size))
    }
}
