//
//  VITConnectApp.swift
//  VITConnect
//
//  Created for VIT Chennai Students
//

import SwiftUI

@main
struct VITConnectApp: App {
    @StateObject private var themeManager = ThemeManager()
    @StateObject private var authManager = AuthManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeManager)
                .environmentObject(authManager)
                .preferredColorScheme(themeManager.currentTheme.colorScheme)
        }
    }
}

