import SwiftUI

struct WidgetView: View {
    @ObservedObject var viewModel: WidgetViewModel
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            // Main Card
            HStack(alignment: .center, spacing: 16) {
                // Avatar
                ProfileAvatar(gender: viewModel.gender, size: 120)
                    .padding(.leading, 6)
                
                // Content
                VStack(alignment: .leading, spacing: 8) {
                    // Name
                    Text(viewModel.userName)
                        .font(.custom("Montserrat-Bold", size: 32))
                        .foregroundColor(.black)
                        .padding(.top, 6)
                    
                    // Stat Bars (Horizontal)
                    HStack(spacing: 12) {
                        // Health
                        StatBarCard(
                            title: "Health",
                            icon: "heart-pulse",
                            current: viewModel.healthCurrent,
                            max: viewModel.healthMax,
                            color: Color(hex: "FE7171"),
                            lightColor: Color(hex: "FFC5C5"),
                            outerCircleColor: Color(hex: "9C3B3B"),
                            unit: "HP"
                        )
                        .frame(width: 100)
                        
                        // Power
                        StatBarCard(
                            title: "Power",
                            icon: "energy",
                            current: viewModel.powerCurrent,
                            max: viewModel.powerMax,
                            color: Color(hex: "71FE71"),
                            lightColor: Color(hex: "C5FFC5"),
                            outerCircleColor: Color(hex: "3B9C3B"),
                            unit: "PW"
                        )
                        .frame(width: 100)
                        
                        // Stamina
                        StatBarCard(
                            title: "Stamina",
                            icon: "food-turkey",
                            current: viewModel.staminaCurrent,
                            max: viewModel.staminaMax,
                            color: Color(hex: "7171FE"),
                            lightColor: Color(hex: "C5C5FF"),
                            outerCircleColor: Color(hex: "3B3B9C"),
                            unit: "ST"
                        )
                        .frame(width: 100)
                    }
                    .padding(.bottom, 6)
                }
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
            .background(Color.white)
            .cornerRadius(35)
            .overlay(
                RoundedRectangle(cornerRadius: 35)
                    .stroke(Color.black, lineWidth: 3)
            )
            
            // Level & Streak Badges (Top Right)
            HStack(spacing: 8) {
                PillBadgeView(text: "Lv. \(viewModel.level)", style: .level)
                PillBadgeView(text: "\(viewModel.streak)", iconName: "flame.fill", style: .streak)
            }
            .padding(.top, 16)
            .padding(.trailing, 16)
        }
        .frame(height: 180)
        .padding(.horizontal, 16)
    }
}

#Preview {
    WidgetView(
        viewModel: WidgetViewModel(
            userName: "Funday",
            gender: "Lelaki",
            level: 20,
            streak: 5,
            healthCurrent: 200,
            healthMax: 300,
            powerCurrent: 200,
            powerMax: 300,
            staminaCurrent: 200,
            staminaMax: 300
        )
    )
    .background(Color(hex: "F7F7F7"))
}
