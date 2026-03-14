import SwiftUI
import Combine

class WidgetViewModel: ObservableObject {
    @Published var userName: String
    @Published var gender: String
    @Published var level: Int
    @Published var streak: Int
    @Published var healthCurrent: Int
    @Published var healthMax: Int
    @Published var powerCurrent: Int
    @Published var powerMax: Int
    @Published var staminaCurrent: Int
    @Published var staminaMax: Int
    
    init(userName: String, gender: String, level: Int = 20, streak: Int = 5,
         healthCurrent: Int = 200, healthMax: Int = 300,
         powerCurrent: Int = 200, powerMax: Int = 300,
         staminaCurrent: Int = 200, staminaMax: Int = 300) {
        self.userName = userName
        self.gender = gender
        self.level = level
        self.streak = streak
        self.healthCurrent = healthCurrent
        self.healthMax = healthMax
        self.powerCurrent = powerCurrent
        self.powerMax = powerMax
        self.staminaCurrent = staminaCurrent
        self.staminaMax = staminaMax
    }
}
