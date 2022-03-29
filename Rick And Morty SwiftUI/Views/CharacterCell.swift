//
//  CharacterCell.swift
//  Rick And Morty SwiftUI
//
//  Created by Vitalii Azarov on 2022-03-29.
//

import SwiftUI

struct CharacterCell: View {
    
    var character: Character
    
    var body: some View {
        HStack {
            Image(systemName: "phone.fill")
            VStack(alignment: .leading) {
                Text(character.name)
                    .fontWeight(.bold)
                    .font(.system(size: 25))
                Text("\(character.status) - \(character.species)")
                    .padding(.bottom)
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

var character = Character(id: 0, name: "Alpha", status: "Alive", species: "Human")

