//
//  Untitled.swift
//  Team12
//
//  Created by رحاب فهد  on 11/06/1447 AH.
//

import Foundation

struct HistoryEntry: Identifiable, Codable, Equatable {
    let id: String
    let text: String
    let date: Date
    var isFavorite: Bool
}

final class HistoryStore {
    static let shared = HistoryStore()
    private init() {}
    
    private let key = "history_entries"
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func load() -> [HistoryEntry] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let entries = try? decoder.decode([HistoryEntry].self, from: data) else {
            return []
        }
        return entries
    }
    
    func save(_ entries: [HistoryEntry]) {
        if let data = try? encoder.encode(entries) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}

