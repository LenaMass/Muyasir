import SwiftUI
import Combine

@MainActor
final class HistoryViewModel: ObservableObject {
    @Published var sortByFavorites: Bool = false
    @Published private(set) var notes: [HistoryEntry] = []

    init() {
        notes = HistoryStore.shared.load()
    }

    var sortedNotes: [HistoryEntry] {
        if sortByFavorites {
            return notes.filter { $0.isFavorite }
        } else {
            return notes.sorted { $0.date > $1.date }
        }
    }

    func toggleFavorite(for entry: HistoryEntry) {
        guard let idx = notes.firstIndex(of: entry) else { return }
        notes[idx].isFavorite.toggle()
        HistoryStore.shared.save(notes)
    }

    func reload() {
        notes = HistoryStore.shared.load()
    }
}
