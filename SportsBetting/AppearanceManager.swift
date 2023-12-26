//
//  AppearanceManager.swift
//  SportsBetting
//
//  Created by Matthew Levy on 12/25/23.
//

import Foundation

class AppearanceManager: ObservableObject {
    @Published var isDarkMode: Bool = false {
        didSet {
            UserDefaults.standard.isDarkMode = isDarkMode
            // You can also reload views or apply appearance changes here if necessary
        }
    }
    
    init() {
        self.isDarkMode = UserDefaults.standard.isDarkMode
    }
}
