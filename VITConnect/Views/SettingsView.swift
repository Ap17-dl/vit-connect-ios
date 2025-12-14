//
//  SettingsView.swift
//  VITConnect
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State private var notificationsEnabled = true
    @State private var autoSyncEnabled = true
    
    var body: some View {
        NavigationView {
            Form {
                Section("Appearance") {
                    NavigationLink(destination: ThemeView()) {
                        HStack {
                            Image(systemName: "paintbrush.fill")
                                .foregroundColor(.blue)
                            Text("Themes")
                        }
                    }
                }
                
                Section("Data & Sync") {
                    Toggle(isOn: $autoSyncEnabled) {
                        HStack {
                            Image(systemName: "arrow.clockwise")
                                .foregroundColor(.green)
                            Text("Auto Sync")
                        }
                    }
                    
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "arrow.down.circle.fill")
                                .foregroundColor(.blue)
                            Text("Sync Now")
                        }
                    }
                }
                
                Section("Notifications") {
                    Toggle(isOn: $notificationsEnabled) {
                        HStack {
                            Image(systemName: "bell.fill")
                                .foregroundColor(.orange)
                            Text("Enable Notifications")
                        }
                    }
                }
                
                Section("About") {
                    NavigationLink(destination: AboutView()) {
                        HStack {
                            Image(systemName: "info.circle.fill")
                                .foregroundColor(.blue)
                            Text("About")
                        }
                    }
                    
                    Link(destination: URL(string: "https://github.com/divyanshupatel17/vit-connect")!) {
                        HStack {
                            Image(systemName: "link")
                                .foregroundColor(.blue)
                            Text("GitHub Repository")
                        }
                    }
                    
                    Link(destination: URL(string: "https://vitverse.web.app")!) {
                        HStack {
                            Image(systemName: "globe")
                                .foregroundColor(.blue)
                            Text("Website")
                        }
                    }
                }
                
                Section("Support") {
                    Link(destination: URL(string: "https://github.com/divyanshupatel17/vit-connect/issues/new?labels=bug")!) {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.red)
                            Text("Report a Bug")
                        }
                    }
                    
                    Link(destination: URL(string: "https://github.com/divyanshupatel17/vit-connect/issues/new?labels=enhancement")!) {
                        HStack {
                            Image(systemName: "lightbulb.fill")
                                .foregroundColor(.yellow)
                            Text("Request a Feature")
                        }
                    }
                }
                
                Section("Legal") {
                    NavigationLink(destination: PrivacyPolicyView()) {
                        Text("Privacy Policy")
                    }
                    
                    NavigationLink(destination: TermsOfServiceView()) {
                        Text("Terms of Service")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image(systemName: "graduationcap.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                
                Text("VIT Connect")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Your Complete VTOP Companion & Campus Utility Hub")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Version 1.0.0")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text("Built with ❤️ for VIT Chennai students")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text("Not affiliated with VIT / VTOP")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()
                
                Text("Developed by Divyanshu Patel")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            Text("Privacy Policy content goes here...")
                .padding()
        }
        .navigationTitle("Privacy Policy")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TermsOfServiceView: View {
    var body: some View {
        ScrollView {
            Text("Terms of Service content goes here...")
                .padding()
        }
        .navigationTitle("Terms of Service")
        .navigationBarTitleDisplayMode(.inline)
    }
}

