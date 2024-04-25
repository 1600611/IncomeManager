//
//  IncomeManagerApp.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 16/4/24.
//

import SwiftUI

@main
struct IncomeManagerApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var themeManager = ThemeManager()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(themeManager)
        }
    }
}
