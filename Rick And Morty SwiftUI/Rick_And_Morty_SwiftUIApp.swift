//
//  Rick_And_Morty_SwiftUIApp.swift
//  Rick And Morty SwiftUI
//
//  Created by Vitalii Azarov on 2022-03-29.
//

import SwiftUI
import GoogleMobileAds

@main
struct Rick_And_Morty_SwiftUIApp: App {
    
    init() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
