//
//  ContentView.swift
//  Rick And Morty SwiftUI
//
//  Created by Vitalii Azarov on 2022-03-29.
//

import SwiftUI

struct CharactersListView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    @State private var showingSearch = false
    
    var body: some View {
        NavigationView {
            List(networkManager.characters) {character in
                NavigationLink(destination: CharacterDetailsView(character: character)) {
                    CharacterCell(character: character)
                        .onAppear {
                            networkManager.loadMoreContentIfNeeded(currentItem: character)
                        }
                }

            }
            .navigationTitle(Text("Characters"))
            .navigationBarItems(trailing:
                Button(action: {
                    showingSearch.toggle()
                    print("Edit button pressed...")
                }) {
                    Text("Filters")
//                    Image(systemName: "pencil").imageScale(.large)
                }
                    .sheet(isPresented: $showingSearch) {
                CharacterSearchView(networkManager: networkManager)
                }
            )
            .overlay(Group {
                if networkManager.isDataMissing {
                    Text("No characters matching parameters found. \nPlease adjust the filters.")
                        .multilineTextAlignment(.center)
                }
            })
            if networkManager.isLoadingPage {
                ProgressView()
            }

        }
    }
    
}

struct CharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersListView()
    }
}
