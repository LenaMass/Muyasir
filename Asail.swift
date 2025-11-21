//
//  Asail.swift
//  Team12
//
//  Created by Asail abdulmohsin on 30/05/1447 AH.
//
import SwiftUI

struct SimplifyCopyView: View {
    @State private var selectedMode: Mode = .document
    @State private var resultText = "Text........................\n........................\n................................"
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
                // Toggle switch at top
                HStack {
                    Spacer()
                    ModeToggle(selectedMode: $selectedMode)
                        .padding(.top, 20)
                    Spacer()
                }
                
                // Result section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Result")
                        .font(.system(size: 28, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 20)
                    
                    TextEditor(text: $resultText)
                        .frame(height: 180)
                        .padding(12)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                        )
                }
                .padding(.horizontal, 20)
                
                // Output section
                VStack(alignment: .leading, spacing: 8) {
                    Text("SASL")
                        .font(.system(size: 28, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 16)
                    
                    ScrollView {
                        Text(saslText.isEmpty ? "" : saslText)
                            .font(.system(size: 15))
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(12)
                    }
                    .frame(height: 180)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
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
                        .background(Color(red: 0.4, green: 0.65, blue: 0.55))
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
                .fill(Color(red: 0.4, green: 0.65, blue: 0.55))
                .frame(width: 110, height: 60)
            
            // Moving circle background
            HStack(spacing: 0) {
                Circle()
                    .fill(selectedMode == .document ? Color(red: 0.25, green: 0.45, blue: 0.4) : Color.clear)
                    .frame(width: 55, height: 55)
                
                Circle()
                    .fill(selectedMode == .other ? Color(red: 0.25, green: 0.45, blue: 0.4) : Color.clear)
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
