import SwiftUI

struct StatBarData: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let current: Int
    let max: Int
    let color: Color
    let lightColor: Color
    let outerCircleColor: Color
    let unit: String
    
    // Predefined stat bars
    static let health = StatBarData(
        title: "Health",
        icon: "heart-pulse",
        current: 200,
        max: 300,
        color: Color(hex: "FE7171"),
        lightColor: Color(hex: "FFC5C5"),
        outerCircleColor: Color(hex: "9C3B3B"),
        unit: "HP"
    )
    
    static let power = StatBarData(
        title: "Power",
        icon: "food-turkey",
        current: 200,
        max: 300,
        color: Color(hex: "6EE46C"),
        lightColor: Color(hex: "B5F2B4"),
        outerCircleColor: Color(hex: "3D8D3B"),
        unit: "PW"
    )
    
    static let stamina = StatBarData(
        title: "Stamina",
        icon: "energy",
        current: 200,
        max: 300,
        color: Color(hex: "D5E5FF"),
        lightColor: Color(hex: "D5E5FF"),
        outerCircleColor: Color(hex: "385382"),
        unit: "ST"
    )
    
    static let defaultBars = [health, power, stamina]
}
