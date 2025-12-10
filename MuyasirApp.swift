//
//  MuyasirApp.swift
//  Muyasir
//
//  Created by Lena Saeed Alhuthali on 28/05/1447 AH.
//

import SwiftUI

@main
struct MuyasirApp: App {
    @State private var showSplash = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if showSplash {
                    SplashScreenView()
                        .transition(.opacity)
                } else {
                    InputPageView()
                        .transition(.opacity)
                }
            }
            .environment(\.layoutDirection, .rightToLeft)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation(.easeOut(duration: 0.4)) {
                        showSplash = false
                    }
                }
            }
        }
    }
}
