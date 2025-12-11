//
//  HistoryPageView.swift
//

import SwiftUI

// Wrap the ResultViewModel in an Identifiable object for .sheet(item:)
struct SheetItem: Identifiable {
    let id = UUID()
    let viewModel: ResultViewModel
}

struct HistoryPageView: View {
    @StateObject var viewModel = HistoryViewModel()

    // NEW — replaces showSheet & resultVM
    @State private var sheetItem: SheetItem? = nil

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {

                // ===== Top Bar =====
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


                // ===== History Cards =====
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(viewModel.sortedNotes) { note in
                            Button {

                                // Create VM + Assign the sheet item
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
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 20)
                }

                Spacer()
            }
            .background(Color(.systemBackground))
            .environment(\.layoutDirection, .rightToLeft)

            // ===== FIXED SHEET — No blank first time =====
            .sheet(item: $sheetItem) { item in
                HistoryDetailSheetView(viewModel: item.viewModel)
            }
        }
        .navigationTitle("المحفوظات")
        .navigationBarTitleDisplayMode(.inline)
    }
}
