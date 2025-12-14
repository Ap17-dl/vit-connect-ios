//
//  ThemeView.swift
//  VITConnect
//

import SwiftUI
import UIKit

struct ThemeView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State private var showingCustomThemeBuilder = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Current Theme Preview
                    CurrentThemePreview(theme: themeManager.currentTheme)
                    
                    // Predefined Themes
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Predefined Themes")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ForEach(themeManager.availableThemes) { theme in
                            ThemeCard(theme: theme, isSelected: theme.id == themeManager.currentTheme.id) {
                                themeManager.applyTheme(theme)
                            }
                        }
                    }
                    
                    // Custom Theme Builder
                    Button(action: { showingCustomThemeBuilder = true }) {
                        HStack {
                            Image(systemName: "paintbrush.fill")
                            Text("Create Custom Theme")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Themes")
            .sheet(isPresented: $showingCustomThemeBuilder) {
                CustomThemeBuilderView()
            }
        }
    }
}

struct CurrentThemePreview: View {
    let theme: AppTheme
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Current Theme")
                .font(.headline)
            
            HStack(spacing: 15) {
                ColorPreview(color: theme.primaryColor.color, label: "Primary")
                ColorPreview(color: theme.secondaryColor.color, label: "Secondary")
                ColorPreview(color: theme.accentColor.color, label: "Accent")
                ColorPreview(color: theme.backgroundColor.color, label: "Background")
            }
            
            Text(theme.name)
                .font(.title3)
                .fontWeight(.semibold)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}

struct ColorPreview: View {
    let color: Color
    let label: String
    
    var body: some View {
        VStack(spacing: 5) {
            Circle()
                .fill(color)
                .frame(width: 50, height: 50)
                .overlay(
                    Circle()
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
            
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

struct ThemeCard: View {
    let theme: AppTheme
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                HStack(spacing: 10) {
                    ColorPreview(color: theme.primaryColor.color, label: "")
                    ColorPreview(color: theme.accentColor.color, label: "")
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(theme.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(theme.isDarkMode ? "Dark Mode" : "Light Mode")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.blue)
                        .font(.title2)
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 3)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
            )
        }
        .padding(.horizontal)
    }
}

struct CustomThemeBuilderView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var themeManager: ThemeManager
    @State private var themeName = ""
    @State private var primaryColor = Color.blue
    @State private var secondaryColor = Color.gray
    @State private var accentColor = Color.orange
    @State private var backgroundColor = Color(.systemBackground)
    @State private var isDarkMode = false
    
    var body: some View {
        NavigationView {
            Form {
                Section("Theme Name") {
                    TextField("Enter theme name", text: $themeName)
                }
                
                Section("Colors") {
                    ColorPicker("Primary Color", selection: $primaryColor)
                    ColorPicker("Secondary Color", selection: $secondaryColor)
                    ColorPicker("Accent Color", selection: $accentColor)
                    ColorPicker("Background Color", selection: $backgroundColor)
                }
                
                Section("Appearance") {
                    Toggle("Dark Mode", isOn: $isDarkMode)
                }
                
                Section("Preview") {
                    ThemePreviewCard(
                        primary: primaryColor,
                        secondary: secondaryColor,
                        accent: accentColor,
                        background: backgroundColor
                    )
                }
            }
            .navigationTitle("Custom Theme")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveCustomTheme()
                    }
                    .disabled(themeName.isEmpty)
                }
            }
        }
    }
    
    private func saveCustomTheme() {
        let theme = AppTheme(
            id: UUID().uuidString,
            name: themeName,
            primaryColor: colorToThemeColor(primaryColor),
            secondaryColor: colorToThemeColor(secondaryColor),
            accentColor: colorToThemeColor(accentColor),
            backgroundColor: colorToThemeColor(backgroundColor),
            isDarkMode: isDarkMode
        )
        
        themeManager.availableThemes.append(theme)
        themeManager.applyTheme(theme)
        dismiss()
    }
    
    private func colorToThemeColor(_ color: Color) -> ThemeColor {
        // Convert SwiftUI Color to UIColor to extract RGB components
        let uiColor = UIColor(color)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        // Attempt to get RGB components, fallback to default if color space doesn't support RGB
        if uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return ThemeColor(
                red: Double(red),
                green: Double(green),
                blue: Double(blue),
                alpha: Double(alpha)
            )
        } else {
            // Fallback: convert to RGB color space and try again
            if let rgbColor = uiColor.cgColor.converted(to: CGColorSpaceCreateDeviceRGB(), intent: .defaultIntent, options: nil),
               let components = rgbColor.components, components.count >= 4 {
                return ThemeColor(
                    red: Double(components[0]),
                    green: Double(components[1]),
                    blue: Double(components[2]),
                    alpha: Double(components[3])
                )
            }
            // Ultimate fallback (should rarely happen)
            return ThemeColor(red: 0.0, green: 0.478, blue: 1.0, alpha: 1.0)
        }
    }
}

struct ThemePreviewCard: View {
    let primary: Color
    let secondary: Color
    let accent: Color
    let background: Color
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Circle()
                    .fill(primary)
                    .frame(width: 30, height: 30)
                Circle()
                    .fill(secondary)
                    .frame(width: 30, height: 30)
                Circle()
                    .fill(accent)
                    .frame(width: 30, height: 30)
            }
            
            Text("Preview")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(background)
        .cornerRadius(8)
    }
}

