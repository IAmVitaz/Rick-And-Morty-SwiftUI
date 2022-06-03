//
//  CharacterResponseResult.swift
//  Rick And Morty SwiftUI
//
//  Created by Vitalii Azarov on 2022-03-29.
//

import Foundation

struct CharacterResponceResult: Decodable {
    let info: Info
    let results: [GeneralCharacter]
}

struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct GeneralCharacter: Decodable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
    let origin: LocationObject
    let location: LocationObject
    let episode: [String]
        
    func getListOfEpisodes() -> String {
        var listOfEpisodes = ""
        var episodesProceeded = 0
        let allowedCharset = CharacterSet.decimalDigits
        
        for epis in episode {
            if let filteredEpisodeId = Int(String(epis.unicodeScalars.filter(allowedCharset.contains))) {
                listOfEpisodes += String(filteredEpisodeId)
                episodesProceeded += 1
                if episodesProceeded < episode.count {
                    listOfEpisodes += ","
                }
            }
        }
        
        return listOfEpisodes
    }

}

struct LocationObject: Decodable {
    let name: String
    let url: String
}
