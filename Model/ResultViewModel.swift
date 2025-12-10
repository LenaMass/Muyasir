//
//  ResultViewModel.swift
//
//  Created by Shahad Alharbi on 11/27/25.
//

import Foundation
import Combine

@MainActor
final class ResultViewModel: ObservableObject {
    @Published var isHandMode: Bool = false
    @Published var outputText: String
    @Published var handLines: [[String]] = []
    
    init(simplifiedText: String) {
        self.outputText = simplifiedText
        self.isHandMode = false
        processHandContent()
    }
    
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
    
    // MARK: - Letter processing merged
    
    private let letterMap: [String: String] = [
        "ع": "aeen",
        "ال": "al",
        "ا": "alf",
        "أ": "alfHamza",
        "آ": "alfMd",
        "ب": "ba",
        "د": "dal",
        "ف": "fa",
        "ق": "gaf",
        "غ": "ghen",
        "ح": "ha",
        "ه": "haa",
        "ء": "Hamza",
        "ئ": "HamzaMaqsora",
        "إ": "hamzaTahtAlsater",
        "ؤ": "hamzaWow",
        "ج": "jeem",
        "ك": "kaf",
        "خ": "kha",
        "لا": "la",
        "ل": "lam",
        "م": "meem",
        "ن": "noon",
        "ر": "ra",
        "ص": "sad",
        "س": "seen",
        "ش": "sheen",
        "ت": "ta",
        "ط": "taa",
        "ة": "taMarbota",
        "ث": "tha",
        "ظ": "thaad",
        "ض": "thad",
        "ذ": "thal",
        "و": "wow",
        "ي": "ya",
        "ز": "za"
    ]
    
    private func splitText(_ text: String) -> [String] {
        var letters: [String] = []
        let arr = Array(text)
        
        var index = 0
        while index < arr.count {
            if index < arr.count - 1 {
                let pair = String(arr[index]) + String(arr[index + 1])
                if pair == "لا" {
                    letters.append(pair)
                    index += 2
                    continue
                }
            }
            letters.append(String(arr[index]))
            index += 1
        }
        return letters
    }
    
    private func processHandContent() {
        let words = outputText.split(separator: " ")
        var allLines: [[String]] = []
        
        for word in words {
            let letters = splitText(String(word))
            let mapped = letters.compactMap { letterMap[$0] }
            allLines.append(mapped)
        }
        
        self.handLines = allLines
    }
}
