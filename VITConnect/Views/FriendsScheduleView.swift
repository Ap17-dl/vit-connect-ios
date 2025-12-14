//
//  FriendsScheduleView.swift
//  VITConnect
//

import SwiftUI

struct FriendsScheduleView: View {
    @State private var friends: [Friend] = sampleFriends
    @State private var selectedFriend: Friend?
    @State private var showingAddFriend = false
    
    var body: some View {
        NavigationView {
            VStack {
                if friends.isEmpty {
                    EmptyStateView(
                        icon: "person.2.fill",
                        message: "No friends added",
                        actionTitle: "Add Friend",
                        action: { showingAddFriend = true }
                    )
                } else {
                    List {
                        ForEach(friends) { friend in
                            FriendRow(friend: friend) {
                                selectedFriend = friend
                            }
                        }
                        .onDelete { indices in
                            friends.remove(atOffsets: indices)
                        }
                    }
                }
            }
            .navigationTitle("Friends Schedule")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddFriend = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddFriend) {
                AddFriendView()
            }
            .sheet(item: $selectedFriend) { friend in
                FriendTimetableView(friend: friend)
            }
        }
    }
}

struct Friend: Identifiable, Codable {
    let id: String
    let name: String
    let regNo: String
    let branch: String
    let timetable: Timetable
}

struct FriendRow: View {
    let friend: Friend
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(friend.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(friend.regNo)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text(friend.branch)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 4)
        }
    }
}

struct FriendTimetableView: View {
    @Environment(\.dismiss) var dismiss
    let friend: Friend
    @State private var selectedDay = Calendar.current.component(.weekday, from: Date())
    
    let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(1..<8) { dayIndex in
                            DayButton(
                                day: days[dayIndex - 1],
                                isSelected: selectedDay == dayIndex,
                                action: { selectedDay = dayIndex }
                            )
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 10)
                .background(Color(.systemGroupedBackground))
                
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(filteredSlots()) { slot in
                            TimetableSlotCard(slot: slot)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle(friend.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
    
    private func filteredSlots() -> [TimetableSlot] {
        let dayName = days[selectedDay - 1]
        return friend.timetable.weekSchedule.filter { $0.day == dayName }
            .sorted { slot1, slot2 in
                timeToMinutes(slot1.timeSlot) < timeToMinutes(slot2.timeSlot)
            }
    }
    
    private func timeToMinutes(_ timeSlot: String) -> Int {
        let components = timeSlot.split(separator: "-")
        if let start = components.first {
            let parts = start.split(separator: ":")
            if parts.count == 2,
               let hour = Int(parts[0]),
               let minute = Int(parts[1]) {
                return hour * 60 + minute
            }
        }
        return 0
    }
}

struct AddFriendView: View {
    @Environment(\.dismiss) var dismiss
    @State private var regNo = ""
    @State private var name = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("Friend Details") {
                    TextField("Registration Number", text: $regNo)
                        .autocapitalization(.none)
                    TextField("Name (Optional)", text: $name)
                }
            }
            .navigationTitle("Add Friend")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        // TODO: Add friend
                        dismiss()
                    }
                    .disabled(regNo.isEmpty)
                }
            }
        }
    }
}

let sampleFriends: [Friend] = [
    Friend(
        id: "1",
        name: "John Doe",
        regNo: "21BCE1234",
        branch: "CSE",
        timetable: sampleTimetable
    ),
    Friend(
        id: "2",
        name: "Jane Smith",
        regNo: "21BCE5678",
        branch: "ECE",
        timetable: sampleTimetable
    )
]

