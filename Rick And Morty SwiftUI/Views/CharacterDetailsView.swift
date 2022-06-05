//
//  CharacterDetailsView.swift
//  Rick And Morty SwiftUI
//
//  Created by Vitalii Azarov on 2022-04-12.
//

import SwiftUI

struct CharacterDetailsView: View {
    
    let character: GeneralCharacter
    @StateObject var episodeNetworkManager = EpisodeNetworkManager()
    
    @State private var episodeInCharacterSelected: GeneralEpisode? = nil
    
    var body: some View {
        ScrollView(.vertical) {
            AsyncImage(url: URL(string: character.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                case .failure:
                    Image(systemName: "x.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                @unknown default:
                    // Since the AsyncImagePhase enum isn't frozen,
                    // we need to add this currently unused fallback
                    // to handle any new cases that might be added
                    // in the future:
                    EmptyView()
                }
                
                VStack {
                    Group {
                        HStack() {
                            Text("Name:")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                            Text("\(character.name)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        } .padding(.top)
                        Divider()
                    }
                    Group {
                        HStack() {
                            Text("Species:")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                            Text("\(character.species)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Divider()
                    }
                    Group {
                        HStack() {
                            Text("Gender:")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                            HStack(alignment: .firstTextBaseline) {
                                Text("\(character.gender)")
                                Text(getGenderType(gender: character.gender))
                                    .fontWeight(.heavy)
                                    .font(.system(size: 20))
                                    .foregroundColor(getGenderColor(gender: character.gender))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Divider()
                    }
                    Group {
                        HStack() {
                            Text("Status:")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                            HStack {
                                Text("\(character.status)")
                                Circle()
                                    .frame(width: 10, height: 10, alignment: .center)
                                    .foregroundColor(getStatusColor(status: character.status))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Divider()
                    }
                    Group {
                        HStack() {
                            Text("First seen in:")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                            Text("\(character.origin.name)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Divider()
                    }
                    Group {
                        HStack() {
                            Text("Last known location:")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                            Text("\(character.location.name)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Divider()
                    }
                    
                    Group {
                        VStack {
                            Text("Appeared in:")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                                .onAppear{
                                    print(episodeNetworkManager.episodeObjectArray)
                                }
                            ForEach(episodeNetworkManager.episodeObjectArray) { episodeObject in
                                Section(header: Text(episodeObject.season)) {
                                    FlexibleView(
                                        data: episodeObject.episodes,
                                        spacing: 8,
                                        alignment: .leading
                                    ) { episode in
                                        Button(action: {
                                            self.episodeInCharacterSelected = episode
                                        }) {
                                            Text(verbatim: "Episode \(episode.episodeInSeason)")
                                                .padding(8)
                                                .foregroundColor(.black)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 16)
                                                        .fill(Color.blue.opacity(0.2))
                                                )
                                        }
                                        .sheet(item: self.$episodeInCharacterSelected, content: { episode in
                                            EpisodeDetailsView(episode: episode)
                                        })
                                    }
                                    .padding(.horizontal, 16)
                                }
                            }
                            BannerAd(unitID: K.mainScreenBannerId)
                                .padding(.vertical)
                        }

                    }
                    
                }
            }
            .onAppear {
                episodeNetworkManager.loadContentForSelectedEpisodes(list: character.getListOfEpisodes())
            }
        }

        
    }
    
    struct CharacterDetailsView_Previews: PreviewProvider {
        static var previews: some View {
            var characterForPreview = GeneralCharacter(
                id: 1,
                name: "Rick Sanchez",
                status: "Alive",
                species: "Human",
                gender: "Male",
                image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                origin: LocationObject(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3"),
                location: LocationObject(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1"),
                episode: ["https://rickandmortyapi.com/api/episode/1", "https://rickandmortyapi.com/api/episode/2"]
            )
            
            CharacterDetailsView(character: characterForPreview)
        }
    }
}
