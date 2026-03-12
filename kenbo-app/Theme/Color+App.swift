import SwiftUI

extension Color {
    struct App {
        struct Purple {
            static let light = Color(appHex: "#E9CDFF")
            static let primary = Color(appHex: "#BE71FE")
            static let dark = Color(appHex: "#74409F")
        }
        
        struct Red {
            static let light = Color(appHex: "#FFC5C5")
            static let primary = Color(appHex: "#FE7171")
            static let dark = Color(appHex: "#9C3B3B")
        }
        
        struct Orange {
            static let light = Color(appHex: "#FFE2C4")
            static let primary = Color(appHex: "#FEB871")
            static let dark = Color(appHex: "#B0763C")
        }
        
        struct Green {
            static let light = Color(appHex: "#B5F2B4")
            static let primary = Color(appHex: "#6EE46C")
            static let dark = Color(appHex: "#3D8D3B")
        }
        
        struct Blue {
            static let light = Color(appHex: "#D5E5FF")
            static let primary = Color(appHex: "#7DADFF")
            static let dark = Color(appHex: "#385382")
        }
        
        struct Teal {
            static let primary = Color(appHex: "#6CDCE4")
            static let dark = Color(appHex: "#29676C")
        }
        
        struct Yellow {
            static let light = Color(appHex: "#FFE4AA")
            static let primary = Color(appHex: "#F29B43")
        }
        
        struct Gray {
            static let light = Color(appHex: "#F6F6F6")
            static let primary = Color(appHex: "#A0A0A0")
        }
        
        static let black = Color(appHex: "#000000")
        static let white = Color.white
    }
}

// MARK: - Hex Initialization
extension Color {
    init(appHex: String) {
        let hex = appHex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
