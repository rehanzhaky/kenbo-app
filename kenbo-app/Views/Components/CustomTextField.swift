import SwiftUI

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        TextField(placeholder, text: $text)
            .font(.system(size: 18, weight: .regular))
            .foregroundColor(.black)
            .padding(.horizontal, 20)
            .padding(.vertical, 18)
            .background(isFocused ? Color.white : Color(hex: "EBEBEB"))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isFocused ? Color(hex: "74409F") : Color.clear, lineWidth: 4)
            )
            .accentColor(Color(hex: "74409F"))
            .focused($isFocused)
    }
}

struct CustomSecureField: View {
    let placeholder: String
    @Binding var text: String
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        SecureField(placeholder, text: $text)
            .font(.system(size: 18, weight: .regular))
            .foregroundColor(.black)
            .padding(.horizontal, 20)
            .padding(.vertical, 18)
            .background(isFocused ? Color.white : Color(hex: "EBEBEB"))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isFocused ? Color(hex: "74409F") : Color.clear, lineWidth: 4)
            )
            .accentColor(Color(hex: "74409F"))
            .focused($isFocused)
    }
}

#Preview {
    VStack(spacing: 20) {
        CustomTextField(placeholder: "Masukkan Nama Panggilan...", text: .constant(""))
            .frame(width: 328)
        
        CustomTextField(placeholder: "Masukkan Nama Panggilan...", text: .constant("Tulis nama"))
            .frame(width: 328)
        
        CustomSecureField(placeholder: "Password", text: .constant(""))
            .frame(width: 328)
    }
    .padding()
    .background(Color(hex: "F7F7F7"))
}
