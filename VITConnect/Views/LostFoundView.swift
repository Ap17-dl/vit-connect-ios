//
//  LostFoundView.swift
//  VITConnect
//

import SwiftUI

struct LostFoundView: View {
    @State private var items: [LostFound] = sampleLostFoundItems
    @State private var showingAddForm = false
    @State private var filterType: LostFoundType?
    
    var filteredItems: [LostFound] {
        if let filterType = filterType {
            return items.filter { $0.type == filterType && $0.status == .active }
        }
        return items.filter { $0.status == .active }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Filter Buttons
                HStack(spacing: 10) {
                    FilterButton(title: "All", isSelected: filterType == nil) {
                        filterType = nil
                    }
                    
                    FilterButton(title: "Lost", isSelected: filterType == .lost) {
                        filterType = .lost
                    }
                    
                    FilterButton(title: "Found", isSelected: filterType == .found) {
                        filterType = .found
                    }
                }
                .padding()
                
                // Items List
                if filteredItems.isEmpty {
                    EmptyStateView(
                        icon: "magnifyingglass",
                        message: "No items found",
                        actionTitle: "Report Item",
                        action: { showingAddForm = true }
                    )
                } else {
                    List(filteredItems) { item in
                        LostFoundCard(item: item)
                    }
                }
            }
            .navigationTitle("Lost & Found")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddForm = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddForm) {
                AddLostFoundView()
            }
        }
    }
}

struct FilterButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color(.systemGray6))
                .cornerRadius(20)
        }
    }
}

struct LostFoundCard: View {
    let item: LostFound
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(item.itemName)
                            .font(.headline)
                        
                        TypeBadge(type: item.type)
                    }
                    
                    Text(item.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                
                Spacer()
            }
            
            if let imageURL = item.imageURL {
                AsyncImage(url: URL(string: imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                }
                .frame(height: 150)
                .cornerRadius(8)
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.blue)
                    Text(item.location)
                        .font(.subheadline)
                }
                
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.secondary)
                    Text(item.date, style: .date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Divider()
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Contact")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(item.contactName)
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    Text(item.contactPhone)
                        .font(.caption)
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                Button(action: {}) {
                    Text("Contact")
                        .fontWeight(.semibold)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 3)
    }
}

struct TypeBadge: View {
    let type: LostFoundType
    
    var body: some View {
        Text(type.rawValue)
            .font(.caption)
            .fontWeight(.semibold)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(type == .lost ? Color.red.opacity(0.2) : Color.green.opacity(0.2))
            .foregroundColor(type == .lost ? .red : .green)
            .cornerRadius(8)
    }
}

struct AddLostFoundView: View {
    @Environment(\.dismiss) var dismiss
    @State private var itemName = ""
    @State private var description = ""
    @State private var location = ""
    @State private var type: LostFoundType = .lost
    @State private var contactName = ""
    @State private var contactPhone = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("Item Details") {
                    Picker("Type", selection: $type) {
                        Text("Lost").tag(LostFoundType.lost)
                        Text("Found").tag(LostFoundType.found)
                    }
                    
                    TextField("Item Name", text: $itemName)
                    
                    TextEditor(text: $description)
                        .frame(height: 100)
                        .overlay(
                            Group {
                                if description.isEmpty {
                                    Text("Description")
                                        .foregroundColor(.secondary)
                                        .padding(.leading, 4)
                                        .padding(.top, 8)
                                        .allowsHitTesting(false)
                                }
                            },
                            alignment: .topLeading
                        )
                    
                    TextField("Location", text: $location)
                }
                
                Section("Contact Information") {
                    TextField("Your Name", text: $contactName)
                    TextField("Phone Number", text: $contactPhone)
                        .keyboardType(.phonePad)
                }
            }
            .navigationTitle("Report Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Submit") {
                        // TODO: Submit item
                        dismiss()
                    }
                    .disabled(itemName.isEmpty || description.isEmpty || location.isEmpty || contactName.isEmpty || contactPhone.isEmpty)
                }
            }
        }
    }
}

let sampleLostFoundItems: [LostFound] = [
    LostFound(
        id: "1",
        itemName: "iPhone 13",
        description: "Black iPhone 13 with a blue case. Lost near library.",
        location: "Library - 2nd Floor",
        date: Date().addingTimeInterval(-2*24*3600),
        type: .lost,
        contactName: "John Doe",
        contactPhone: "+91 9876543210",
        status: .active,
        imageURL: nil
    ),
    LostFound(
        id: "2",
        itemName: "Student ID Card",
        description: "Found a student ID card in the cafeteria.",
        location: "Cafeteria",
        date: Date().addingTimeInterval(-1*24*3600),
        type: .found,
        contactName: "Jane Smith",
        contactPhone: "+91 9876543211",
        status: .active,
        imageURL: nil
    )
]

