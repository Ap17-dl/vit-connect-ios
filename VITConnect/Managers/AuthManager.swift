//
//  AuthManager.swift
//  VITConnect
//

import Foundation
import SwiftUI

class AuthManager: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    
    init() {
        // Check if user is already logged in
        checkAuthentication()
    }
    
    func checkAuthentication() {
        // Check UserDefaults for saved session
        if let userData = UserDefaults.standard.data(forKey: "currentUser"),
           let user = try? JSONDecoder().decode(User.self, from: userData) {
            self.currentUser = user
            self.isAuthenticated = true
        }
    }
    
    func login(regNo: String, password: String) async throws {
        // TODO: Implement actual VTOP login API call
        // For now, simulate login
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second delay
        
        // Mock user data
        let user = User(
            id: UUID().uuidString,
            name: "Student Name",
            regNo: regNo,
            email: "\(regNo)@vitstudent.ac.in",
            branch: "Computer Science",
            year: 3,
            profileImageURL: nil
        )
        
        // Save user data
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: "currentUser")
        }
        
        await MainActor.run {
            self.currentUser = user
            self.isAuthenticated = true
        }
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: "currentUser")
        currentUser = nil
        isAuthenticated = false
    }
}

