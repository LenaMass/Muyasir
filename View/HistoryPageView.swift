import SwiftUI

struct SheetItem: Identifiable {
    let id = UUID()
    let viewModel: ResultViewModel
}

struct HistoryPageView: View {
    @StateObject var viewModel = HistoryViewModel()
    @State private var sheetItem: SheetItem? = nil
    @State private var showDeleteAlert = false
    @State private var entryToDelete: HistoryEntry? = nil

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // ===== Top Bar =====
                topBar

                // ===== History Cards =====
                List {
                    ForEach(viewModel.sortedNotes) { note in
                        historyCard(for: note)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .padding(.horizontal, 10)

                Spacer()
            }
            .background(Color(.systemBackground))
            .environment(\.layoutDirection, .rightToLeft)
            .navigationTitle("المحفوظات")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(item: $sheetItem) { item in
                HistoryDetailSheetView(viewModel: item.viewModel)
            }
            .alert("تأكيد الحذف ؟",
                   isPresented: $showDeleteAlert,
                   presenting: entryToDelete) { entry in
                Button("حذف", role: .destructive) {
                    viewModel.delete(entry)
                    entryToDelete = nil
                }
                Button("إلغاء", role: .cancel) {
                    entryToDelete = nil
                }
            }
        }
    }

    // ✅ Top Bar
    var topBar: some View {
        HStack {
            Button {
                viewModel.sortByFavorites.toggle()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(.ultraThinMaterial)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(Color.black.opacity(0.15), lineWidth: 1)
                        )
                        .shadow(color: Color.black.opacity(0.12),
                                radius: 6, x: 0, y: 3)

                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .font(.title3.bold())
                        .foregroundColor(.maingreen)
                }
                .frame(width: 40, height: 40)
            }
            .padding(.leading, 300)

            Spacer()
        }
        .padding(.horizontal, 30)
        .padding(.top, 20)
        .padding(.bottom, 30)
    }

    // ✅ History Card
    func historyCard(for note: HistoryEntry) -> some View {
        Button {
            let vm = ResultViewModel(simplifiedText: note.text)
            sheetItem = SheetItem(viewModel: vm)
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(note.text)
                        .font(.body)
                        .foregroundColor(.primary)
                        .lineLimit(2)

                    Text(note.date.formatted(date: .numeric, time: .omitted))
                        .font(.footnote)
                        .foregroundColor(.gray)
                }

                Spacer()

                Button {
                    viewModel.toggleFavorite(for: note)
                } label: {
                    Image(systemName: note.isFavorite ? "star.fill" : "star")
                        .foregroundColor(note.isFavorite ? .yellow : .gray)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(.ultraThinMaterial)
                    .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 3)
            )
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                entryToDelete = note
                showDeleteAlert = true
            } label: {
                Label("حذف", systemImage: "trash")
            }
        }
    }
}
