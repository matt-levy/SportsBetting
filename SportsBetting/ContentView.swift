//
//  ContentView.swift
//  MLB_Betting
//
//  Created by Matthew Levy on 7/19/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var appearanceManager = AppearanceManager()
    
    var body: some View {
        HomeView()
            .environmentObject(appearanceManager)
            .preferredColorScheme(appearanceManager.isDarkMode ? .dark : .light)
    }
}

struct YourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

extension UserDefaults {
    @objc dynamic var isDarkMode: Bool {
        get { bool(forKey: "isDarkMode") }
        set { setValue(newValue, forKey: "isDarkMode") }
    }
}
