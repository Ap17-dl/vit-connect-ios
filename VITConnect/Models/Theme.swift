//
//  Theme.swift
//  VITConnect
//

import Foundation
import SwiftUI

struct AppTheme: Codable, Identifiable {
    let id: String
    let name: String
    let primaryColor: ThemeColor
    let secondaryColor: ThemeColor
    let accentColor: ThemeColor
    let backgroundColor: ThemeColor
    let isDarkMode: Bool
}

struct ThemeColor: Codable {
    let red: Double
    let green: Double
    let blue: Double
    let alpha: Double
    
    var color: Color {
        Color(red: red, green: green, blue: blue, opacity: alpha)
    }
}

class ThemeManager: ObservableObject {
    @Published var currentTheme: AppTheme
    @Published var availableThemes: [AppTheme] = []
    
    init() {
        // Default theme
        self.currentTheme = AppTheme(
            id: "default",
            name: "Default",
            primaryColor: ThemeColor(red: 0.0, green: 0.478, blue: 1.0, alpha: 1.0),
            secondaryColor: ThemeColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0),
            accentColor: ThemeColor(red: 1.0, green: 0.584, blue: 0.0, alpha: 1.0),
            backgroundColor: ThemeColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0),
            isDarkMode: false
        )
        loadThemes()
    }
    
    func loadThemes() {
        // Load predefined themes
        availableThemes = [
            currentTheme,
            AppTheme(
                id: "dark",
                name: "Dark Mode",
                primaryColor: ThemeColor(red: 0.0, green: 0.478, blue: 1.0, alpha: 1.0),
                secondaryColor: ThemeColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0),
                accentColor: ThemeColor(red: 1.0, green: 0.584, blue: 0.0, alpha: 1.0),
                backgroundColor: ThemeColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0),
                isDarkMode: true
            ),
            AppTheme(
                id: "purple",
                name: "Purple",
                primaryColor: ThemeColor(red: 0.5, green: 0.0, blue: 0.5, alpha: 1.0),
                secondaryColor: ThemeColor(red: 0.7, green: 0.3, blue: 0.7, alpha: 1.0),
                accentColor: ThemeColor(red: 0.8, green: 0.4, blue: 0.8, alpha: 1.0),
                backgroundColor: ThemeColor(red: 0.98, green: 0.95, blue: 0.98, alpha: 1.0),
                isDarkMode: false
            ),
            AppTheme(
                id: "green",
                name: "Green",
                primaryColor: ThemeColor(red: 0.0, green: 0.6, blue: 0.2, alpha: 1.0),
                secondaryColor: ThemeColor(red: 0.3, green: 0.7, blue: 0.4, alpha: 1.0),
                accentColor: ThemeColor(red: 0.2, green: 0.8, blue: 0.3, alpha: 1.0),
                backgroundColor: ThemeColor(red: 0.95, green: 0.98, blue: 0.95, alpha: 1.0),
                isDarkMode: false
            )
        ]
    }
    
    func applyTheme(_ theme: AppTheme) {
        currentTheme = theme
        // Save to UserDefaults
        if let encoded = try? JSONEncoder().encode(theme) {
            UserDefaults.standard.set(encoded, forKey: "selectedTheme")
        }
    }
    
    var colorScheme: ColorScheme? {
        currentTheme.isDarkMode ? .dark : .light
    }
}

