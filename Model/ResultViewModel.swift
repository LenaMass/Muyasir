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
    func saveToHistory() {
        let entry = HistoryEntry(
            id: UUID().uuidString,
            text: outputText,
            date: Date(),
            isFavorite: false
        )
        
        var existing = HistoryStore.shared.load()
        existing.insert(entry, at: 0)
        HistoryStore.shared.save(existing)
    }


}
