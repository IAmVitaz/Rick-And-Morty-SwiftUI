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
    @Published var episodeObjectArray = [EpisodeObject]()
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
                // api returns GeneralEpisode when only 1 episode in the list. It returns [GeneralEpisode] when there are 2+ episodes
                // so additional check is required to specify expected decoding model
                let isSingleItemResponse: Bool = !customUrl.contains(",")
                
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { data, response, error in
                    if error == nil {
                        let decoder = JSONDecoder()
                        if let safeData = data {
                            do {
                                if isSingleItemResponse {
                                    let results = try decoder.decode(GeneralEpisode.self, from: safeData)
                                    self.episodes.append(results)
                                } else {
                                    let results = try decoder.decode([GeneralEpisode].self, from: safeData)
                                    self.episodes += results
                                }
                                
                                DispatchQueue.main.async {
                                    self.canLoadMorePages = false
                                    self.isLoadingPage = false
                                    self.isDataMissing = false
                                    self.episodeObjectArray = getEpisodesArray(listOfGeneralEpisodes: self.episodes)
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
                                    self.episodeObjectArray = getEpisodesArray(listOfGeneralEpisodes: self.episodes)
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
