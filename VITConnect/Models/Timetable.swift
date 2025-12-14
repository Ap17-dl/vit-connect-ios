//
//  Timetable.swift
//  VITConnect
//

import Foundation

struct TimetableSlot: Codable, Identifiable {
    let id: String
    let day: String
    let timeSlot: String
    let courseCode: String
    let courseName: String
    let faculty: String
    let venue: String
    let slotType: String // Lecture, Lab, Tutorial
}

struct Timetable: Codable {
    let weekSchedule: [TimetableSlot]
    let currentWeek: Int
}

