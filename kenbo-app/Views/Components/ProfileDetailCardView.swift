import SwiftUI

public struct ProfileDetailCardView: View {
    public let imageName: String
    
    // Stats
    public let healthCurrent: Int
    public let healthMax: Int
    public let powerCurrent: Int
    public let powerMax: Int
    public let staminaCurrent: Int
    public let staminaMax: Int
    
    // Actions
    public let onInfoTapped: () -> Void
    public let onShareTapped: () -> Void
    
    public init(
        imageName: String,
        healthCurrent: Int, healthMax: Int,
        powerCurrent: Int, powerMax: Int,
        staminaCurrent: Int, staminaMax: Int,
        onInfoTapped: @escaping () -> Void,
        onShareTapped: @escaping () -> Void
    ) {
        self.imageName = imageName
        self.healthCurrent = healthCurrent
        self.healthMax = healthMax
        self.powerCurrent = powerCurrent
        self.powerMax = powerMax
        self.staminaCurrent = staminaCurrent
        self.staminaMax = staminaMax
        self.onInfoTapped = onInfoTapped
        self.onShareTapped = onShareTapped
    }
    
    public var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // Main Card Container
            HStack(alignment: .top, spacing: 16) {
                // Left Side: Image
                Group {
                    if let _ = UIImage(named: imageName) {
                        Image(imageName)
                            .resizable()
                            .scaledToFill()
                    } else {
                        // Placeholder
                        Rectangle()
                            .fill(Color.App.Gray.light)
                            .overlay(
                                Image(systemName: "photo")
                                    .font(.system(size: 30))
                                    .foregroundColor(Color.App.Gray.primary)
                            )
                    }
                }
                .frame(width: 200)
            
                .frame(maxHeight: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                
                // Right Side: Stats
                VStack(alignment: .leading, spacing: 14) {
                    ResponsiveStatBarView(
                        title: "Health",
                        style: .health,
                        current: healthCurrent,
                        max: healthMax,
                        unit: "HP",
                        customIcon: "waveform.path.ecg",
                        height: 24
                    )
                    
                    ResponsiveStatBarView(
                        title: "Power",
                        style: .power,
                        current: powerCurrent,
                        max: powerMax,
                        unit: "PW",
                        customIcon: nil,
                        height: 24
                    )
                    
                    ResponsiveStatBarView(
                        title: "Stamina",
                        style: .stamina,
                        current: staminaCurrent,
                        max: staminaMax,
                        unit: "ST",
                        customIcon: "bolt.fill",
                        height: 24
                    )
                    
                    Spacer(minLength: 0)
                }
                .padding(.top, 4)
                .padding(.trailing, 16)
            }
            .padding(20)
            .frame(height: 340) // Fixed card height
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            // The border overlay
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Color.App.Purple.dark, lineWidth: 6)
            )
            // The drop shadow behind the card
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.App.Purple.dark)
                    .offset(y: 8)
            )
            
            
            // The Buttons
            HStack(spacing: 16) {
                Button(action: onInfoTapped) {
                    Circle()
                        .fill(Color.App.Purple.dark)
                        .frame(width: 50, height: 50)
                        .overlay(
                            Image(systemName: "info")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.white)
                                .offset(y: -2)
                        )
                }
                
                Button(action: onShareTapped) {
                    Circle()
                        .fill(Color.App.Purple.dark)
                        .frame(width: 50, height: 50)
                        .overlay(
                            Image(systemName: "arrow.turn.up.right")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                                .offset(y: -2)
                        )
                }
            }.padding(10)
      
         
            
            // Align them exactly intersecting the bottom-right corner
            // 24 pulls them half out of the right side, -12 pushes them out the bottom
           
        }
        // Extra padding to ensure parent views don't cut off the overlapping buttons
    
     
    }
}

#if DEBUG
struct ProfileDetailCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailCardView(
            imageName: "link_sprite",
            healthCurrent: 200, healthMax: 300,
            powerCurrent: 200, powerMax: 300,
            staminaCurrent: 200, staminaMax: 300,
            onInfoTapped: {},
            onShareTapped: {}
        )
        .padding(12)
        .previewLayout(.sizeThatFits)
    }
}
#endif
