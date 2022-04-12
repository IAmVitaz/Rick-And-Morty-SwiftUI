//
//  CharacterSearchView.swift
//  Rick And Morty SwiftUI
//
//  Created by Vitalii Azarov on 2022-04-04.
//

import SwiftUI

struct CharacterSearchView: View {
    
    @State private var textInput = ""
    @State private var selectedGenderIndex = CharacterSearchOptions.genderSelected
    @State private var selectedStatusIndex = CharacterSearchOptions.statusSelected
//    @State private var isOn = false
    @State private var characterName = CharacterSearchOptions.characterName
    
    let networkManager: NetworkManager
    
    let genders = CharacterSearchOptions.gender
    let status = CharacterSearchOptions.status
    
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
            .navigationTitle(Text("Edit Filters"))
        }
    }
    
    private func updateSearchParams() {
        CharacterSearchOptions.genderSelected = selectedGenderIndex
        CharacterSearchOptions.statusSelected = selectedStatusIndex
        CharacterSearchOptions.characterName = characterName
    }
    
    private func resetSearchParams() {
        CharacterSearchOptions.genderSelected = 0
        CharacterSearchOptions.statusSelected = 0
        CharacterSearchOptions.characterName = ""
    }
}

struct CharacterSearchView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterSearchView(networkManager: NetworkManager())
    }
}
