//
//  LaundryView.swift
//  VITConnect
//

import SwiftUI

struct LaundryView: View {
    @State private var laundryStatuses: [LaundryStatus] = sampleLaundryStatuses
    @State private var showingAddForm = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 15) {
                    if laundryStatuses.isEmpty {
                        EmptyStateView(
                            icon: "tshirt.fill",
                            message: "No laundry submissions",
                            actionTitle: "Add Laundry",
                            action: { showingAddForm = true }
                        )
                    } else {
                        ForEach(laundryStatuses) { status in
                            LaundryStatusCard(status: status)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Laundry Status")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddForm = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddForm) {
                AddLaundryView()
            }
        }
    }
}

struct LaundryStatusCard: View {
    let status: LaundryStatus
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(status.studentName)
                        .font(.headline)
                    
                    Text(status.regNo)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                StatusBadge(status: status.status)
            }
            
            Divider()
            
            // Items List
            VStack(alignment: .leading, spacing: 8) {
                Text("Items:")
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                ForEach(status.items, id: \.type) { item in
                    HStack {
                        Text("• \(item.type)")
                            .font(.caption)
                        Spacer()
                        Text("\(item.count)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            Divider()
            
            // Dates
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Submitted")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(status.submittedDate, style: .date)
                        .font(.caption)
                        .fontWeight(.medium)
                }
                
                Spacer()
                
                if let expectedDate = status.expectedDate {
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("Expected")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(expectedDate, style: .date)
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 3)
    }
}

struct StatusBadge: View {
    let status: LaundryStatusType
    
    var body: some View {
        Text(status.rawValue)
            .font(.caption)
            .fontWeight(.semibold)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(statusColor(status).opacity(0.2))
            .foregroundColor(statusColor(status))
            .cornerRadius(12)
    }
    
    private func statusColor(_ status: LaundryStatusType) -> Color {
        switch status {
        case .submitted:
            return .blue
        case .inProgress:
            return .orange
        case .ready:
            return .green
        case .collected:
            return .gray
        }
    }
}

struct AddLaundryView: View {
    @Environment(\.dismiss) var dismiss
    @State private var itemType = ""
    @State private var itemCount = ""
    @State private var items: [LaundryItem] = []
    
    var body: some View {
        NavigationView {
            Form {
                Section("Add Items") {
                    HStack {
                        TextField("Item Type", text: $itemType)
                        TextField("Count", text: $itemCount)
                            .keyboardType(.numberPad)
                            .frame(width: 80)
                        
                        Button("Add") {
                            if let count = Int(itemCount), !itemType.isEmpty {
                                items.append(LaundryItem(type: itemType, count: count))
                                itemType = ""
                                itemCount = ""
                            }
                        }
                    }
                    
                    ForEach(items.indices, id: \.self) { index in
                        HStack {
                            Text(items[index].type)
                            Spacer()
                            Text("\(items[index].count)")
                        }
                    }
                    .onDelete { indices in
                        items.remove(atOffsets: indices)
                    }
                }
            }
            .navigationTitle("Add Laundry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Submit") {
                        // TODO: Submit laundry
                        dismiss()
                    }
                    .disabled(items.isEmpty)
                }
            }
        }
    }
}

struct EmptyStateView: View {
    let icon: String
    let message: String
    let actionTitle: String
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: icon)
                .font(.system(size: 60))
                .foregroundColor(.secondary)
            
            Text(message)
                .font(.headline)
                .foregroundColor(.secondary)
            
            Button(action: action) {
                Text(actionTitle)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 12)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding(.top, 100)
    }
}

let sampleLaundryStatuses: [LaundryStatus] = [
    LaundryStatus(
        id: "1",
        studentName: "Student Name",
        regNo: "21BCE1234",
        items: [
            LaundryItem(type: "Shirts", count: 5),
            LaundryItem(type: "Pants", count: 3),
            LaundryItem(type: "T-Shirts", count: 4)
        ],
        status: .inProgress,
        submittedDate: Date().addingTimeInterval(-2*24*3600),
        expectedDate: Date().addingTimeInterval(2*24*3600)
    )
]

