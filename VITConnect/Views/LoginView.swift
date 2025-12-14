//
//  LoginView.swift
//  VITConnect
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var regNo = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var errorMessage = ""
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()
                
                // App Logo/Title
                VStack(spacing: 10) {
                    Image(systemName: "graduationcap.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.white)
                    
                    Text("VIT Connect")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Your Complete VTOP Companion")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                }
                
                Spacer()
                
                // Login Form
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Registration Number")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.9))
                        
                        TextField("Enter Reg No", text: $regNo)
                            .textFieldStyle(CustomTextFieldStyle())
                            .autocapitalization(.none)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.9))
                        
                        SecureField("Enter Password", text: $password)
                            .textFieldStyle(CustomTextFieldStyle())
                    }
                    
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(.horizontal)
                    }
                    
                    Button(action: handleLogin) {
                        HStack {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            } else {
                                Text("Login")
                                    .fontWeight(.semibold)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.blue)
                        .cornerRadius(12)
                    }
                    .disabled(isLoading || regNo.isEmpty || password.isEmpty)
                }
                .padding(.horizontal, 30)
                
                Spacer()
                
                // Footer
                Text("Not affiliated with VIT / VTOP")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.bottom, 20)
            }
        }
    }
    
    private func handleLogin() {
        isLoading = true
        errorMessage = ""
        
        Task {
            do {
                try await authManager.login(regNo: regNo, password: password)
                await MainActor.run {
                    isLoading = false
                }
            } catch {
                await MainActor.run {
                    errorMessage = "Login failed. Please check your credentials."
                    isLoading = false
                }
            }
        }
    }
}

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(Color.white.opacity(0.9))
            .cornerRadius(10)
            .shadow(radius: 2)
    }
}

// MARK: - Preview
#Preview {
    LoginView()
        .environmentObject(AuthManager())
        .environmentObject(ThemeManager())
}

