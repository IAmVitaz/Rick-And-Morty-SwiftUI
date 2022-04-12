//
//  NetworkManager.swift
//  Rick And Morty SwiftUI
//
//  Created by Vitalii Azarov on 2022-03-29.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var characters = [Character]()
    @Published var isLoadingPage = false
    private var currentPage = 1
    private var canLoadMorePages = true
    
    init() {
      loadMoreContent()
    }

    func loadMoreContentIfNeeded(currentItem item: Character?) {
        guard let item = item else {
            loadMoreContent()
            return
        }
        
        let thresholdIndex = characters.index(characters.endIndex, offsetBy: -5)
        if characters.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
            loadMoreContent()
        }
    }
    
    private func loadMoreContent() {
        guard !isLoadingPage && canLoadMorePages else {
            return
        }
        
        isLoadingPage = true
        
        if let url = URL(string: "\(CharacterSearchOptions.generateCharacterURL(currentPage: currentPage))") {
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
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
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
