//
//  Untitled.swift
//
//  Created by رحاب فهد  on 11/06/1447 AH.
//

import SwiftUI

struct HistoryPageView: View {
    @StateObject var viewModel = HistoryViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Top Bar
                HStack {
                    Button {
                        viewModel.sortByFavorites.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .font(.title3.bold())
                            .foregroundColor(.maingreen)
                    }

                    Spacer()
                }
                .padding( 30)
                .padding(.top, 20)
                .padding(.bottom, 10)

                // Notes List
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(viewModel.sortedNotes) { note in
                            Button {
                                // Navigate to note detail (optional)
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
        }
        .navigationTitle("المحفوظات")
        .navigationBarTitleDisplayMode(.inline)
    }
}
