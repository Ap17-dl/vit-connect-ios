//
//  FacultyRatingView.swift
//  VITConnect
//

import SwiftUI

struct FacultyRatingView: View {
    @State private var faculties: [Faculty] = sampleFaculties
    @State private var searchText = ""
    @State private var selectedFaculty: Faculty?
    
    var filteredFaculties: [Faculty] {
        if searchText.isEmpty {
            return faculties
        }
        return faculties.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.department.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                
                List(filteredFaculties) { faculty in
                    FacultyRow(faculty: faculty) {
                        selectedFaculty = faculty
                    }
                }
            }
            .navigationTitle("Faculty Rating")
            .sheet(item: $selectedFaculty) { faculty in
                FacultyDetailView(faculty: faculty)
            }
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            
            TextField("Search faculty...", text: $text)
        }
        .padding(10)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

struct FacultyRow: View {
    let faculty: Faculty
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(faculty.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(faculty.department)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text(faculty.designation)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.caption)
                        Text(String(format: "%.1f", faculty.averageRating))
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                    
                    Text("\(faculty.totalRatings) ratings")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 4)
        }
    }
}

struct FacultyDetailView: View {
    @Environment(\.dismiss) var dismiss
    let faculty: Faculty
    @State private var showingReviewForm = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Header
                    VStack(alignment: .leading, spacing: 10) {
                        Text(faculty.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(faculty.designation)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Text(faculty.department)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        if let email = faculty.email {
                            Text(email)
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(radius: 3)
                    
                    // Rating Summary
                    HStack {
                        VStack {
                            Text(String(format: "%.1f", faculty.averageRating))
                                .font(.system(size: 50, weight: .bold))
                            
                            HStack(spacing: 2) {
                                ForEach(1...5) { index in
                                    Image(systemName: index <= Int(faculty.averageRating) ? "star.fill" : "star")
                                        .foregroundColor(.yellow)
                                        .font(.caption)
                                }
                            }
                            
                            Text("\(faculty.totalRatings) ratings")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(radius: 3)
                    
                    // Reviews
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Reviews")
                                .font(.headline)
                            
                            Spacer()
                            
                            Button(action: { showingReviewForm = true }) {
                                Image(systemName: "plus.circle.fill")
                            }
                        }
                        
                        ForEach(faculty.reviews) { review in
                            ReviewCard(review: review)
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(radius: 3)
                }
                .padding()
            }
            .navigationTitle("Faculty Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
            .sheet(isPresented: $showingReviewForm) {
                AddReviewView(facultyId: faculty.id)
            }
        }
    }
}

struct ReviewCard: View {
    let review: FacultyReview
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(review.studentName)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Spacer()
                
                HStack(spacing: 2) {
                    ForEach(1...5) { index in
                        Image(systemName: index <= review.rating ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                            .font(.caption)
                    }
                }
            }
            
            Text(review.comment)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(review.date, style: .relative)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

struct AddReviewView: View {
    @Environment(\.dismiss) var dismiss
    let facultyId: String
    @State private var rating = 5
    @State private var comment = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("Your Rating") {
                    HStack {
                        ForEach(1...5) { index in
                            Button(action: { rating = index }) {
                                Image(systemName: index <= rating ? "star.fill" : "star")
                                    .foregroundColor(.yellow)
                                    .font(.title2)
                            }
                        }
                    }
                }
                
                Section("Your Review") {
                    TextEditor(text: $comment)
                        .frame(height: 100)
                }
            }
            .navigationTitle("Add Review")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Submit") {
                        // TODO: Submit review
                        dismiss()
                    }
                    .disabled(comment.isEmpty)
                }
            }
        }
    }
}

let sampleFaculties: [Faculty] = [
    Faculty(
        id: "1",
        name: "Dr. John Smith",
        department: "Computer Science",
        designation: "Professor",
        email: "john.smith@vit.ac.in",
        averageRating: 4.5,
        totalRatings: 45,
        reviews: [
            FacultyReview(id: "1", studentName: "Student A", rating: 5, comment: "Great teacher, explains concepts clearly.", date: Date().addingTimeInterval(-5*24*3600)),
            FacultyReview(id: "2", studentName: "Student B", rating: 4, comment: "Good course structure.", date: Date().addingTimeInterval(-10*24*3600))
        ]
    ),
    Faculty(
        id: "2",
        name: "Dr. Jane Doe",
        department: "Electronics",
        designation: "Associate Professor",
        email: "jane.doe@vit.ac.in",
        averageRating: 4.2,
        totalRatings: 32,
        reviews: []
    )
]

