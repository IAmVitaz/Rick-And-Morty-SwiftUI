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
            }
            .navigationTitle(Text("Characters"))
        }
        .onAppear {
            networkManager.fetchData()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

var characterDummyList = [
    Character(id: 0, name: "Alpha", status: "Alive", species: "Human"),
    Character(id: 0, name: "Beta", status: "Alive", species: "Human"),
    Character(id: 0, name: "Gamma", status: "Alive", species: "Human")
]

