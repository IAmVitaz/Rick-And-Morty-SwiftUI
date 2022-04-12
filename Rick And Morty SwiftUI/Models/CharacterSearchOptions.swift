//
//  CharacterSearchOptions.swift
//  Rick And Morty SwiftUI
//
//  Created by Vitalii Azarov on 2022-04-04.
//

import Foundation

struct CharacterSearchOptions {
    
    static let characterURL = "https://rickandmortyapi.com/api/character"
    
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
    
    static func generateCharacterURL(currentPage: Int) -> String {
        var isFirstParameter = true
        var adjustedURL = characterURL
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
}
