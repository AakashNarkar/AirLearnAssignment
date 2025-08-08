# AirLearnAssignment

# GitHub User Search App

An iOS application built as part of an assignment to search GitHub users, view their profiles, and explore their public repositories.

---

## 🚀 Features

### 🔍 User Search
- Search GitHub users by their username.
- View list of matching usernames along with avatar thumbnails.

### 👤 User Profile
- Display user's avatar, username, and bio.
- Show number of followers and public repositories.

### 📦 Repositories List
- Display list of repositories for a selected user.
- Show repository name, description, star count, and fork count.

### ⚠️ Error Handling
- Shows message for:
  - Invalid usernames (`User not found`)
  - Network/API failures

---

## 🧱 Architecture & Tools

| Component             | Used                           |
|----------------------|--------------------------------|
| Platform             | iOS (Swift, SwiftUI)           |
| Architecture         | MVVM                           |
| Networking           | URLSession                     |
| Async Handling       | Combine                        |
| Image Loading        | SDWebImageSwiftUI              |
| UI Components        | SwiftUI (`List`, `Navigation`) |
| Xcode Version        | 16.2                           |

---

## 📲 Steps to Run the App

1. **Clone the repository**
   git clone https://github.com/AakashNarkar/AirLearnAssignment.git
   
2. **Install dependencies**
   pod install
   
3. **Open AirLearnAssignment.xcworkspace in Xcode**

4. **sRun on a simulator or physical device**

