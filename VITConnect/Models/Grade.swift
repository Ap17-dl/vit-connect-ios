//
//  Grade.swift
//  VITConnect
//

import Foundation

struct Grade: Codable, Identifiable {
    let id: String
    let courseCode: String
    let courseName: String
    let credits: Double
    let grade: String
    let gradePoints: Double
    let semester: String
}

struct AcademicDashboard: Codable {
    let cgpa: Double
    let sgpa: Double
    let totalCredits: Double
    let completedCredits: Double
    let grades: [Grade]
}

