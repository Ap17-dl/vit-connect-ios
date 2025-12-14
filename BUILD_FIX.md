# Build Fix Guide

## Issue Fixed
The Xcode project file (`project.pbxproj`) has been updated to include **all 27 Swift files** that were missing. Previously, only 2 files were included, causing build failures.

## What Was Fixed
✅ Added all Models (8 files)
✅ Added all Views (17 files)  
✅ Added Managers (1 file)
✅ Added main app files (2 files)
✅ Fixed project structure with proper groups

## If Build Still Fails

### Option 1: Clean and Rebuild
1. In Xcode: **Product → Clean Build Folder** (`⌘ + Shift + K`)
2. Close Xcode
3. Reopen the project
4. Build again (`⌘ + R`)

### Option 2: Verify Files Are Added
1. In Xcode, check the Project Navigator (left sidebar)
2. You should see:
   - VITConnectApp.swift
   - ContentView.swift
   - Models/ (folder with 8 files)
   - Managers/ (folder with AuthManager.swift)
   - Views/ (folder with 17 files)
3. If any files are missing (red), right-click → "Add Files to VITConnect"

### Option 3: Check Target Membership
1. Select any Swift file in the navigator
2. In the right panel (File Inspector), check **"Target Membership"**
3. Make sure **"VITConnect"** is checked for ALL files

### Option 4: Re-add Files Manually
If the project file is still not working:

1. **Remove all files from project** (don't delete from disk):
   - Select files in Xcode
   - Press Delete
   - Choose "Remove Reference" (NOT "Move to Trash")

2. **Re-add all files**:
   - Right-click on "VITConnect" folder
   - "Add Files to VITConnect..."
   - Select the `VITConnect` folder
   - ✅ Check "Copy items if needed"
   - ✅ Check "Create groups"
   - ✅ Check "Add to targets: VITConnect"

### Common Build Errors & Fixes

#### Error: "Cannot find 'AuthManager' in scope"
**Fix**: Make sure `AuthManager.swift` is in the project and added to target

#### Error: "Cannot find 'User' in scope"  
**Fix**: Make sure all files in `Models/` folder are added to target

#### Error: "No such module 'SwiftUI'"
**Fix**: 
- Check iOS Deployment Target is 16.0+
- Product → Clean Build Folder
- Restart Xcode

#### Error: "Missing Info.plist"
**Fix**: 
- Check that `Info.plist` path is correct in Build Settings
- Should be: `VITConnect/Info.plist`

#### Error: Signing Issues
**Fix**:
- Go to Signing & Capabilities
- Check "Automatically manage signing"
- Select your Team (or create a free Apple ID)

## Verify Project Structure

Your project should look like this in Xcode:

```
VITConnect (Project)
└── VITConnect (Target)
    ├── VITConnectApp.swift ✅
    ├── ContentView.swift ✅
    ├── Info.plist ✅
    ├── Models/ ✅
    │   ├── User.swift
    │   ├── Attendance.swift
    │   ├── Grade.swift
    │   ├── Timetable.swift
    │   ├── MessMenu.swift
    │   ├── Faculty.swift
    │   ├── CabShare.swift
    │   └── Theme.swift
    ├── Managers/ ✅
    │   └── AuthManager.swift
    └── Views/ ✅
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

## Still Having Issues?

If the build still fails after these steps:

1. **Create a fresh Xcode project** (recommended):
   - File → New → Project
   - iOS → App
   - Name: VITConnect
   - Interface: SwiftUI
   - Copy all files from `VITConnect/` folder into the new project

2. **Check Xcode version**: Make sure you have Xcode 14.0 or later

3. **Check Swift version**: Should be Swift 5.0+

4. **Check iOS Deployment Target**: Should be 16.0 or higher

## Quick Test

Try building just one file:
1. Open `VITConnectApp.swift`
2. Press `⌘ + B` to build
3. Check error messages in the Issue Navigator (left sidebar, exclamation mark icon)

The error messages will tell you exactly what's missing!

