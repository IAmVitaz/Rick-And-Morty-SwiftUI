//
//  MainView.swift
//  Rick And Morty SwiftUI
//
//  Created by Vitalii Azarov on 2022-04-21.
//

import SwiftUI

struct MainView: View {
    
//    init() {
//        UITabBar.appearance().barTintColor = UIColor(Color(colorExtraLight))
//    }
    
    var body: some View {
        TabView {
            CharactersListView()
                .tabItem {
                    Label("Characters", systemImage: "person.3.fill")
                }
            EpisodesListView()
                .tabItem {
                    Label("Episodes", systemImage: "list.dash")
                }
        }
        .onAppear {
            // Currently tabbar color changes to transparent on the bottob of the current page
            // This causes "blinking" when transit to details page. This tweak fix the issue.
            if #available(iOS 15.0, *) {
                let appearance = UITabBarAppearance()
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
