//
//  ResultView.swift
//  Team12
//
//  Created by Shahad Alharbi on 11/27/25.


import SwiftUI
import UIKit

struct ResultView: View {
    @StateObject var viewModel: ResultViewModel
    @Namespace private var toggleNamespace
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @State private var showCopiedFeedback = false
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                HStack {
                    Button {} label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 14)
                                .fill(.ultraThinMaterial)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(Color.white.opacity(0.6), lineWidth: 0.8)
                                )
                                .shadow(color: Color.black.opacity(0.12), radius: 6, x: 0, y: 3)
                            
                            Image(systemName: "book.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.maingreen)
                        }
                        .frame(width: 40, height: 40)
                    }
                    
                    Spacer()
                    
                    Button {
                        isDarkMode.toggle()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 14)
                                .fill(.ultraThinMaterial)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(Color.white.opacity(0.6), lineWidth: 0.8)
                                )
                                .shadow(color: Color.black.opacity(0.12), radius: 6, x: 0, y: 3)
                            
                            Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.maingreen)
                        }
                        .frame(width: 40, height: 40)
                    }
                }
                .padding(.horizontal, 32)
                .padding(.top, 20)
                .padding(.bottom, 22)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 22)
                        .fill(Color.maingreen.opacity(0.92))
                        .shadow(color: Color.black.opacity(0.18), radius: 8, x: 0, y: 4)
                        .frame(height: 52)
                    
                    HStack(spacing: 0) {
                        
                        ZStack {
                            if !viewModel.isHandMode {
                                RoundedRectangle(cornerRadius: 18)
                                    .fill(.ultraThinMaterial)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 18)
                                            .stroke(Color.white.opacity(0.7), lineWidth: 1)
                                    )
                                    .shadow(color: Color.black.opacity(0.15), radius: 6, x: 0, y: 3)
                                    .matchedGeometryEffect(id: "toggle", in: toggleNamespace)
                            }
                            
                            Image(systemName: "doc.text.fill")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                                .opacity(viewModel.isHandMode ? 0.5 : 1.0)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 38)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                                viewModel.isHandMode = false
                            }
                        }
                        
                        ZStack {
                            if viewModel.isHandMode {
                                RoundedRectangle(cornerRadius: 18)
                                    .fill(.ultraThinMaterial)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 18)
                                            .stroke(Color.white.opacity(0.7), lineWidth: 1)
                                    )
                                    .shadow(color: Color.black.opacity(0.15), radius: 6, x: 0, y: 3)
                                    .matchedGeometryEffect(id: "toggle", in: toggleNamespace)
                            }
                            
                            Image(systemName: "hand.raised.fill")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                                .opacity(viewModel.isHandMode ? 1.0 : 0.5)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 38)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                                viewModel.isHandMode = true
                            }
                        }
                    }
                    .padding(.horizontal, 6)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 16)

                
                HStack(spacing: 6) {
                    ForEach(["ا", "ل", "ن", "ت", "ي", "ج", "ة"], id: \.self) { letter in
                        Image(letter)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 26, height: 38)
                    }
                }
                .environment(\.layoutDirection, .rightToLeft)
                .padding(.bottom, 18)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 26)
                        .fill(.ultraThinMaterial)
                        .overlay(
                            RoundedRectangle(cornerRadius: 26)
                                .stroke(Color.gray.opacity(0.22), lineWidth: 1.5)
                        )
                        .shadow(color: Color.black.opacity(0.10), radius: 10, x: 0, y: 4)
                    
                    ScrollView {
                        Text(viewModel.isHandMode ? "" : viewModel.outputText)
                            .font(.system(size: 18))
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .padding()
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 340)
                .padding(.horizontal, 32)
                
                Spacer()
                
                VStack {
                    if showCopiedFeedback {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 32))
                            .foregroundColor(.maingreen)
                            .transition(.scale.combined(with: .opacity))
                    }
                    
                    Button {
                        UIPasteboard.general.string = viewModel.outputText
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            showCopiedFeedback = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                showCopiedFeedback = false
                            }
                        }
                    } label: {
                        Image(systemName: "doc.on.doc.fill")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                    }
                    .background(
                        Capsule()
                            .fill(Color.maingreen)
                            .shadow(color: Color.black.opacity(0.18), radius: 10, x: 0, y: 6)
                    )
                    .padding(.horizontal, 32)
                    .padding(.bottom, 28)
                }
            }
        }
    }
}

#Preview {
    ResultView(viewModel: ResultViewModel(simplifiedText: "هنا يظهر النص المبسط من السيرفر."))
}

