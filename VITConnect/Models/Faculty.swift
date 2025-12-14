//
//  Faculty.swift
//  VITConnect
//

import Foundation

struct Faculty: Codable, Identifiable {
    let id: String
    let name: String
    let department: String
    let designation: String
    let email: String?
    let averageRating: Double
    let totalRatings: Int
    let reviews: [FacultyReview]
}

struct FacultyReview: Codable, Identifiable {
    let id: String
    let studentName: String
    let rating: Int
    let comment: String
    let date: Date
}

