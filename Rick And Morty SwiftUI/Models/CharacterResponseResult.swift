//
//  CharacterResponseResult.swift
//  Rick And Morty SwiftUI
//
//  Created by Vitalii Azarov on 2022-03-29.
//

import Foundation

struct CharacterResponceResult: Decodable {
    let info: Info
    let results: [Character]
}

struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Character: Decodable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
}
