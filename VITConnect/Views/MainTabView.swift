//
//  MainTabView.swift
//  VITConnect
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            
            AttendanceView()
                .tabItem {
                    Label("Attendance", systemImage: "chart.bar.fill")
                }
                .tag(1)
            
            AcademicView()
                .tabItem {
                    Label("Academics", systemImage: "book.fill")
                }
                .tag(2)
            
            TimetableView()
                .tabItem {
                    Label("Timetable", systemImage: "calendar")
                }
                .tag(3)
            
            MoreView()
                .tabItem {
                    Label("More", systemImage: "ellipsis.circle.fill")
                }
                .tag(4)
        }
    }
}

