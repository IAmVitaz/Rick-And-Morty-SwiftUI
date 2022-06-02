//
//  CharacterSearchOptions.swift
//  Rick And Morty SwiftUI
//
//  Created by Vitalii Azarov on 2022-04-04.
//

import Foundation

struct SearchOptions {
    
    static let baseURL = "https://rickandmortyapi.com/api/"
    
    // character parameters:
    static var genderSelected = 0
    static var statusSelected = 0
    static var characterName = ""
    
    static let gender = [
        "All",
        "Female",
        "Male",
        "Genderless",
        "unknown"
    ]
    static let status = [
        "All",
        "Alive",
        "Dead",
        "unknown"
    ]
    
    // episode parameters:
    static var episodeName = ""
    static var seasonSelected = 0
    static let seasons = [
        "All",
        "Season 1",
        "Season 2",
        "Season 3",
        "Season 4",
        "Season 5"
    ]
    
    
    static func generateCharacterURL(currentPage: Int) -> String {
        var isFirstParameter = true
        var adjustedURL = baseURL + "character"
        if genderSelected != 0 {
            adjustedURL += "?gender=\(gender[genderSelected].lowercased())"
            isFirstParameter = false
        }
        if statusSelected != 0 {
            adjustedURL += "\(isFirstParameter ? "?" : "&")status=\(status[statusSelected].lowercased())"
            isFirstParameter = false
        }
        if characterName != "" {
            adjustedURL += "\(isFirstParameter ? "?" : "&")name=\(characterName.lowercased())"
            isFirstParameter = false
        }
        
        adjustedURL += "\(isFirstParameter ? "?" : "&")page=\(currentPage)"

        return adjustedURL
    }
    
    static func generateCharacterURLForListOfCharacters(listString: String) -> String {
        var adjustedURL = baseURL + "character/"
        adjustedURL += listString
        return adjustedURL
    }
    
    static func generateCharacterURLForListOfEpisodes(listString: String) -> String {
        var adjustedURL = baseURL + "episode/"
        adjustedURL += listString
        return adjustedURL
    }
    
    static func generateEpisodeURL(currentPage: Int) -> String {
        var isFirstParameter = true
        var adjustedURL = baseURL + "episode"
        if seasonSelected != 0 {
            let seasonCode = "S0\(seasonSelected)"
            adjustedURL += "?episode=\(seasonCode)"
            isFirstParameter = false
        }
        if episodeName != "" {
            adjustedURL += "\(isFirstParameter ? "?" : "&")name=\(episodeName.lowercased())"
            isFirstParameter = false
        }
        
        adjustedURL += "\(isFirstParameter ? "?" : "&")page=\(currentPage)"

        return adjustedURL
    }
}
