//
//  ProfileView.swift
//  VITConnect
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authManager: AuthManager
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Profile Header
                    ProfileHeader(user: authManager.currentUser)
                    
                    // Quick Actions
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Quick Actions")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        QuickActionRow(icon: "person.fill", title: "Edit Profile", color: .blue) {}
                        QuickActionRow(icon: "bell.fill", title: "Notifications", color: .orange) {}
                        QuickActionRow(icon: "lock.fill", title: "Privacy & Security", color: .green) {}
                    }
                    
                    // Account Info
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Account Information")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        if let user = authManager.currentUser {
                            InfoRow(label: "Registration Number", value: user.regNo)
                            InfoRow(label: "Email", value: user.email)
                            InfoRow(label: "Branch", value: user.branch)
                            InfoRow(label: "Year", value: "\(user.year)")
                        }
                    }
                    
                    // Logout Button
                    Button(action: {
                        authManager.logout()
                    }) {
                        Text("Logout")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                }
                .padding(.vertical)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}

struct ProfileHeader: View {
    let user: User?
    
    var body: some View {
        VStack(spacing: 15) {
            if let user = user {
                // Profile Image
                ZStack {
                    Circle()
                        .fill(Color.blue.opacity(0.2))
                        .frame(width: 100, height: 100)
                    
                    if let imageURL = user.profileImageURL, let url = URL(string: imageURL) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Image(systemName: "person.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.blue)
                        }
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                    } else {
                        Image(systemName: "person.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.blue)
                    }
                }
                
                VStack(spacing: 5) {
                    Text(user.name)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text(user.regNo)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}

struct QuickActionRow: View {
    let icon: String
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                    .frame(width: 30)
                
                Text(title)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 3)
        }
        .padding(.horizontal)
    }
}

struct InfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text(value)
                .fontWeight(.medium)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 3)
        .padding(.horizontal)
    }
}

