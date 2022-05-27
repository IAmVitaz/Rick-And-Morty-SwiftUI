//
//  EpisodeResponseResult.swift
//  Rick And Morty SwiftUI
//
//  Created by Vitalii Azarov on 2022-04-24.
//

import Foundation

struct EpisodeResponceResult: Decodable {
    let info: Info
    let results: [GeneralEpisode]
}

struct GeneralEpisode: Decodable, Identifiable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    
    func getListOfCharacters() -> String {
        var listOfCharacters = ""
        var charactersProceeded = 0
        let allowedCharset = CharacterSet.decimalDigits
        
        for character in characters {
            if let filteredCharacterId = Int(String(character.unicodeScalars.filter(allowedCharset.contains))) {
                listOfCharacters += String(filteredCharacterId)
                charactersProceeded += 1
                if charactersProceeded < characters.count {
                    listOfCharacters += ","
                }
            }
        }
        
        return listOfCharacters
    }
}
