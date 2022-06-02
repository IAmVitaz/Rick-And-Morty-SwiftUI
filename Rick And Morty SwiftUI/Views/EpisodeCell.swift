//
//  EpisodeCell.swift
//  Rick And Morty SwiftUI
//
//  Created by Vitalii Azarov on 2022-05-28.
//

import SwiftUI

struct EpisodeCell: View {

    var episode: GeneralEpisode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(alignment: .firstTextBaseline) {
                Text(episode.name)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
            }
            
            HStack(alignment: .firstTextBaseline) {
                Text("Season:")
                    .foregroundColor(.gray)
                Text(episode.season)
                Spacer()
                Text("Episode:")
                    .foregroundColor(.gray)
                Text(episode.episode)
                    .padding(.trailing)
            }
        }
    }
}

struct EpisodeCell_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeCell(episode: testEpisode)
    }
}

private let testEpisode = GeneralEpisode(
    id: 1,
    name: "Pilot",
    air_date: "December 2, 2013",
    episode: "S01E01",
    characters: [
        "https://rickandmortyapi.com/api/character/1",
        "https://rickandmortyapi.com/api/character/2",
        "https://rickandmortyapi.com/api/character/35",
        "https://rickandmortyapi.com/api/character/38",
        "https://rickandmortyapi.com/api/character/62",
        "https://rickandmortyapi.com/api/character/92",
        "https://rickandmortyapi.com/api/character/127",
        "https://rickandmortyapi.com/api/character/144",
        "https://rickandmortyapi.com/api/character/158",
        "https://rickandmortyapi.com/api/character/175",
        "https://rickandmortyapi.com/api/character/179",
        "https://rickandmortyapi.com/api/character/181",
        "https://rickandmortyapi.com/api/character/239",
        "https://rickandmortyapi.com/api/character/249",
        "https://rickandmortyapi.com/api/character/271",
        "https://rickandmortyapi.com/api/character/338",
        "https://rickandmortyapi.com/api/character/394",
        "https://rickandmortyapi.com/api/character/395",
        "https://rickandmortyapi.com/api/character/435"
    ],
    season: "1",
    episodeInSeason: "1"
)
