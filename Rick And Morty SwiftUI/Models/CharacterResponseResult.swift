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
    let gender: String
    let image: String
    let origin: LocationObject
    let location: LocationObject
    let episode: [String]
    
    func getEpisodesArray() -> [EpisodeObject] {
        var episodeObjects: [EpisodeObject] = []
        
        let allowedCharset = CharacterSet.decimalDigits
        
        for episodeItem in episode {
            
            var season = ""

            if let filteredEpisodeNumber = Int(String(episodeItem.unicodeScalars.filter(allowedCharset.contains))) {
                
                switch (filteredEpisodeNumber) {
                case K.startingEpiodeOfSeason["Season 1"]!...K.startingEpiodeOfSeason["Season 2"]!-1:
                    season = "Season 1"
                case K.startingEpiodeOfSeason["Season 2"]!...K.startingEpiodeOfSeason["Season 3"]!-1:
                    season = "Season 2"
                case K.startingEpiodeOfSeason["Season 3"]!...K.startingEpiodeOfSeason["Season 4"]!-1:
                    season = "Season 3"
                case K.startingEpiodeOfSeason["Season 4"]!...K.startingEpiodeOfSeason["Season 5"]!-1:
                    season = "Season 4"
                case K.startingEpiodeOfSeason["Season 5"]!...K.startingEpiodeOfSeason["Season 6"]!-1:
                    season = "Season 5"
                default:
                    season = "Season N"
                }
                
                let episodeNumberInSeason = filteredEpisodeNumber - K.startingEpiodeOfSeason[season]! + 1

                let currentSeason = episodeObjects.filter{ $0.season == season }
                if (currentSeason.isEmpty) {
                    episodeObjects.append(EpisodeObject(season: season, episodes: [Episode(id: filteredEpisodeNumber, episodeInSeason: "Episode \(episodeNumberInSeason)")]))
                } else {
                    if let index = episodeObjects.firstIndex(where: {$0.season == season}) {
                        var newElement = episodeObjects[index]
                        newElement.episodes.append(Episode(id: filteredEpisodeNumber, episodeInSeason: "Episode \(episodeNumberInSeason)"))
                        episodeObjects[index] = newElement
                    }
                }
                
            }
        }
        return episodeObjects
    }
}

struct LocationObject: Decodable {
    let name: String
    let url: String
}

struct EpisodeObject: Identifiable {
    let id = UUID()
    let season: String
    var episodes: [Episode]
}

struct Episode: Hashable {
    let id: Int
    let episodeInSeason: String
}



