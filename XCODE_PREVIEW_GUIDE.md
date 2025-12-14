# How to Preview VIT Connect App in Xcode

## Quick Steps to Get Started

### Method 1: Create New Xcode Project (Easiest)

1. **Open Xcode** (make sure you have Xcode 14.0+ installed)

2. **Create a New Project**:
   - Click "Create a new Xcode project" or go to `File → New → Project`
   - Select **"iOS"** tab
   - Choose **"App"** template
   - Click **Next**

3. **Configure Project**:
   - **Product Name**: `VITConnect`
   - **Team**: Select your Apple Developer account (or "None" for now)
   - **Organization Identifier**: `com.vitconnect` (or your own)
   - **Interface**: **SwiftUI** ⚠️ (IMPORTANT!)
   - **Language**: **Swift**
   - **Storage**: **None**
   - Click **Next**
   - Choose where to save (you can save it anywhere)

4. **Replace Default Files**:
   - In Xcode, you'll see `VITConnectApp.swift` and `ContentView.swift` in the project navigator
   - **Delete** these two files (right-click → Delete → Move to Trash)

5. **Add Your Files**:
   - Right-click on the **VITConnect** folder (blue icon) in the project navigator
   - Select **"Add Files to VITConnect..."**
   - Navigate to your Desktop where you moved the files
   - Select the **`VITConnect`** folder (the one containing all the Swift files)
   - **IMPORTANT**: Check these options:
     - ✅ **"Copy items if needed"** (checked)
     - ✅ **"Create groups"** (selected)
     - ✅ **"Add to targets: VITConnect"** (checked)
   - Click **Add**

6. **Verify Files Are Added**:
   - You should see all your files in the project navigator:
     - `VITConnectApp.swift`
     - `ContentView.swift`
     - `Models/` folder with all model files
     - `Views/` folder with all view files
     - `Managers/` folder with `AuthManager.swift`

---

## Previewing Individual Views (SwiftUI Canvas)

### Enable Canvas Preview:

1. **Open any View file** (e.g., `LoginView.swift`)

2. **Enable Canvas**:
   - Press `⌘ + Option + Return` (Command + Option + Return)
   - OR click **Editor → Canvas** in the menu bar
   - OR click the **"Editor Options"** button (top right) → **Canvas**

3. **Add Preview Code** (if not already there):
   - At the bottom of the file, add:
   ```swift
   #Preview {
       LoginView()
           .environmentObject(AuthManager())
           .environmentObject(ThemeManager())
   }
   ```

4. **Preview Will Appear**:
   - The preview should appear on the right side
   - Click **"Resume"** if it says "Paused"
   - You can interact with the preview!

### Preview Different Views:

For each view, you can add a preview. Here are examples:

**LoginView.swift**:
```swift
#Preview {
    LoginView()
        .environmentObject(AuthManager())
        .environmentObject(ThemeManager())
}
```

**HomeView.swift**:
```swift
#Preview {
    HomeView()
        .environmentObject(AuthManager())
        .environmentObject(ThemeManager())
}
```

**AttendanceView.swift**:
```swift
#Preview {
    AttendanceView()
}
```

---

## Running the Full App in Simulator

### Step 1: Select a Simulator

1. At the top of Xcode, next to the play button, you'll see a device selector
2. Click it and select an **iPhone simulator** (e.g., "iPhone 15 Pro" or "iPhone 14")

### Step 2: Build and Run

1. Press **`⌘ + R`** (Command + R)
   - OR click the **Play button** (▶️) in the top left
   - OR go to **Product → Run**

2. **First Time Setup**:
   - Xcode will build the project (this may take a minute)
   - The simulator will launch automatically
   - The app will install and run

3. **You Should See**:
   - The login screen with gradient background
   - You can enter any reg number and password (it's mock data)
   - Click "Login" to see the main app

---

## Troubleshooting

### Issue: "Cannot find 'AuthManager' in scope"

**Solution**: Make sure `AuthManager.swift` is added to the project target:
1. Click on `AuthManager.swift` in the navigator
2. In the right panel (File Inspector), check **"Target Membership"**
3. Make sure **"VITConnect"** is checked

### Issue: Canvas Preview Not Showing

**Solutions**:
1. Make sure you're using **SwiftUI** interface (not UIKit)
2. Try **Product → Clean Build Folder** (`⌘ + Shift + K`)
3. Restart Xcode
4. Make sure preview code is at the bottom of the file

### Issue: Build Errors

**Common Fixes**:
1. **Check Deployment Target**:
   - Click on the project (blue icon) in navigator
   - Select **"VITConnect"** target
   - Go to **"General"** tab
   - Set **"iOS Deployment Target"** to **16.0** or higher

2. **Check All Files Are Added**:
   - Make sure all Swift files are in the project
   - Check that they're added to the target

3. **Clean Build**:
   - `Product → Clean Build Folder` (`⌘ + Shift + K`)
   - Then build again (`⌘ + R`)

### Issue: "Signing for VITConnect requires a development team"

**Solution**:
1. Click on the project (blue icon) in navigator
2. Select **"VITConnect"** target
3. Go to **"Signing & Capabilities"** tab
4. Check **"Automatically manage signing"**
5. Select your **Team** (or create a free Apple ID account)

---

## Quick Preview Tips

### Preview Multiple Devices:
```swift
#Preview("iPhone 15 Pro") {
    LoginView()
        .environmentObject(AuthManager())
        .environmentObject(ThemeManager())
}

#Preview("iPad Pro") {
    LoginView()
        .environmentObject(AuthManager())
        .environmentObject(ThemeManager())
        .previewDevice("iPad Pro (12.9-inch)")
}
```

### Preview Dark Mode:
```swift
#Preview("Dark Mode") {
    LoginView()
        .environmentObject(AuthManager())
        .environmentObject(ThemeManager())
        .preferredColorScheme(.dark)
}
```

### Interactive Preview:
- You can click buttons, type in text fields, and interact with the preview!
- Changes to code will automatically refresh the preview

---

## File Structure in Xcode

Your project should look like this in Xcode:

```
VITConnect (Project)
├── VITConnect (Target)
│   ├── VITConnectApp.swift
│   ├── ContentView.swift
│   ├── Info.plist
│   ├── Models/
│   │   ├── User.swift
│   │   ├── Attendance.swift
│   │   ├── Grade.swift
│   │   ├── Timetable.swift
│   │   ├── MessMenu.swift
│   │   ├── Faculty.swift
│   │   ├── CabShare.swift
│   │   └── Theme.swift
│   ├── Managers/
│   │   └── AuthManager.swift
│   └── Views/
│       ├── LoginView.swift
│       ├── MainTabView.swift
│       ├── HomeView.swift
│       └── ... (all other views)
```

---

## Keyboard Shortcuts

- **`⌘ + R`**: Build and Run
- **`⌘ + B`**: Build only
- **`⌘ + .`**: Stop running app
- **`⌘ + Option + Return`**: Toggle Canvas
- **`⌘ + Shift + K`**: Clean Build Folder
- **`⌘ + /`**: Comment/uncomment line

---

## Need Help?

If you encounter any issues:
1. Check the error messages in Xcode (red icons)
2. Make sure all files are properly added to the target
3. Verify iOS deployment target is 16.0+
4. Try cleaning the build folder and rebuilding

Good luck! 🚀

