//
//  NetworkManager.swift
//  Rick And Morty SwiftUI
//
//  Created by Vitalii Azarov on 2022-03-29.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var characters = [Character]()
    
    func fetchData() {
        if let url = URL(string: "https://rickandmortyapi.com/api/character") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(CharacterResponceResult.self, from: safeData)
                            DispatchQueue.main.async {
                                self.characters = results.results
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
    
}
