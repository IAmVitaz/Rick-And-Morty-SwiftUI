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

struct GeneralEpisode: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let season: String
    let episodeInSeason: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case air_date
        case episode
        case characters
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        air_date = try values.decode(String.self, forKey: .air_date)
        
        let episodeCode = try values.decode(String.self, forKey: .episode)
        episode = episodeCode
        characters = try values.decode([String].self, forKey: .characters)
        
        season = getSeason(episodeCode: episodeCode)
        episodeInSeason = getEpisode(episodeCode: episodeCode)
    }
    
    init(id: Int, name: String, air_date: String, episode: String, characters: [String], season: String, episodeInSeason: String) {
        self.id = id
        self.name = name
        self.air_date = air_date
        self.episode = episode
        self.characters = characters
        self.season = season
        self.episodeInSeason = episodeInSeason

    }

    
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
    
    func getOverallEpisode() -> String {
        if id < 10 {
            return "0\(id)"
        }else {
            return String(id)
        }
    }
}

func getSeason(episodeCode: String) -> String {
    let startIndex = episodeCode.index(episodeCode.startIndex, offsetBy: 1)
    let endIndex = episodeCode.index(episodeCode.startIndex, offsetBy: 3)
    let range = startIndex..<endIndex
    let mySubstring = episodeCode[range]
    return String(mySubstring)
}

func getEpisode(episodeCode: String) -> String {
    let startIndex = episodeCode.index(episodeCode.startIndex, offsetBy: 4)
    let endIndex = episodeCode.index(episodeCode.startIndex, offsetBy: 6)
    let range = startIndex..<endIndex
    let substring = episodeCode[range]
    return String(substring)
}

func getEpisodesArray(listOfGeneralEpisodes: [GeneralEpisode]) -> [EpisodeObject] {
    var episodeObjects: [EpisodeObject] = []
    
    for episode in listOfGeneralEpisodes {
        let season = "Season \(episode.season)"
        let currentSeason = episodeObjects.filter{ $0.season == season }
        if (currentSeason.isEmpty) {
            episodeObjects.append(EpisodeObject(season: season, episodes: [episode]))
        } else {
            if let index = episodeObjects.firstIndex(where: {$0.season == season}) {
                var newElement = episodeObjects[index]
                newElement.episodes.append(episode)
                episodeObjects[index] = newElement
            }
        }
    }
    return episodeObjects
}

struct EpisodeObject: Identifiable {
    let id = UUID()
    let season: String
    var episodes: [GeneralEpisode]
}
