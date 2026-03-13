import SwiftUI

struct TrackResultText: View {
    let calories: Int?
    let secondMetricValue: Int
    let secondMetricLabel: String
    let secondMetricUnit: String
    
    // Default initializer
    init(
        calories: Int? = nil,
        secondMetricValue: Int,
        secondMetricLabel: String = "Step Goals",
        secondMetricUnit: String = "Steps"
    ) {
        self.calories = calories
        self.secondMetricValue = secondMetricValue
        self.secondMetricLabel = secondMetricLabel
        self.secondMetricUnit = secondMetricUnit
    }
    
    // Backward compatibility/Convenience for stepGoals
    init(calories: Int, stepGoals: Int) {
        self.init(
            calories: calories,
            secondMetricValue: stepGoals,
            secondMetricLabel: "Step Goals",
            secondMetricUnit: "Steps"
        )
    }
    
    var body: some View {
        HStack(spacing: 20) {
            if let calories = calories {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Cal Burned")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.black)
                    
                    HStack(alignment: .lastTextBaseline, spacing: 4) {
                        Text("\(calories)")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color.App.Purple.primary)
                        
                        Text("Cal")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(Color.App.Gray.primary)
                    }
                }
                
                Rectangle()
                    .fill(Color.App.Purple.primary)
                    .frame(width: 2, height: 40)
            }
            
            VStack(alignment: calories == nil ? .center : .leading, spacing: 4) {
                Text(secondMetricLabel)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.black)
                
                HStack(alignment: .lastTextBaseline, spacing: 4) {
                    Text("\(secondMetricValue)")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color.App.Purple.primary)
                    
                    Text(secondMetricUnit)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color.App.Gray.primary)
                }
            }
        }
    }
}

#Preview {
    TrackResultText(
        calories: 30,
        secondMetricValue: 20,
        secondMetricLabel: "Step Goals",
        secondMetricUnit: "Steps"
    )
}
