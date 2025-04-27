
<img src="ss-geocam (1).jpg" width="144"> <img src="ss-geocam (2).jpg" width="144"> <img src="ss-geocam (3).jpg" width="144">
# 📱 GeoCam News - Flutter App

A Flutter application created as part of a mobile developer challenge. GeoCam News allows users to capture photos with geolocation, fetch news from an API, bookmark news articles, and store data locally using SQLite and SharedPreferences.

---

## 🚀 Getting Started

### 🛠️ Requirements

- Flutter SDK (3.10+)
- Android Studio or VSCode
- Android/iOS Emulator or Physical Device

### 🔧 Installation

```bash
flutter pub get
flutter run
```

---

## 📦 Libraries Used

| Library                  | Description                                       |
| ------------------------ | ------------------------------------------------- |
| `http`                   | For basic HTTP requests                           |
| `dio`                    | Advanced networking, interceptors, error handling |
| `provider`               | State management with MVVM pattern                |
| `shared_preferences`     | Store small data locally (image bytes, flags)     |
| `sqflite`                | Local database for persistent news data           |
| `cached_network_image`   | Efficient image loading and caching               |
| `image`                  | Image processing and compression                  |
| `camera`                 | Native camera access for photo capture            |
| `google_fonts`           | Beautiful typography using Google Fonts           |
| `flutter_svg`            | Display SVG assets                                |
| `intl`                   | Date formatting                                   |
| `path_provider`          | Get system paths (storage/documents)              |
| `path`                   | Utility for file paths                            |
| `liquid_pull_to_refresh` | Pull to refresh widget with animation             |

---

## 📚 Features

-  Capture photo using device camera
-  Track real-time geolocation
-  Fetch news from NewsAPI
-  Save news to local SQLite database
-  Bookmark and manage favorite articles
-  Tab-based navigation for All vs Bookmarked news
-  DarkMode Material
-  Pull to refresh update news

---

## 🧠 Software Development Lifecycle (SDLC)

This project follows the **Waterfall SDLC Model**, which is ideal for solo development with clear requirements. Each phase is executed sequentially:

### 1. 📋 Requirements Analysis

- Understand features from challenge PDF.
- Tools needed: camera, location, API client, database.

### 2. 🧱 System Design

- Folder structure using Clean Architecture + MVVM.
- Data flow from API → repository → local DB → UI.

### 3. 🔨 Implementation

- Code modularized by features: `geocam`, `news`.
- Usecases, ViewModels, and UI are separated cleanly.

### 4. 🧪 Testing & Integration

- Manual testing on emulator and real device.
- Test permission handling, image compression, offline mode.

### 5. 🚀 Deployment

- Code committed to GitHub.
- APK built and tested in .APK.

### 6. 🧹 Maintenance (Optional)

- Refactor, add refresh/pagination if needed.

---

## 🗂 Folder Structure (Clean Architecture)

```
lib/
├── core/                    # Global utilities and base classes
├── features/
│   ├── geocam/             # GeoCam (photo + location)
│   └── news/               # News API + local database
├── shared/                 # Shared widgets, themes, etc
└── main.dart
```

---

## ✍️ Author

- Created by Reihan Bay for GeoCam Mobile Developer Challenge

---

## 🔑 Notes

- API used: [https://newsapi.org/](https://newsapi.org/)
- Make sure you enable camera and location permissions in AndroidManifest.xml

---

See Yaa! 🚀
I'm waiting the feedback!
