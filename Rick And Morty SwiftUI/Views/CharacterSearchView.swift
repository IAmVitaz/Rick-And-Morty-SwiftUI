//
//  CharacterSearchView.swift
//  Rick And Morty SwiftUI
//
//  Created by Vitalii Azarov on 2022-04-04.
//

import SwiftUI

struct CharacterSearchView: View {
    
    @State private var textInput = ""
    @State private var selectedGenderIndex = SearchOptions.genderSelected
    @State private var selectedStatusIndex = SearchOptions.statusSelected
//    @State private var isOn = false
    @State private var characterName = SearchOptions.characterName
    
    let networkManager: CharacterNetworkManager
    
    let genders = SearchOptions.gender
    let status = SearchOptions.status
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {

        NavigationView {
            Form {
                Section {
                    Picker(selection: $selectedGenderIndex, label: Text("Gender")) {
                        ForEach(0..<genders.count) {
                            Text(self.genders[$0]).tag($0)
                        }
                    }
                    Picker(selection: $selectedStatusIndex, label: Text("Status")) {
                        ForEach(0..<status.count) {
                            Text(self.status[$0]).tag($0)
                        }
                    }
                    TextField("Character Name", text: $characterName)
                }
//                Section {
//                    Toggle(isOn: $isOn) {
//                        Text("Would you like to do something?")
//                    }
//
//                    if isOn {
//                        Text("Here is an additional option")
//                            .foregroundColor(.gray)
//                            .font(Font.system(size: 12))
//                    }
//                }
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
            .navigationTitle(Text("Character Filters"))
        }
    }
    
    private func updateSearchParams() {
        SearchOptions.genderSelected = selectedGenderIndex
        SearchOptions.statusSelected = selectedStatusIndex
        SearchOptions.characterName = characterName
    }
    
    private func resetSearchParams() {
        SearchOptions.genderSelected = 0
        SearchOptions.statusSelected = 0
        SearchOptions.characterName = ""
    }
}

struct CharacterSearchView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterSearchView(networkManager: CharacterNetworkManager())
    }
}
