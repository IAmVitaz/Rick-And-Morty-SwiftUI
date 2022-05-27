//
//  Rick_And_Morty_SwiftUI_Tests.swift
//  Rick And Morty SwiftUI Tests
//
//  Created by Vitalii Azarov on 2022-04-24.
//

import XCTest
@testable import Rick_And_Morty_SwiftUI

class Rick_And_Morty_SwiftUI_Tests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
    }
    
    func testCharacterListGeneratedCorrectlyForGeneralEpisode() {
        // given
        let episode = GeneralEpisode(id: 1, name: "Test", air_date: "December 2, 2013", episode: "S01E01",
                                    characters: ["https://rickandmortyapi.com/api/character/1",
                                                  "https://rickandmortyapi.com/api/character/2",
                                                  "https://rickandmortyapi.com/api/character/35",
                                                  "https://rickandmortyapi.com/api/character/38",
                                                  "https://rickandmortyapi.com/api/character/62",
                                                  "https://rickandmortyapi.com/api/character/92"])

        // when
        let characterList = episode.getListOfCharacters()

        // then
        XCTAssertEqual(characterList, "1,2,35,38,62,92", "List of characters is wrong")
    }
    
    func testCharacterListGeneratedCorrectlyForGeneralEpisodeWithZeroCharacters() {
        // given
        let episode = GeneralEpisode(id: 1, name: "Test", air_date: "December 2, 2013", episode: "S01E01",
                                    characters: [])

        // when
        let characterList = episode.getListOfCharacters()

        // then
        XCTAssertEqual(characterList, "", "List of characters is wrong")
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
