//
//  Note.swift
//  Team12
//
//  Created by رحاب فهد  on 11/06/1447 AH.
//

import Foundation

struct Note: Identifiable, Codable, Equatable {
    let id: UUID
    let text: String
    let date: Date
    var isFavorite: Bool
}
