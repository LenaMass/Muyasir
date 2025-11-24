//
//  a.swift
//  Team12
//

import SwiftUI

struct ContentView1: View {
    @State private var isHandMode = true // true for hand mode, false for document mode
    @State private var outputText = ""
    @Namespace private var toggleNamespace
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Navigation Bar
                HStack {
                    Button(action: {
                        // Dictionary/Book action
                    }) {
                        Image(systemName: "book.fill")
                            .font(.system(size: 24))
                            .foregroundColor(Color(red: 0.4, green: 0.6, blue: 0.5))
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // Home action
                    }) {
                        Image(systemName: "house.fill")
                            .font(.system(size: 24))
                            .foregroundColor(Color(red: 0.4, green: 0.6, blue: 0.5))
                    }
                }
                .padding(.horizontal, 30)
                .padding(.top, 20)
                .padding(.bottom, 30)
                
                // Toggle Switch
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color(red: 0.4, green: 0.6, blue: 0.5))
                        .frame(height: 80)
                    
                    HStack(spacing: 0) {
                        ZStack {
                            if !isHandMode {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color(red: 0.5, green: 0.7, blue: 0.6))
                                    .matchedGeometryEffect(id: "toggle", in: toggleNamespace)
                            }
                            
                            Image(systemName: "doc.text.fill")
                                .font(.system(size: 32))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 70)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                isHandMode = false
                            }
                        }
                        
                        ZStack {
                            if isHandMode {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color(red: 0.5, green: 0.7, blue: 0.6))
                                    .matchedGeometryEffect(id: "toggle", in: toggleNamespace)
                            }
                            
                            Image(systemName: "hand.raised.fill")
                                .font(.system(size: 32))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 70)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                isHandMode = true
                            }
                        }
                    }
                    .padding(.horizontal, 5)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 30)
                .padding(.bottom, 30)
                
                // ASL Hand Signs Image
                // Replace "asl_hands" with your actual image name from Assets
                Image("asl_hands")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 60)
                    .padding(.bottom, 20)
                
                // Output Box
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                        )
                    
                    ScrollView {
                        Text(outputText)
                            .font(.system(size: 18))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .padding()
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 400)
                .padding(.horizontal, 30)
                
                Spacer()
                
                // Bottom Buttons
                HStack(spacing: 20) {
                    Button(action: {
                        // Undo/Back action
                        if !outputText.isEmpty {
                            outputText.removeLast()
                        }
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color(red: 0.7, green: 0.85, blue: 0.8))
                                .frame(height: 70)
                            
                            Image(systemName: "arrow.uturn.backward")
                                .font(.system(size: 28, weight: .semibold))
                                .foregroundColor(Color(red: 0.4, green: 0.6, blue: 0.5))
                        }
                    }
                    
                    Button(action: {
                        // Download/Save action
                        print("Save action triggered")
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color(red: 0.4, green: 0.6, blue: 0.5))
                                .frame(height: 70)
                            
                            Image(systemName: "arrow.down.to.line")
                                .font(.system(size: 28, weight: .semibold))
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 40)
            }
        }
    }
}

#Preview {
    ContentView1()
}
