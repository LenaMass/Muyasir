import SwiftUI

struct SginIn: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(
                colors: [
                    Color(red: 0.96, green: 0.99, blue: 0.95),
                    Color(red: 0.94, green: 0.98, blue: 0.93)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    HStack {
                        Button(action: {}) {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(Color.purplePrimary)
                        }
                        Spacer()
                    }
                    
                    Text("Welcome !")
                        .font(.system(size: 34, weight: .semibold))
                        .foregroundColor(.purplePrimary)
                        .padding(.top, 8)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Username")
                            .font(.subheadline)
                            .foregroundColor(.labelGray)
                        
                        HStack {
                            TextField("", text: $username)
                                .textInputAutocapitalization(.none)
                                .disableAutocorrection(true)
                            
                            if !username.isEmpty {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 18))
                                    .foregroundColor(.lavenderButton)
                            }
                        }
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color(red: 0.87, green: 0.90, blue: 0.89))
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .font(.subheadline)
                            .foregroundColor(.labelGray)
                        
                        SecureField("", text: $password)
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color(red: 0.87, green: 0.90, blue: 0.89))
                    }
                    
                    HStack {
                        Toggle(isOn: $rememberMe) {
                            Text("Remember me")
                                .font(.footnote)
                                .foregroundColor(.labelGray)
                        }
                        .toggleStyle(CircleCheckboxToggleStyle())
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Text("Forgot password?")
                                .font(.footnote)
                                .foregroundColor(.purplePrimary.opacity(0.8))
                        }
                    }
                    .padding(.top, 4)
                    
                    Button(action: {}) {
                        Text("LOGIN")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .foregroundColor(.white)
                    }
                    .background(Color.lavenderButton)
                    .cornerRadius(12)
                    .shadow(
                        color: Color.lavenderButton.opacity(0.4),
                        radius: 8,
                        x: 0,
                        y: 6
                    )
                    .padding(.top, 16)
                    
                    HStack(spacing: 4) {
                        Spacer()
                        Text("New user?")
                            .font(.footnote)
                            .foregroundColor(.labelGray)
                        Button(action: {}) {
                            Text("Signup")
                                .font(.footnote)
                                .foregroundColor(.purplePrimary.opacity(0.9))
                        }
                        Spacer()
                    }
                    .padding(.top, 24)
                }
                .padding(.horizontal, 24)
                .padding(.top, 32)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            }
        }
    }
}

private extension Color {
    static let purplePrimary = Color(red: 0.44, green: 0.40, blue: 0.71)
    static let lavenderButton = Color(red: 0.77, green: 0.74, blue: 0.91)
    static let mintAccent     = Color(red: 0.35, green: 0.77, blue: 0.63)
    static let labelGray      = Color(red: 0.55, green: 0.57, blue: 0.57)
}

struct CircleCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 8) {
            Button(action: { configuration.isOn.toggle() }) {
                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1.5)
                        .frame(width: 18, height: 18)
                    
                    if configuration.isOn {
                        Circle()
                            .fill(Color.mintAccent)
                            .frame(width: 12, height: 12)
                    }
                }
            }
            .buttonStyle(.plain)
            
            configuration.label
        }
    }
}

#Preview {
    SginIn()
}


