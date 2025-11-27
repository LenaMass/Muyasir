//
//  Team12App.swift
//  Team12
//
//  Created by Lena Saeed Alhuthali on 28/05/1447 AH.
//

import SwiftUI

@main
struct Team12App: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some Scene {
        WindowGroup {
            inputpage()
                .environment(\.layoutDirection, .rightToLeft)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}

