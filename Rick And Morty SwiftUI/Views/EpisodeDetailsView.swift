//
//  EpisodeDetailsView.swift
//  Rick And Morty SwiftUI
//
//  Created by Vitalii Azarov on 2022-05-28.
//

import SwiftUI

struct EpisodeDetailsView: View {
    
    let episode: GeneralEpisode
    
    var body: some View {
        ScrollView(.vertical) {
            Image("season_\(episode.getSeason())")
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack {
                Group {
                    HStack() {
                        Text("Name:")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        Text("\(episode.name)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } .padding(.top)
                    Divider()
                }
                Group {
                    HStack() {
                        Text("Season:")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        Text("\(episode.getSeason())")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Divider()
                }
                Group {
                    HStack() {
                        Text("Episode:")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        Text("\(episode.getEpisode())")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Divider()
                }
                Group {
                    HStack() {
                        Text("Episode overall:")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        Text("\(episode.getOverallEpisode())")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Divider()
                }
                Group {
                    HStack() {
                        Text("Air date:")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        Text("\(episode.air_date)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Divider()
                }
                Group {
                    VStack {
                        Text("Characters:")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        ForEach(character.getEpisodesArray()) { episodeObject in
                            Section(header: Text(episodeObject.season)) {
                                FlexibleView(
                                    data: episodeObject.episodes,
                                    spacing: 8,
                                    alignment: .leading
                                ) { episode in
                                    Text(verbatim: episode.episodeInSeason)
                                        .padding(8)
                                        .background(
                                            RoundedRectangle(cornerRadius: 16)
                                                .fill(Color.blue.opacity(0.2))
                                        )
                                }
                                .padding(.horizontal, 16)
                            }
                        }
                    }

                }
                
            }
        }
    }
}

struct EpisodeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeDetailsView(episode: testEpisode)
            .previewLayout(.sizeThatFits)
            
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
    ]
)
