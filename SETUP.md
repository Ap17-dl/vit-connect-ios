# iOS App Setup Guide

## Quick Start

### Option 1: Create New Xcode Project (Recommended)

1. Open Xcode
2. Create a new project:
   - Choose "iOS" → "App"
   - Product Name: `VITConnect`
   - Interface: `SwiftUI`
   - Language: `Swift`
   - Storage: `None` (or Core Data if you want persistence later)

3. Replace the default files:
   - Delete the default `ContentView.swift` and `VITConnectApp.swift` if they exist
   - Copy all files from this directory structure into your Xcode project

4. Add all files to Xcode:
   - Right-click on the project in Xcode
   - Select "Add Files to [Project Name]"
   - Select the `VITConnect` folder
   - Make sure "Copy items if needed" is checked
   - Make sure your target is selected

### Option 2: Use Existing Project Structure

If you want to use the provided `.xcodeproj` file:

1. Open `VITConnect.xcodeproj` in Xcode
2. You may need to add files manually:
   - Right-click on the project
   - Select "Add Files to VITConnect"
   - Add all Swift files from the `VITConnect` directory

## File Organization

Make sure your Xcode project has this structure:

```
VITConnect/
├── VITConnectApp.swift
├── ContentView.swift
├── Info.plist
├── Models/
│   ├── User.swift
│   ├── Attendance.swift
│   ├── Grade.swift
│   ├── Timetable.swift
│   ├── MessMenu.swift
│   ├── Faculty.swift
│   ├── CabShare.swift
│   └── Theme.swift
├── Managers/
│   └── AuthManager.swift
└── Views/
    ├── LoginView.swift
    ├── MainTabView.swift
    ├── HomeView.swift
    ├── AttendanceView.swift
    ├── AcademicView.swift
    ├── TimetableView.swift
    ├── MessMenuView.swift
    ├── LaundryView.swift
    ├── FriendsScheduleView.swift
    ├── FacultyRatingView.swift
    ├── CabShareView.swift
    ├── LostFoundView.swift
    ├── ThemeView.swift
    ├── ProfileView.swift
    ├── SettingsView.swift
    └── MoreView.swift
```

## Configuration

1. **Bundle Identifier**: Set to `com.vitconnect.app` or your own identifier
2. **Deployment Target**: iOS 16.0 or later
3. **Development Team**: Select your Apple Developer team for code signing

## Build and Run

1. Select a simulator or connected device
2. Press `Cmd + R` to build and run
3. The app should launch with the login screen

## Features

All features are implemented with UI and sample data:
- ✅ Login/Authentication
- ✅ Home Dashboard
- ✅ Attendance (Overview, Analytics, Calculator)
- ✅ Academics (Grades, CGPA, SGPA)
- ✅ Timetable
- ✅ Mess Menu
- ✅ Laundry Status
- ✅ Friends Schedule
- ✅ Faculty Rating
- ✅ Cab Share
- ✅ Lost & Found
- ✅ Themes (with custom theme builder)
- ✅ Profile & Settings

## Next Steps

1. **Backend Integration**: Connect to VTOP API for real data
2. **Authentication**: Implement actual VTOP login
3. **Data Persistence**: Add Core Data or UserDefaults for offline support
4. **Push Notifications**: Add notification support
5. **Image Upload**: Implement image upload for Lost & Found
6. **API Integration**: Connect to Unmessify API for mess menu and laundry

## Troubleshooting

### Build Errors
- Make sure all files are added to the target
- Check that Swift version is 5.0+
- Verify iOS deployment target is 16.0+

### Missing Files
- If Xcode can't find files, remove them from the project and re-add them
- Make sure file paths are correct

### Import Errors
- All imports should be standard SwiftUI/Foundation
- No external dependencies required for basic functionality

## Notes

- The app currently uses mock/sample data
- Real functionality requires backend API integration
- Some features need actual VTOP credentials to work fully

