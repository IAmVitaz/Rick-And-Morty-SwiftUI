//
//  EpisodeNetworkManager.swift
//  Rick And Morty SwiftUI
//
//  Created by Vitalii Azarov on 2022-05-27.
//

import Foundation

class EpisodeNetworkManager: ObservableObject {
    
    @Published var episodes = [GeneralEpisode]()
    @Published var isLoadingPage = false
    @Published var isDataMissing = false
    private var currentPage = 1
    private var canLoadMorePages = true
    
    func loadContent() {
        loadMoreContent()
    }
    
    func loadContentForSelectedEpisodes(list: String) {
        let customUrl = SearchOptions.generateCharacterURLForListOfEpisodes(listString: list)
        loadMoreContent(customUrl: customUrl)
    }

    func loadMoreContentIfNeeded(currentItem item: GeneralEpisode?) {
        guard let item = item else {
            loadMoreContent()
            return
        }

        let thresholdIndex = episodes.index(episodes.endIndex, offsetBy: -5)
        if episodes.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
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
                                let results = try decoder.decode([GeneralEpisode].self, from: safeData)
                                DispatchQueue.main.async {
                                    self.episodes += results

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
            if let url = URL(string: "\(SearchOptions.generateEpisodeURL(currentPage: currentPage))") {
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { data, response, error in
                    if error == nil {
                        let decoder = JSONDecoder()
                        if let safeData = data {
                            do {
                                let results = try decoder.decode(EpisodeResponceResult.self, from: safeData)
                                DispatchQueue.main.async {
                                    self.episodes += results.results

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
        episodes = []
        canLoadMorePages = true
        isLoadingPage = false

        loadMoreContent()
    }
    
}
