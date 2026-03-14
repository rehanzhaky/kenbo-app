import SwiftUI

struct SettingsView: View {
    @ObservedObject private var prefs = UserPreferences.shared
    
    @State private var userName: String = ""
    @State private var selectedGender: String = "Lelaki"
    @State private var selectedSession: String = "Morning"
    
    var body: some View {
        ScrollView {
            // Track scroll offset
            GeometryReader { innerGeo in
                Color.clear
                    .preference(key: ScrollOffsetPreferenceKey.self, value: innerGeo.frame(in: .global).minY)
            }
            .frame(height: 0)
            
            VStack(alignment: .leading, spacing: 32) {
                // Header
                Text("Settings")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.top, 20)
                
                // Profile Section
                VStack(alignment: .leading, spacing: 20) {
                    Text("Profile Information")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color.App.Purple.dark)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Name")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Color.App.Gray.primary)
                        
                        CustomTextField(placeholder: "Enter your name", text: $userName)
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Gender")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Color.App.Gray.primary)
                        
                        HStack(spacing: 20) {
                            GenderButton(title: "Lelaki", isSelected: selectedGender == "Lelaki") {
                                selectedGender = "Lelaki"
                            }
                            GenderButton(title: "Perempuan", isSelected: selectedGender == "Perempuan") {
                                selectedGender = "Perempuan"
                            }
                        }
                    }
                }
                .padding(24)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
                
                // Session Section
                VStack(alignment: .leading, spacing: 20) {
                    Text("Academy Session")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color.App.Purple.dark)
                    
                    VStack(spacing: 12) {
                        SessionOptionRow(title: "Morning", description: "Start your day with energy", isSelected: selectedSession == "Morning") {
                            selectedSession = "Morning"
                        }
                        
                        SessionOptionRow(title: "Afternoon", description: "Refocus your mind after lunch", isSelected: selectedSession == "Afternoon") {
                            selectedSession = "Afternoon"
                        }
                    }
                }
                .padding(24)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
                
                // Save Button
                PrimaryButton(title: "Save Changes") {
                    saveChanges()
                }
                .padding(.top, 10)
                
                Spacer(minLength: 100)
            }
            .padding(.horizontal, 24)
        }
        .background(Color.App.Gray.light)
        .onAppear {
            userName = prefs.userName
            selectedGender = prefs.selectedGender
            selectedSession = prefs.selectedSession
        }
    }
    
    private func saveChanges() {
        prefs.userName = userName
        prefs.selectedGender = selectedGender
        prefs.selectedSession = selectedSession
        // We might want to show a toast or feedback here
    }
}

struct GenderButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(isSelected ? .white : Color.App.Purple.dark)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(isSelected ? Color.App.Purple.dark : Color.white)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(Color.App.Purple.dark, lineWidth: 2)
                )
        }
    }
}

struct SessionOptionRow: View {
    let title: String
    let description: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(isSelected ? Color.App.Purple.dark : .black)
                    Text(description)
                        .font(.system(size: 12))
                        .foregroundColor(Color.App.Gray.primary)
                }
                Spacer()
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? Color.App.Purple.dark : Color.App.Gray.primary)
            }
            .padding(16)
            .background(isSelected ? Color.App.Purple.light.opacity(0.3) : Color.App.Gray.light.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isSelected ? Color.App.Purple.dark : Color.clear, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    SettingsView()
}
