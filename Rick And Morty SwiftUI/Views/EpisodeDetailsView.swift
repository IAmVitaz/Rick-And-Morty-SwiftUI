//
//  EpisodeDetailsView.swift
//  Rick And Morty SwiftUI
//
//  Created by Vitalii Azarov on 2022-05-28.
//

import SwiftUI

struct EpisodeDetailsView: View {
    
    let episode: GeneralEpisode
    @StateObject var characterNetworkManager = CharacterNetworkManager()
    
    @State private var characterInEpisodeSelected: GeneralCharacter? = nil
    
    var body: some View {
        ScrollView(.vertical) {
            Image("season_\(episode.season)")
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
                        Text("\(episode.season)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Divider()
                }
                Group {
                    HStack() {
                        Text("Episode:")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        Text("\(episode.episodeInSeason)")
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
                        
                        LazyVGrid(
                            columns: [
                                GridItem(.flexible()), GridItem(.flexible())
                            ],
                            alignment: .center,
                            spacing: 10,
                            pinnedViews: [],
                            content: {
                                ForEach (characterNetworkManager.characters) { character in
                                    Button(action: {
                                        self.characterInEpisodeSelected = character
                                    }) {
                                        VStack {
                                            AsyncImage(url: URL(string: character.image)) { image in image
                                                        .resizable()
                                                        .scaledToFill()
                                                } placeholder: {
                                                    ProgressView()
                                                }
                                                .frame(width: 70, height: 70)
                                                .background(Color.gray)
                                                .clipShape(Circle())
                                                .padding(.top)
                                            
                                            Text(character.name)
                                                .foregroundColor(.black)

                                        }
                                    }
                                    .sheet(item: self.$characterInEpisodeSelected, content: { character in
                                        CharacterDetailsView(character: character)
                                    })
                                }
                            })
                        
                        BannerAd(unitID: K.mainScreenBannerId)
                            .padding(.vertical)
                    }
                }
                
            }
        }
        .onAppear {
            characterNetworkManager.loadContentForSelectedUsers(list: episode.getListOfCharacters())
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
    ],
    season: "1",
    episodeInSeason: "1"
)
