//
//  AttendanceView.swift
//  VITConnect
//

import SwiftUI
import Charts

struct AttendanceView: View {
    @State private var selectedTab = 0
    @State private var attendanceData: [Attendance] = sampleAttendanceData
    @State private var analytics: AttendanceAnalytics = sampleAnalytics
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("View", selection: $selectedTab) {
                    Text("Overview").tag(0)
                    Text("Analytics").tag(1)
                    Text("Calculator").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                TabView(selection: $selectedTab) {
                    AttendanceOverviewView(attendance: attendanceData)
                        .tag(0)
                    
                    AttendanceAnalyticsView(analytics: analytics)
                        .tag(1)
                    
                    AttendanceCalculatorView()
                        .tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            .navigationTitle("Attendance")
        }
    }
}

struct AttendanceOverviewView: View {
    let attendance: [Attendance]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                // Overall Attendance Card
                OverallAttendanceCard(percentage: calculateOverallPercentage())
                
                // Course-wise Attendance
                ForEach(attendance) { course in
                    AttendanceCard(attendance: course)
                }
            }
            .padding()
        }
    }
    
    private func calculateOverallPercentage() -> Double {
        guard !attendance.isEmpty else { return 0 }
        let total = attendance.reduce(0) { $0 + $1.totalClasses }
        let attended = attendance.reduce(0) { $0 + $1.attendedClasses }
        return total > 0 ? (Double(attended) / Double(total)) * 100 : 0
    }
}

struct OverallAttendanceCard: View {
    let percentage: Double
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Overall Attendance")
                .font(.headline)
            
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 15)
                    .frame(width: 150, height: 150)
                
                Circle()
                    .trim(from: 0, to: percentage / 100)
                    .stroke(attendanceColor(percentage), style: StrokeStyle(lineWidth: 15, lineCap: .round))
                    .frame(width: 150, height: 150)
                    .rotationEffect(.degrees(-90))
                    .animation(.spring(), value: percentage)
                
                VStack {
                    Text("\(Int(percentage))%")
                        .font(.system(size: 40, weight: .bold))
                    Text(attendanceStatus(percentage))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(radius: 5)
    }
    
    private func attendanceColor(_ percentage: Double) -> Color {
        if percentage >= 75 {
            return .green
        } else if percentage >= 65 {
            return .orange
        } else {
            return .red
        }
    }
    
    private func attendanceStatus(_ percentage: Double) -> String {
        if percentage >= 75 {
            return "Safe"
        } else if percentage >= 65 {
            return "Warning"
        } else {
            return "Critical"
        }
    }
}

struct AttendanceCard: View {
    let attendance: Attendance
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(attendance.courseCode)
                        .font(.headline)
                    
                    Text(attendance.courseName)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text("\(Int(attendance.percentage))%")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(attendanceColor(attendance.percentage))
            }
            
            ProgressView(value: attendance.percentage, total: 100)
                .tint(attendanceColor(attendance.percentage))
            
            HStack {
                Text("\(attendance.attendedClasses)/\(attendance.totalClasses) classes")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text("Last updated: \(attendance.lastUpdated, style: .relative)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 3)
    }
    
    private func attendanceColor(_ percentage: Double) -> Color {
        if percentage >= 75 {
            return .green
        } else if percentage >= 65 {
            return .orange
        } else {
            return .red
        }
    }
}

struct AttendanceAnalyticsView: View {
    let analytics: AttendanceAnalytics
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Trend Chart
                if #available(iOS 16.0, *) {
                    AttendanceTrendChart(data: analytics.attendanceTrend)
                }
                
                // Statistics
                VStack(spacing: 15) {
                    StatRow(label: "Total Courses", value: "\(analytics.totalCourses)")
                    StatRow(label: "Overall Percentage", value: String(format: "%.1f%%", analytics.overallPercentage))
                    StatRow(label: "Courses Above 75%", value: "\(analytics.courses.filter { $0.percentage >= 75 }.count)")
                    StatRow(label: "Courses Below 75%", value: "\(analytics.courses.filter { $0.percentage < 75 }.count)")
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 3)
            }
            .padding()
        }
    }
}

@available(iOS 16.0, *)
struct AttendanceTrendChart: View {
    let data: [AttendanceDataPoint]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Attendance Trend")
                .font(.headline)
                .padding(.horizontal)
            
            Chart {
                ForEach(data, id: \.date) { point in
                    LineMark(
                        x: .value("Date", point.date, unit: .day),
                        y: .value("Percentage", point.percentage)
                    )
                    .foregroundStyle(.blue)
                    .interpolationMethod(.catmullRom)
                }
            }
            .frame(height: 200)
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 3)
        }
    }
}

struct AttendanceCalculatorView: View {
    @State private var totalClasses = ""
    @State private var attendedClasses = ""
    @State private var targetPercentage = "75"
    @State private var result: CalculationResult?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Calculate how many classes you need to attend")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding()
                
                VStack(spacing: 15) {
                    TextField("Total Classes", text: $totalClasses)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Attended Classes", text: $attendedClasses)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Target Percentage", text: $targetPercentage)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Calculate") {
                        calculateAttendance()
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                }
                .padding()
                
                if let result = result {
                    CalculationResultView(result: result)
                }
            }
            .padding()
        }
    }
    
    private func calculateAttendance() {
        guard let total = Int(totalClasses),
              let attended = Int(attendedClasses),
              let target = Double(targetPercentage) else {
            return
        }
        
        let currentPercentage = total > 0 ? (Double(attended) / Double(total)) * 100 : 0
        
        if currentPercentage >= target {
            result = CalculationResult(
                message: "You already have \(String(format: "%.1f", currentPercentage))% attendance!",
                classesNeeded: 0,
                canAchieve: true
            )
        } else {
            // Calculate classes needed
            // target = (attended + x) / (total + x) * 100
            // Solving for x: x = (target * total - 100 * attended) / (100 - target)
            let classesNeeded = Int(ceil((target * Double(total) - 100 * Double(attended)) / (100 - target)))
            
            result = CalculationResult(
                message: "To achieve \(String(format: "%.1f", target))% attendance:",
                classesNeeded: max(0, classesNeeded),
                canAchieve: true
            )
        }
    }
}

struct CalculationResult {
    let message: String
    let classesNeeded: Int
    let canAchieve: Bool
}

struct CalculationResultView: View {
    let result: CalculationResult
    
    var body: some View {
        VStack(spacing: 15) {
            Text(result.message)
                .font(.headline)
                .multilineTextAlignment(.center)
            
            if result.classesNeeded > 0 {
                VStack(spacing: 8) {
                    Text("\(result.classesNeeded)")
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(.blue)
                    
                    Text("classes needed")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(12)
            } else {
                Text("No additional classes needed!")
                    .font(.title3)
                    .foregroundColor(.green)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 3)
    }
}

struct StatRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(value)
                .fontWeight(.semibold)
        }
    }
}

// Sample Data
let sampleAttendanceData: [Attendance] = [
    Attendance(id: "1", courseCode: "CSE1001", courseName: "Data Structures", totalClasses: 40, attendedClasses: 35, percentage: 87.5, lastUpdated: Date()),
    Attendance(id: "2", courseCode: "CSE1002", courseName: "Algorithms", totalClasses: 38, attendedClasses: 28, percentage: 73.7, lastUpdated: Date()),
    Attendance(id: "3", courseCode: "MAT1001", courseName: "Linear Algebra", totalClasses: 42, attendedClasses: 40, percentage: 95.2, lastUpdated: Date())
]

let sampleAnalytics = AttendanceAnalytics(
    overallPercentage: 85.5,
    totalCourses: 3,
    courses: sampleAttendanceData,
    attendanceTrend: [
        AttendanceDataPoint(date: Date().addingTimeInterval(-7*24*3600), percentage: 82.0),
        AttendanceDataPoint(date: Date().addingTimeInterval(-5*24*3600), percentage: 83.5),
        AttendanceDataPoint(date: Date().addingTimeInterval(-3*24*3600), percentage: 84.2),
        AttendanceDataPoint(date: Date().addingTimeInterval(-1*24*3600), percentage: 85.0),
        AttendanceDataPoint(date: Date(), percentage: 85.5)
    ]
)

