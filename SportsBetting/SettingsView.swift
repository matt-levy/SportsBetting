//
//  SettingsView.swift
//  SportsBetting
//
//  Created by Matthew Levy on 12/25/23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appearanceManager: AppearanceManager

    var body: some View {
        Form {
            List {
                Toggle("Dark Mode", isOn: $appearanceManager.isDarkMode)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
