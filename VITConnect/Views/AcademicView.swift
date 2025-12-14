//
//  AcademicView.swift
//  VITConnect
//

import SwiftUI

struct AcademicView: View {
    @State private var dashboard: AcademicDashboard = sampleDashboard
    @State private var selectedSemester = "All"
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // CGPA/SGPA Cards
                    HStack(spacing: 15) {
                        GPACard(title: "CGPA", value: dashboard.cgpa, color: .blue)
                        GPACard(title: "SGPA", value: dashboard.sgpa, color: .green)
                    }
                    
                    // Credits Info
                    CreditsCard(dashboard: dashboard)
                    
                    // Semester Filter
                    Picker("Semester", selection: $selectedSemester) {
                        Text("All").tag("All")
                        ForEach(uniqueSemesters(), id: \.self) { semester in
                            Text(semester).tag(semester)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    // Grades List
                    VStack(spacing: 12) {
                        ForEach(filteredGrades()) { grade in
                            GradeCard(grade: grade)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Academics")
        }
    }
    
    private func uniqueSemesters() -> [String] {
        Array(Set(dashboard.grades.map { $0.semester })).sorted()
    }
    
    private func filteredGrades() -> [Grade] {
        if selectedSemester == "All" {
            return dashboard.grades
        }
        return dashboard.grades.filter { $0.semester == selectedSemester }
    }
}

struct GPACard: View {
    let title: String
    let value: Double
    let color: Color
    
    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text(String(format: "%.2f", value))
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(color)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

struct CreditsCard: View {
    let dashboard: AcademicDashboard
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Credits")
                        .font(.headline)
                    
                    Text("\(Int(dashboard.completedCredits))/\(Int(dashboard.totalCredits))")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                CircularProgressView(
                    progress: dashboard.totalCredits > 0 ? dashboard.completedCredits / dashboard.totalCredits : 0
                )
                .frame(width: 60, height: 60)
            }
            
            ProgressView(value: dashboard.completedCredits, total: dashboard.totalCredits)
                .tint(.blue)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

struct CircularProgressView: View {
    let progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 8)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.blue, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .rotationEffect(.degrees(-90))
            
            Text("\(Int(progress * 100))%")
                .font(.caption)
                .fontWeight(.bold)
        }
    }
}

struct GradeCard: View {
    let grade: Grade
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(grade.courseCode)
                    .font(.headline)
                
                Text(grade.courseName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(grade.semester)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 5) {
                Text(grade.grade)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(gradeColor(grade.grade))
                
                Text("\(String(format: "%.1f", grade.gradePoints))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("\(String(format: "%.1f", grade.credits)) Cr")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 3)
    }
    
    private func gradeColor(_ grade: String) -> Color {
        switch grade.uppercased() {
        case "S", "A+", "A":
            return .green
        case "B+", "B":
            return .blue
        case "C+", "C":
            return .orange
        default:
            return .red
        }
    }
}

let sampleDashboard = AcademicDashboard(
    cgpa: 8.52,
    sgpa: 8.75,
    totalCredits: 180.0,
    completedCredits: 120.0,
    grades: [
        Grade(id: "1", courseCode: "CSE1001", courseName: "Data Structures", credits: 4.0, grade: "A", gradePoints: 9.0, semester: "Fall 2023"),
        Grade(id: "2", courseCode: "CSE1002", courseName: "Algorithms", credits: 4.0, grade: "A+", gradePoints: 10.0, semester: "Fall 2023"),
        Grade(id: "3", courseCode: "MAT1001", courseName: "Linear Algebra", credits: 3.0, grade: "B+", gradePoints: 8.0, semester: "Fall 2023"),
        Grade(id: "4", courseCode: "CSE2001", courseName: "Database Systems", credits: 4.0, grade: "A", gradePoints: 9.0, semester: "Spring 2024"),
        Grade(id: "5", courseCode: "CSE2002", courseName: "Operating Systems", credits: 4.0, grade: "B+", gradePoints: 8.0, semester: "Spring 2024")
    ]
)

