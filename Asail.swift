//
//  Asail.swift
//  Team12
//
//  Created by Asail abdulmohsin on 30/05/1447 AH.
//

/*
import SwiftUI

// Color extension to support hex colors
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct SimplifyCopyView: View {
    @State private var selectedMode: Mode = .document
    @State private var resultText = ""
    @State private var saslText = ""
    
    enum Mode {
        case document
        case other
    }
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Back button
                HStack {
                    Button(action: {}) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 22))
                            .foregroundColor(.primary)
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 50)
                
                // Toggle switch at top
                HStack {
                    Spacer()
                    ModeToggle(selectedMode: $selectedMode)
                        .padding(.top, 20)
                    Spacer()
                }
                
                // Result section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Result")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundColor(Color(hex: "437657"))
                        .shadow(color: Color(hex: "437657").opacity(0.18), radius: 4, x: 0, y: 3)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 20)
                    
                    // ===== RESULT BOX STYLING - Adjust shadow and border here =====
                    ZStack(alignment: .topLeading) {
                        RoundedRectangle(cornerRadius: 32, style: .continuous)
                            .fill(Color.white)
                            .shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: 4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 32, style: .continuous)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1.5)
                            )
                            .frame(height: 260)
                        
                        TextEditor(text: $resultText)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 16)
                            .frame(height: 260)
                            .scrollContentBackground(.hidden)
                            .background(Color.clear)
                            .multilineTextAlignment(.leading)
                        
                        if resultText.isEmpty {
                            Text("Text........................\n........................\n................................")
                                .foregroundColor(.gray.opacity(0.5))
                                .padding(.top, 20)
                                .padding(.leading, 24)
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                // Output section (SASL)
                VStack(alignment: .leading, spacing: 12) {
                    Text("SASL")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundColor(Color(hex: "437657"))
                        .shadow(color: Color(hex: "437657").opacity(0.18), radius: 4, x: 0, y: 3)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 16)
                    
                    // ===== SASL BOX STYLING - Adjust shadow and border here =====
                    ZStack(alignment: .topLeading) {
                        RoundedRectangle(cornerRadius: 32, style: .continuous)
                            .fill(Color.white)
                            .shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: 4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 32, style: .continuous)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1.5)
                            )
                            .frame(height: 260)
                        
                        ScrollView {
                            Text(saslText)
                                .font(.system(size: 15))
                                .foregroundColor(.primary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 16)
                        }
                        .frame(height: 260)
                        .scrollContentBackground(.hidden)
                        .background(Color.clear)
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                // Continue button
                Button(action: {}) {
                    Text("Continue")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(Color(hex: "437657"))
                        .cornerRadius(27)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
        }
    }
}

struct ModeToggle: View {
    @Binding var selectedMode: SimplifyCopyView.Mode
    
    var body: some View {
        ZStack {
            // Background capsule
            Capsule()
                .fill(Color(hex: "437657"))
                .frame(width: 110, height: 60)
            
            // Moving circle background
            HStack(spacing: 0) {
                Circle()
                    .fill(selectedMode == .document ? Color(hex: "2d4d3a") : Color.clear)
                    .frame(width: 55, height: 55)
                
                Circle()
                    .fill(selectedMode == .other ? Color(hex: "2d4d3a") : Color.clear)
                    .frame(width: 55, height: 55)
            }
            .frame(width: 110)
            
            // Icons
            HStack(spacing: 0) {
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedMode = .document
                    }
                }) {
                    Image(systemName: "doc.text.fill")
                        .font(.system(size: 22))
                        .foregroundColor(.white)
                        .frame(width: 55, height: 55)
                }
                
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedMode = .other
                    }
                }) {
                    Image(systemName: "square.grid.2x2.fill")
                        .font(.system(size: 22))
                        .foregroundColor(.white)
                        .frame(width: 55, height: 55)
                }
            }
        }
    }
}

#Preview {
    SimplifyCopyView()
}
*/
