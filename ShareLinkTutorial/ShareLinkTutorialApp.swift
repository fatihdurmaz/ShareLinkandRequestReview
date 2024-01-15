//
//  ShareLinkTutorialApp.swift
//  ShareLinkTutorial
//
//  Created by Fatih Durmaz on 15.01.2024.
//

import SwiftUI

@main
struct ShareLinkTutorialApp: App {
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        
    }
    
    var body: some Scene {
        
        WindowGroup {
            ContentView()
        }
    }
}
