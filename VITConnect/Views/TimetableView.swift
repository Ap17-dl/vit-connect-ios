//
//  TimetableView.swift
//  VITConnect
//

import SwiftUI

struct TimetableView: View {
    @State private var timetable: Timetable = sampleTimetable
    @State private var selectedDay = Calendar.current.component(.weekday, from: Date())
    
    let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Day Selector
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
                
                // Timetable Slots
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(filteredSlots()) { slot in
                            TimetableSlotCard(slot: slot)
                        }
                        
                        if filteredSlots().isEmpty {
                            VStack(spacing: 10) {
                                Image(systemName: "calendar.badge.plus")
                                    .font(.system(size: 50))
                                    .foregroundColor(.secondary)
                                Text("No classes scheduled")
                                    .foregroundColor(.secondary)
                            }
                            .padding(.top, 50)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Timetable")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
        }
    }
    
    private func filteredSlots() -> [TimetableSlot] {
        let dayName = days[selectedDay - 1]
        return timetable.weekSchedule.filter { $0.day == dayName }
            .sorted { slot1, slot2 in
                timeToMinutes(slot1.timeSlot) < timeToMinutes(slot2.timeSlot)
            }
    }
    
    private func timeToMinutes(_ timeSlot: String) -> Int {
        // Simple time parsing - assumes format like "09:00-10:00"
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

struct DayButton: View {
    let day: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(day)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(isSelected ? Color.blue : Color(.systemBackground))
                .cornerRadius(20)
        }
    }
}

struct TimetableSlotCard: View {
    let slot: TimetableSlot
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(slot.courseCode)
                        .font(.headline)
                    
                    Text(slot.courseName)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text(slot.timeSlot)
                    .font(.caption)
                    .fontWeight(.medium)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(slotTypeColor(slot.slotType).opacity(0.2))
                    .foregroundColor(slotTypeColor(slot.slotType))
                    .cornerRadius(8)
            }
            
            Divider()
            
            HStack {
                Label(slot.faculty, systemImage: "person.fill")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Label(slot.venue, systemImage: "mappin.circle.fill")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 3)
    }
    
    private func slotTypeColor(_ type: String) -> Color {
        switch type.lowercased() {
        case "lecture":
            return .blue
        case "lab":
            return .green
        case "tutorial":
            return .orange
        default:
            return .gray
        }
    }
}

let sampleTimetable = Timetable(
    weekSchedule: [
        TimetableSlot(id: "1", day: "Mon", timeSlot: "09:00-10:00", courseCode: "CSE1001", courseName: "Data Structures", faculty: "Dr. Smith", venue: "LT-101", slotType: "Lecture"),
        TimetableSlot(id: "2", day: "Mon", timeSlot: "10:00-11:00", courseCode: "CSE1002", courseName: "Algorithms", faculty: "Dr. Johnson", venue: "LT-102", slotType: "Lecture"),
        TimetableSlot(id: "3", day: "Mon", timeSlot: "14:00-16:00", courseCode: "CSE1001", courseName: "Data Structures Lab", faculty: "Dr. Smith", venue: "LAB-201", slotType: "Lab"),
        TimetableSlot(id: "4", day: "Tue", timeSlot: "09:00-10:00", courseCode: "MAT1001", courseName: "Linear Algebra", faculty: "Dr. Williams", venue: "LT-103", slotType: "Lecture"),
        TimetableSlot(id: "5", day: "Wed", timeSlot: "11:00-12:00", courseCode: "CSE1002", courseName: "Algorithms", faculty: "Dr. Johnson", venue: "LT-102", slotType: "Tutorial")
    ],
    currentWeek: 5
)

