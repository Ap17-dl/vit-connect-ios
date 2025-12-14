//
//  User.swift
//  VITConnect
//

import Foundation

struct User: Codable, Identifiable {
    let id: String
    var name: String
    var regNo: String
    var email: String
    var branch: String
    var year: Int
    var profileImageURL: String?
}

