//
//  MessMenu.swift
//  VITConnect
//

import Foundation

struct MessMenu: Codable {
    let date: Date
    let breakfast: [String]
    let lunch: [String]
    let snacks: [String]
    let dinner: [String]
}

struct LaundryStatus: Codable, Identifiable {
    let id: String
    let studentName: String
    let regNo: String
    let items: [LaundryItem]
    let status: LaundryStatusType
    let submittedDate: Date
    let expectedDate: Date?
}

struct LaundryItem: Codable {
    let type: String
    let count: Int
}

enum LaundryStatusType: String, Codable {
    case submitted = "Submitted"
    case inProgress = "In Progress"
    case ready = "Ready"
    case collected = "Collected"
}

