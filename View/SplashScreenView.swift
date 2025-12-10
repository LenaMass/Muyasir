//
//  SplashScreenView.swift
//  Muyasir
//
//  Created by Shahad Alharbi on 12/11/25.
//
import SwiftUI
struct SplashScreenView: View {
var body: some View {
    ZStack {
        Color(.systemBackground)
            .ignoresSafeArea()

        VStack(spacing: 12) {   
            Image("Muyasir")
                .resizable()
                .scaledToFit()
                .frame(width: 220)
                .shadow(radius: 8)

            Text("ميسّر")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.maingreen)
                .shadow(radius: 6)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    }
}
