import SwiftUI

struct RadioButton: View {
    let isSelected: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .fill(isSelected ? Color(hex: "74409F") : Color(hex: "EBEBEB"))
                .frame(width: 24, height: 24)
            
            if !isSelected {
                Circle()
                    .strokeBorder(Color(hex: "74409F"), lineWidth: 1)
                    .frame(width: 24, height: 24)
            }
        }
    }
}

struct RadioButtonWithLabel: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                RadioButton(isSelected: isSelected)
                
                Text(label)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        HStack(spacing: 40) {
            RadioButtonWithLabel(label: "Lelaki", isSelected: true) {
                print("Lelaki selected")
            }
            
            RadioButtonWithLabel(label: "Perempuan", isSelected: false) {
                print("Perempuan selected")
            }
        }
        
        HStack(spacing: 40) {
            RadioButtonWithLabel(label: "Lelaki", isSelected: false) {
                print("Lelaki selected")
            }
            
            RadioButtonWithLabel(label: "Perempuan", isSelected: true) {
                print("Perempuan selected")
            }
        }
    }
    .padding()
}
