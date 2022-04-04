//
//  ContentView.swift
//  Rick And Morty SwiftUI
//
//  Created by Vitalii Azarov on 2022-03-29.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView {
            List(networkManager.characters) {character in
                CharacterCell(character: character)
                    .onAppear {
                        networkManager.loadMoreContentIfNeeded(currentItem: character)
                    }
            }
            .navigationTitle(Text("Characters"))
           
            if networkManager.isLoadingPage {
                ProgressView()
            }

        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//var characterDummyList = [
//    Character(id: 0, name: "Alpha", status: "Alive", species: "Human", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"),
//    Character(id: 0, name: "Beta", status: "Alive", species: "Human", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
//]

