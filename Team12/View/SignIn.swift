//import SwiftUI
//
//struct SignIn: View {
//    @State private var username: String = ""
//    @State private var password: String = ""
//    @State private var rememberMe: Bool = false
//    
//    var body: some View {
//        ZStack(alignment: .top) {
//            ScrollView {
//                VStack(alignment: .leading, spacing: 24) {
//                    
//                    // زر الرجوع في أعلى يمين الشاشة
//                    HStack {
//                        Spacer()
//                        Button(action: {}) {
//                            Image(systemName: "arrow.right")
//                                .font(.system(size: 20, weight: .medium))
//                                .foregroundColor(Color.purplePrimary)
//                        }
//                    }
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    
//                    // العنوان
//                    Text("مرحبا !")
//                        .font(.system(size: 34, weight: .semibold))
//                        .foregroundColor(.purplePrimary)
//                        .frame(maxWidth: .infinity, alignment: .center)
//                        .padding(.top, 8)
//                    
//                    // اسم المستخدم
//                    VStack(alignment: .leading, spacing: 8) {
//                        Text("اسم المستخدم")
//                            .font(.subheadline)
//                            .foregroundColor(.labelGray)
//                            .frame(maxWidth: .infinity, alignment: .trailing)
//                        
//                        HStack(spacing: 8) {
//                            TextField("", text: $username)
//                                .textInputAutocapitalization(.none)
//                                .disableAutocorrection(true)
//                                .multilineTextAlignment(.trailing)
//                            
//                            if !username.isEmpty {
//                                Image(systemName: "checkmark.circle.fill")
//                                    .font(.system(size: 18))
//                                    .foregroundColor(.lavenderButton)
//                            }
//                        }
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        
//                        Rectangle()
//                            .frame(height: 1)
//                            .foregroundColor(Color(red: 0.87, green: 0.90, blue: 0.89))
//                    }
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    
//                    // كلمة المرور
//                    VStack(alignment: .leading, spacing: 8) {
//                        Text("كلمة المرور")
//                            .font(.subheadline)
//                            .foregroundColor(.labelGray)
//                            .frame(maxWidth: .infinity, alignment: .trailing)
//                        
//                        SecureField("", text: $password)
//                            .multilineTextAlignment(.trailing)
//                        
//                        Rectangle()
//                            .frame(height: 1)
//                            .foregroundColor(Color(red: 0.87, green: 0.90, blue: 0.89))
//                    }
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    
//                    // تذكرني + هل نسيت كلمة المرور؟
//                    HStack {
//                        Button(action: {}) {
//                            Text("هل نسيت كلمة المرور؟")
//                                .font(.footnote)
//                                .foregroundColor(.purplePrimary.opacity(0.8))
//                        }
//                        
//                        Spacer()
//                        
//                        Toggle(isOn: $rememberMe) {
//                            Text("تذكرني")
//                                .font(.footnote)
//                                .foregroundColor(.labelGray)
//                        }
//                        .toggleStyle(CircleCheckboxToggleStyle())
//                    }
//                    .padding(.top, 10)
//                    
//                    // زر تسجيل الدخول
//                    Button(action: {}) {
//                        Text("تسجيل الدخول")
//                            .font(.headline)
//                            .fontWeight(.semibold)
//                            .frame(maxWidth: .infinity)
//                            .padding(.vertical, 16)
//                            .foregroundColor(.white)
//                    }
//                    .background(Color.lavenderButton)
//                    .cornerRadius(26)
//                    .glassEffect(.regular)
//                    .shadow(
//                        color: Color.lavenderButton.opacity(0.4),
//                        radius: 8,
//                        x: 0,
//                        y: 6
//                    )
//                    .padding(.top, 16)
//                    
//                    // مستخدم جديد؟ تسجيل
//                    HStack(spacing: 4) {
//                        Spacer()
//                        Button(action: {}) {
//                            Text("تسجيل")
//                                .font(.footnote)
//                                .foregroundColor(.purplePrimary.opacity(0.9))
//                        }
//                        Text("مستخدم جديد؟")
//                            .font(.footnote)
//                            .foregroundColor(.labelGray)
//                    }
//                    .padding(.top, 24)
//                }
//                .padding(.horizontal, 24)
//                .padding(.top, 32)
//                .frame(maxWidth: .infinity, alignment: .topLeading)
//            }
//        }
//    }
//}
//
//private extension Color {
//    static let purplePrimary = Color(red: 0.44, green: 0.40, blue: 0.71)
//    static let lavenderButton = Color(red: 0.77, green: 0.74, blue: 0.91)
//    static let mintAccent     = Color(red: 0.35, green: 0.77, blue: 0.63)
//    static let labelGray      = Color(red: 0.55, green: 0.57, blue: 0.57)
//}
//
//struct CircleCheckboxToggleStyle: ToggleStyle {
//    func makeBody(configuration: Configuration) -> some View {
//        HStack(spacing: 8) {
//            Button(action: { configuration.isOn.toggle() }) {
//                ZStack {
//                    Circle()
//                        .stroke(Color.gray.opacity(0.5), lineWidth: 1.5)
//                        .frame(width: 18, height: 18)
//                    
//                    if configuration.isOn {
//                        Circle()
//                            .fill(Color.lavenderButton)
//                            .frame(width: 12, height: 12)
//                    }
//                }
//            }
//            .buttonStyle(.plain)
//            
//            configuration.label
//        }
//    }
//}
//
//#Preview {
//    SignIn()
//}

