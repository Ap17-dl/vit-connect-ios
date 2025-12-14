//
//  Attendance.swift
//  VITConnect
//

import Foundation

struct Attendance: Codable, Identifiable {
    let id: String
    let courseCode: String
    let courseName: String
    let totalClasses: Int
    let attendedClasses: Int
    let percentage: Double
    let lastUpdated: Date
}

struct AttendanceAnalytics: Codable {
    let overallPercentage: Double
    let totalCourses: Int
    let courses: [Attendance]
    let attendanceTrend: [AttendanceDataPoint]
}

struct AttendanceDataPoint: Codable {
    let date: Date
    let percentage: Double
}

