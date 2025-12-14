# VIT Connect iOS App

iOS version of VIT Connect - Your Complete VTOP Companion & Campus Utility Hub for VIT Chennai students.

## Features

### Core Features
- ✅ **Friends Schedule Viewer** - View your friends' timetables
- ✅ **Attendance Analytics** - Track attendance with detailed analytics and trends
- ✅ **Attendance Calculator** - Calculate how many classes you need to attend
- ✅ **Academic Dashboard** - View CGPA, SGPA, grades, and credits
- ✅ **Exam & Timetable** - View your weekly class schedule
- ✅ **Mess Menu (Unmessify)** - Daily mess menu for breakfast, lunch, snacks, and dinner
- ✅ **Laundry Status (Unmessify)** - Track your laundry submissions
- ✅ **Faculty Rating** - Rate and review faculty members
- ✅ **Cab Share** - Find or create cab sharing opportunities
- ✅ **Lost & Found** - Report lost items or found items
- ✅ **13+ Themes + Custom Theme Builder** - Customize app appearance

## Requirements

- iOS 16.0+
- Xcode 14.0+
- Swift 5.0+

## Project Structure

```
ios/VITConnect/
├── VITConnectApp.swift          # App entry point
├── ContentView.swift             # Main content view
├── Models/                       # Data models
│   ├── User.swift
│   ├── Attendance.swift
│   ├── Grade.swift
│   ├── Timetable.swift
│   ├── MessMenu.swift
│   ├── Faculty.swift
│   ├── CabShare.swift
│   └── Theme.swift
├── Managers/                     # State managers
│   └── AuthManager.swift
└── Views/                        # UI Views
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

## Setup Instructions

1. Open the project in Xcode:
   ```bash
   open ios/VITConnect.xcodeproj
   ```

2. Configure your development team in Xcode:
   - Select the project in the navigator
   - Go to "Signing & Capabilities"
   - Select your development team

3. Build and run the app:
   - Select a simulator or connected device
   - Press Cmd+R to build and run

## Features Implementation Status

### ✅ Completed
- All UI screens and navigation
- Data models for all features
- Theme system with custom theme builder
- Authentication flow
- All major features UI

### 🔄 TODO (Backend Integration)
- Connect to VTOP API for actual data
- Implement real authentication
- Add data persistence
- Implement push notifications
- Add image upload for lost & found
- Connect to Unmessify API for mess menu and laundry

## Notes

- Currently uses mock/sample data for demonstration
- Backend API integration needs to be implemented
- Some features require actual VTOP credentials to function fully

## Credits

Based on the Android app developed by Divyanshu Patel
- Original App: [GitHub](https://github.com/divyanshupatel17/vit-connect)
- Website: [vitverse.web.app](https://vitverse.web.app)

## License

Not affiliated with VIT / VTOP

