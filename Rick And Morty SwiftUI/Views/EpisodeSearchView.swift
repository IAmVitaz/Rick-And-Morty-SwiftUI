//
//  EpisodeSearchView.swift
//  Rick And Morty SwiftUI
//
//  Created by Vitalii Azarov on 2022-05-28.
//

import SwiftUI

struct EpisodeSearchView: View {
    
    let networkManager: EpisodeNetworkManager
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct EpisodeSearchView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeSearchView(networkManager: EpisodeNetworkManager())
    }
}
