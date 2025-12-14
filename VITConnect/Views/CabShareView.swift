//
//  CabShareView.swift
//  VITConnect
//

import SwiftUI

struct CabShareView: View {
    @State private var cabShares: [CabShare] = sampleCabShares
    @State private var showingAddForm = false
    @State private var filterType: FilterType = .all
    
    enum FilterType: String, CaseIterable {
        case all = "All"
        case available = "Available"
        case myRides = "My Rides"
    }
    
    var filteredCabShares: [CabShare] {
        switch filterType {
        case .all:
            return cabShares
        case .available:
            return cabShares.filter { $0.availableSeats > 0 }
        case .myRides:
            // TODO: Filter by current user
            return cabShares
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Filter Picker
                Picker("Filter", selection: $filterType) {
                    ForEach(FilterType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // Cab Shares List
                if filteredCabShares.isEmpty {
                    EmptyStateView(
                        icon: "car.fill",
                        message: "No cab shares available",
                        actionTitle: "Create Cab Share",
                        action: { showingAddForm = true }
                    )
                } else {
                    List(filteredCabShares) { cabShare in
                        CabShareCard(cabShare: cabShare)
                    }
                }
            }
            .navigationTitle("Cab Share")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddForm = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddForm) {
                AddCabShareView()
            }
        }
    }
}

struct CabShareCard: View {
    let cabShare: CabShare
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(cabShare.driverName)
                        .font(.headline)
                    
                    Text(cabShare.driverPhone)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                if cabShare.availableSeats > 0 {
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("\(cabShare.availableSeats) seats")
                            .font(.headline)
                            .foregroundColor(.green)
                        
                        Text("₹\(Int(cabShare.pricePerSeat))")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                } else {
                    Text("Full")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.gray.opacity(0.2))
                        .foregroundColor(.gray)
                        .cornerRadius(12)
                }
            }
            
            Divider()
            
            // Route
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.green)
                        Text(cabShare.source)
                            .font(.subheadline)
                    }
                    
                    HStack {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                        Text(cabShare.destination)
                            .font(.subheadline)
                    }
                }
                
                Spacer()
            }
            
            Divider()
            
            // Date and Time
            HStack {
                Label(cabShare.date, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Label(cabShare.time, systemImage: "clock")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            // Join Button
            if cabShare.availableSeats > 0 {
                Button(action: {}) {
                    Text("Join Ride")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
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

struct AddCabShareView: View {
    @Environment(\.dismiss) var dismiss
    @State private var source = ""
    @State private var destination = ""
    @State private var date = Date()
    @State private var time = ""
    @State private var totalSeats = "4"
    @State private var pricePerSeat = ""
    @State private var driverName = ""
    @State private var driverPhone = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("Driver Details") {
                    TextField("Driver Name", text: $driverName)
                    TextField("Phone Number", text: $driverPhone)
                        .keyboardType(.phonePad)
                }
                
                Section("Route") {
                    TextField("Source", text: $source)
                    TextField("Destination", text: $destination)
                }
                
                Section("Schedule") {
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    TextField("Time (e.g., 10:00 AM)", text: $time)
                }
                
                Section("Ride Details") {
                    TextField("Total Seats", text: $totalSeats)
                        .keyboardType(.numberPad)
                    TextField("Price per Seat (₹)", text: $pricePerSeat)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Create Cab Share")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Create") {
                        // TODO: Create cab share
                        dismiss()
                    }
                    .disabled(source.isEmpty || destination.isEmpty || time.isEmpty)
                }
            }
        }
    }
}

let sampleCabShares: [CabShare] = [
    CabShare(
        id: "1",
        driverName: "John Doe",
        driverPhone: "+91 9876543210",
        source: "VIT Chennai",
        destination: "Airport",
        date: Date().addingTimeInterval(24*3600),
        time: "10:00 AM",
        availableSeats: 2,
        totalSeats: 4,
        pricePerSeat: 200.0,
        passengers: ["21BCE1234", "21BCE5678"]
    ),
    CabShare(
        id: "2",
        driverName: "Jane Smith",
        driverPhone: "+91 9876543211",
        source: "VIT Chennai",
        destination: "Central Station",
        date: Date().addingTimeInterval(2*24*3600),
        time: "2:00 PM",
        availableSeats: 0,
        totalSeats: 4,
        pricePerSeat: 150.0,
        passengers: ["21BCE1111", "21BCE2222", "21BCE3333", "21BCE4444"]
    )
]

