//
//  EpisodesListView.swift
//  Rick And Morty SwiftUI
//
//  Created by Vitalii Azarov on 2022-04-21.
//

import SwiftUI

struct EpisodesListView: View {
    
    @ObservedObject var episodeNetworkManager = EpisodeNetworkManager()
    @State private var showingSearch = false

    var body: some View {
        NavigationView {
            List(episodeNetworkManager.episodes) {episode in
                NavigationLink(destination: EpisodeDetailsView(episode: episode)) {
                    EpisodeCell(episode: episode)
                        .onAppear {
                            episodeNetworkManager.loadMoreContentIfNeeded(currentItem: episode)
                        }
                }

            }
            .navigationTitle(Text("Episodes"))
            .navigationBarItems(trailing:
                Button(action: {
                    showingSearch.toggle()
                    print("Episodes filter button pressed...")
                }) {
                    Text("Filters")
//                    Image(systemName: "pencil").imageScale(.large)
                }
                    .sheet(isPresented: $showingSearch) {
                EpisodeSearchView(networkManager: episodeNetworkManager)
                }
            )
            .overlay(Group {
                if episodeNetworkManager.isDataMissing {
                    Text("No episodes matching parameters found. \nPlease adjust the filters.")
                        .multilineTextAlignment(.center)
                }
            })
            if episodeNetworkManager.isLoadingPage {
                ProgressView()
            }
        }
        .onAppear{
            episodeNetworkManager.loadContent()
        }
    }
}

struct EpisodesListView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodesListView()
    }
}
