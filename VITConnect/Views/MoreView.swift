//
//  MoreView.swift
//  VITConnect
//

import SwiftUI

struct MoreView: View {
    var body: some View {
        NavigationView {
            List {
                Section("Utilities") {
                    NavigationLink(destination: MessMenuView()) {
                        Label("Mess Menu", systemImage: "fork.knife")
                    }
                    
                    NavigationLink(destination: LaundryView()) {
                        Label("Laundry Status", systemImage: "tshirt.fill")
                    }
                    
                    NavigationLink(destination: FacultyRatingView()) {
                        Label("Faculty Rating", systemImage: "star.fill")
                    }
                    
                    NavigationLink(destination: CabShareView()) {
                        Label("Cab Share", systemImage: "car.fill")
                    }
                    
                    NavigationLink(destination: LostFoundView()) {
                        Label("Lost & Found", systemImage: "magnifyingglass")
                    }
                }
                
                Section("Social") {
                    NavigationLink(destination: FriendsScheduleView()) {
                        Label("Friends Schedule", systemImage: "person.2.fill")
                    }
                }
                
                Section("Customization") {
                    NavigationLink(destination: ThemeView()) {
                        Label("Themes", systemImage: "paintbrush.fill")
                    }
                }
                
                Section("Account") {
                    NavigationLink(destination: ProfileView()) {
                        Label("Profile", systemImage: "person.circle.fill")
                    }
                    
                    NavigationLink(destination: SettingsView()) {
                        Label("Settings", systemImage: "gearshape.fill")
                    }
                }
                
                Section("Links") {
                    Link(destination: URL(string: "https://chennai.vit.ac.in/")!) {
                        Label("VIT Chennai", systemImage: "globe")
                    }
                    
                    Link(destination: URL(string: "https://vtopcc.vit.ac.in/vtop/open/page")!) {
                        Label("VTOP Login", systemImage: "link")
                    }
                    
                    Link(destination: URL(string: "https://lms.vit.ac.in/login/index.php")!) {
                        Label("LMS", systemImage: "book.fill")
                    }
                }
            }
            .navigationTitle("More")
        }
    }
}

