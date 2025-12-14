//
//  HomeView.swift
//  VITConnect
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Welcome Section
                    WelcomeCard()
                    
                    // Quick Stats
                    QuickStatsView()
                    
                    // Feature Grid
                    FeatureGridView()
                    
                    // Recent Activity
                    RecentActivityView()
                }
                .padding()
            }
            .navigationTitle("VIT Connect")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProfileView()) {
                        Image(systemName: "person.circle.fill")
                            .font(.title2)
                    }
                }
            }
        }
    }
}

struct WelcomeCard: View {
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Welcome back!")
                .font(.title2)
                .fontWeight(.bold)
            
            if let user = authManager.currentUser {
                Text(user.name)
                    .font(.title3)
                    .foregroundColor(.secondary)
            }
            
            Text("Your complete VTOP companion")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(15)
    }
}

struct QuickStatsView: View {
    var body: some View {
        HStack(spacing: 15) {
            StatCard(title: "Attendance", value: "85%", icon: "chart.bar.fill", color: .green)
            StatCard(title: "CGPA", value: "8.5", icon: "star.fill", color: .orange)
            StatCard(title: "Classes Today", value: "4", icon: "calendar", color: .blue)
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct FeatureGridView: View {
    let features = [
        FeatureItem(title: "Friends Schedule", icon: "person.2.fill", color: .blue, destination: AnyView(FriendsScheduleView())),
        FeatureItem(title: "Mess Menu", icon: "fork.knife", color: .orange, destination: AnyView(MessMenuView())),
        FeatureItem(title: "Laundry", icon: "tshirt.fill", color: .purple, destination: AnyView(LaundryView())),
        FeatureItem(title: "Faculty Rating", icon: "star.fill", color: .yellow, destination: AnyView(FacultyRatingView())),
        FeatureItem(title: "Cab Share", icon: "car.fill", color: .green, destination: AnyView(CabShareView())),
        FeatureItem(title: "Lost & Found", icon: "magnifyingglass", color: .red, destination: AnyView(LostFoundView())),
        FeatureItem(title: "Themes", icon: "paintbrush.fill", color: .pink, destination: AnyView(ThemeView())),
        FeatureItem(title: "Settings", icon: "gearshape.fill", color: .gray, destination: AnyView(SettingsView()))
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 15) {
            ForEach(features.indices, id: \.self) { index in
                NavigationLink(destination: features[index].destination) {
                    VStack(spacing: 8) {
                        Image(systemName: features[index].icon)
                            .font(.title2)
                            .foregroundColor(features[index].color)
                        
                        Text(features[index].title)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.primary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
                }
            }
        }
    }
}

struct FeatureItem {
    let title: String
    let icon: String
    let color: Color
    let destination: AnyView
}

struct RecentActivityView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Recent Activity")
                .font(.headline)
                .padding(.horizontal)
            
            VStack(spacing: 10) {
                ActivityRow(icon: "checkmark.circle.fill", title: "Attendance Updated", time: "2 hours ago", color: .green)
                ActivityRow(icon: "calendar", title: "New Timetable Available", time: "1 day ago", color: .blue)
                ActivityRow(icon: "star.fill", title: "Grade Posted", time: "3 days ago", color: .orange)
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
    }
}

struct ActivityRow: View {
    let icon: String
    let title: String
    let time: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Text(time)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
    }
}

// MARK: - Preview
#Preview {
    HomeView()
        .environmentObject(AuthManager())
        .environmentObject(ThemeManager())
}

