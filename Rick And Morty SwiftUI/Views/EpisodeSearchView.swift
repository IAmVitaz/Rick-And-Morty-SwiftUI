//
//  EpisodeSearchView.swift
//  Rick And Morty SwiftUI
//
//  Created by Vitalii Azarov on 2022-05-28.
//

import SwiftUI

struct EpisodeSearchView: View {
    
    @State private var selectedSeasonIndex = SearchOptions.seasonSelected
    @State private var episodeName = SearchOptions.episodeName
    
    let networkManager: EpisodeNetworkManager
    
    let seasons = SearchOptions.seasons
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker(selection: $selectedSeasonIndex, label: Text("Season")) {
                        ForEach(0..<seasons.count) {
                            Text(self.seasons[$0]).tag($0)
                        }
                    }
                    TextField("Episode Name", text: $episodeName)
                }
                Section {
                    Button {
                        updateSearchParams()
                        networkManager.reloadData()
                        dismiss()
                    } label: {
                        Text("Apply")
                    }
                }
                Section {
                    Button {
                        resetSearchParams()
                        networkManager.reloadData()
                        dismiss()
                    } label: {
                        Text("Reset")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle(Text("Episode Filters"))
        }
    }
    
    private func updateSearchParams() {
        SearchOptions.seasonSelected = selectedSeasonIndex
        SearchOptions.episodeName = episodeName
    }
    private func resetSearchParams() {
        SearchOptions.seasonSelected = 0
        SearchOptions.episodeName = ""
    }
    
}

struct EpisodeSearchView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeSearchView(networkManager: EpisodeNetworkManager())
    }
}
