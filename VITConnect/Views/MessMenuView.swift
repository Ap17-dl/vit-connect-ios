//
//  MessMenuView.swift
//  VITConnect
//

import SwiftUI

struct MessMenuView: View {
    @State private var selectedDate = Date()
    @State private var messMenu: MessMenu = sampleMessMenu
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Date Picker
                    DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(radius: 3)
                    
                    // Menu Sections
                    MenuSection(title: "Breakfast", icon: "sunrise.fill", items: messMenu.breakfast, color: .orange)
                    MenuSection(title: "Lunch", icon: "sun.max.fill", items: messMenu.lunch, color: .yellow)
                    MenuSection(title: "Snacks", icon: "cup.and.saucer.fill", items: messMenu.snacks, color: .brown)
                    MenuSection(title: "Dinner", icon: "moon.fill", items: messMenu.dinner, color: .blue)
                }
                .padding()
            }
            .navigationTitle("Mess Menu")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
        }
    }
}

struct MenuSection: View {
    let title: String
    let icon: String
    let items: [String]
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.title2)
                
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
            }
            
            if items.isEmpty {
                Text("No items available")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.leading, 35)
            } else {
                ForEach(items, id: \.self) { item in
                    HStack {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 6))
                            .foregroundColor(color)
                        
                        Text(item)
                            .font(.subheadline)
                    }
                    .padding(.leading, 35)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 3)
    }
}

let sampleMessMenu = MessMenu(
    date: Date(),
    breakfast: ["Idli", "Sambar", "Coconut Chutney", "Coffee", "Tea"],
    lunch: ["Rice", "Dal", "Vegetable Curry", "Roti", "Salad", "Curd"],
    snacks: ["Samosa", "Tea", "Biscuits"],
    dinner: ["Rice", "Dal", "Paneer Curry", "Roti", "Salad", "Dessert"]
)

