//
//  ResultViewModel.swift
//  Team12
//
//  Created by Shahad Alharbi on 11/27/25.
//

import Foundation
import Combine

@MainActor
final class ResultViewModel: ObservableObject {
    @Published var isHandMode: Bool = false
    @Published var outputText: String
    
    init(simplifiedText: String) {
        self.outputText = simplifiedText
        self.isHandMode = false   }
}
