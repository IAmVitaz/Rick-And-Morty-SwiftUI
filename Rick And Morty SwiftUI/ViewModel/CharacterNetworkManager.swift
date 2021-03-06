//
//  NetworkManager.swift
//  Rick And Morty SwiftUI
//
//  Created by Vitalii Azarov on 2022-03-29.
//

import Foundation

class CharacterNetworkManager: ObservableObject {
    
    @Published var characters = [GeneralCharacter]()
    @Published var isLoadingPage = false
    @Published var isDataMissing = false
    private var currentPage = 1
    private var canLoadMorePages = true
    
    func loadContent() {
        loadMoreContent()
    }
    
    func loadContentForSelectedUsers(list: String) {
        let customUrl = SearchOptions.generateCharacterURLForListOfCharacters(listString: list)
        loadMoreContent(customUrl: customUrl)
    }
    
    func loadMoreContentIfNeeded(currentItem item: GeneralCharacter?) {
        guard let item = item else {
            loadMoreContent()
            return
        }
        
        let thresholdIndex = characters.index(characters.endIndex, offsetBy: -5)
        if characters.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
            loadMoreContent()
        }
    }
    
    private func loadMoreContent(customUrl: String = "") {
        guard !isLoadingPage && canLoadMorePages else {
            return
        }
        
        isLoadingPage = true
        
        let isCustomUrlUsed = customUrl != ""
        
        if isCustomUrlUsed {
            if let url = URL(string: customUrl) {
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { data, response, error in
                    if error == nil {
                        let decoder = JSONDecoder()
                        if let safeData = data {
                            do {
                                let results = try decoder.decode([GeneralCharacter].self, from: safeData)
                                DispatchQueue.main.async {
                                    self.characters += results

                                    self.canLoadMorePages = false
                                    self.isLoadingPage = false
                                    self.isDataMissing = false
                                }
                            } catch {
                                print(error)
                                DispatchQueue.main.async {
                                    self.isDataMissing = true
                                }
                            }
                        }
                    }
                }
                task.resume()
            }
        } else {
            if let url = URL(string: "\(SearchOptions.generateCharacterURL(currentPage: currentPage))") {
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { data, response, error in
                    if error == nil {
                        let decoder = JSONDecoder()
                        if let safeData = data {
                            do {
                                let results = try decoder.decode(CharacterResponceResult.self, from: safeData)
                                DispatchQueue.main.async {
                                    self.characters += results.results
                                    
                                    self.canLoadMorePages = results.info.next != nil
                                    self.isLoadingPage = false
                                    self.currentPage += 1
                                    self.isDataMissing = false
                                }
                            } catch {
                                print(error)
                                DispatchQueue.main.async {
                                    self.isDataMissing = true
                                }
                            }
                        }
                    }
                }
                task.resume()
            }
        }
    }
    
    func reloadData() {
        currentPage = 1
        characters = []
        canLoadMorePages = true
        isLoadingPage = false
        
        loadMoreContent()
    }
    
}
