//
//  CharacterCell.swift
//  Rick And Morty SwiftUI
//
//  Created by Vitalii Azarov on 2022-03-29.
//

import SwiftUI

struct CharacterCell: View {
    
    var character: GeneralCharacter
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: character.image)) { image in image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 100)
                .background(Color.gray)
                .clipShape(Rectangle())
                .padding(.vertical)
            VStack(alignment: .leading, spacing: 5) {
                HStack(alignment: .firstTextBaseline) {
                    Text(character.name)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    Text(getGenderType(gender: character.gender))
                        .fontWeight(.heavy)
                        .font(.system(size: 20))
                        .foregroundColor(getGenderColor(gender: character.gender))
                }
                HStack(alignment: .firstTextBaseline){
                    Circle()
                        .frame(width: 10, height: 10, alignment: .center)
                        .foregroundColor(getStatusColor(status: character.status))
                    Text("\(character.status) - \(character.species)")
                }
                Text("Origin:")
                    .foregroundColor(.gray)
                Text(character.origin.name)
            }
            
        }
    }
}

struct CharacterCell_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCell(character: character)
            .previewLayout(.sizeThatFits)
    }
}

func getStatusColor(status: String) -> Color {
    switch (status) {
    case "Alive":
        return .green
    case "Dead":
        return .red
    case "unknown":
        return .gray
    default:
        return .black
    }
}

func getGenderType(gender: String) -> String {
    switch (gender) {
    case "Male":
        return "♂"
    case "Female":
        return "♀"
    case "unknown":
        return "?"
    default:
        return ""
    }
}

func getGenderColor(gender: String) -> Color {
    switch (gender) {
    case "Male":
        return .blue
    case "Female":
        return .pink
    case "unknown":
        return .yellow
    default:
        return .black
    }
}

var character = GeneralCharacter(
    id: 0,
    name: "Alpha",
    status: "Alive",
    species: "Human",
    gender: "Male",
    image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
    origin: LocationObject(name: "Earth", url: "String"),
    location: LocationObject(name: "Moon", url: "String"),
    episode: ["https://rickandmortyapi.com/api/episode/1", "https://rickandmortyapi.com/api/episode/2"]
)

