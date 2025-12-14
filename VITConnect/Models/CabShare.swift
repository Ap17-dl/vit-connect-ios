//
//  CabShare.swift
//  VITConnect
//

import Foundation

struct CabShare: Codable, Identifiable {
    let id: String
    let driverName: String
    let driverPhone: String
    let source: String
    let destination: String
    let date: Date
    let time: String
    let availableSeats: Int
    let totalSeats: Int
    let pricePerSeat: Double
    let passengers: [String]
}

struct LostFound: Codable, Identifiable {
    let id: String
    let itemName: String
    let description: String
    let location: String
    let date: Date
    let type: LostFoundType
    let contactName: String
    let contactPhone: String
    let status: LostFoundStatus
    let imageURL: String?
}

enum LostFoundType: String, Codable {
    case lost = "Lost"
    case found = "Found"
}

enum LostFoundStatus: String, Codable {
    case active = "Active"
    case resolved = "Resolved"
    case closed = "Closed"
}

