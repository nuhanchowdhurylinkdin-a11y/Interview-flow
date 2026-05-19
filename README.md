# Interview Flow — AI-Powered Interview Preparation App

A cross-platform Flutter application that helps users prepare for job interviews through AI-driven practice sessions, personalized learning roadmaps, and intelligent coaching.

---

## Overview

Interview Flow is a full-featured mobile application that builds a personalized profile for each user and delivers AI-generated interview questions, real-time voice or text answer input, automated scoring, and structured feedback — all within a clean purple-gradient UI.

---

## Features

### Onboarding & Profile Setup
- **Splash → Onboarding** — two introductory screens with smooth Lottie animations
- **Avatar selection** — choose from a grid of preset avatars
- **8-step info wizard** — collects current role, experience level, target roles, skills, goals, focus areas, and resume upload
- **AI profile analysis** — the backend analyzes the collected data and generates a personalized brief shown before the main app loads

### Authentication
- Email / password sign-up with OTP email verification
- Sign in, forgot password, and password reset flows
- JWT token refresh handled transparently by `NetworkCaller`

### Home Dashboard
- **Resume session** — continue a paused practice session with progress bar and question count
- **Your Progress** — shows personal score, average score, and current streak
- **Recent Activity** — list of latest practice sessions with scores
- **Today's Tip** — server-delivered daily interview tip

### AI Coach Mode (Practice)
- Select interview type: **Technical** or **Non-Technical / Behavioral**
- Choose a specific topic (e.g., Data Structures, System Design, Leadership)
- Receive AI-personalized questions with audio playback (text-to-speech)
- Answer by **voice** (hold-to-record with live speech-to-text transcription) or **keyboard**
- Edit the transcribed text before submitting
- Inline hints revealed on demand
- Submit answers one at a time; end session early at any point
- **Practice Summary** screen with AI-generated scores and feedback

### Learning Roadmap
- Week-by-week study plan generated from the user's profile
- Visual progress tracking per week

### Interview Planner
- Schedule upcoming real interviews (company, role, date/time, phase)
- Set reminders; view and manage all planned interviews
- Track planner history and review past entries

### Pro Tips
- Categorized professional interview advice fetched from the server
- Expandable card-based layout

### Profile & Settings
- **Edit profile** — update name, bio, and avatar
- **Target Roles** — manage the job roles you are targeting
- **Resumes** — upload and manage multiple resumes (used to personalize AI questions)
- **Statistics** — detailed performance breakdown with progress bars per category
- **History** — tabbed view of practice sessions and planner history; tap any session to view full AI feedback
- **Notification settings** — granular toggles for push notification types
- **Notification inbox** — all received push notifications with mark-as-read support
- **Logout**

### Push Notifications
- Firebase Cloud Messaging (FCM) via `easy_push_notification`
- FCM token registered / deregistered on the backend on login / logout
- Foreground notification display with tap-to-navigate support

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter (Dart SDK `^3.9.2`) |
| State Management | GetX (`^4.7.3`) |
| Navigation | GetX named routes |
| HTTP | `http ^1.6.0` + custom `NetworkCaller` with JWT refresh |
| Real-time | `web_socket_channel ^3.0.3` |
| Local Storage | `shared_preferences ^2.5.4` |
| Push Notifications | Firebase Core + `easy_push_notification` |
| Voice Input | `speech_to_text ^7.3.0` |
| Audio Playback | `flutter_tts ^4.2.5` + `audioplayers ^6.5.1` |
| Audio Recording | `record ^6.1.2` |
| File Handling | `file_picker ^10.3.7` + `file_selector ^1.0.3` |
| Animations | `lottie ^3.3.2` |
| UI Utilities | `flutter_screenutil`, `google_fonts`, `skeletonizer`, `smooth_page_indicator` |
| Fonts & Icons | Google Fonts + custom PNG icon set |
| Splash Screen | `flutter_native_splash ^2.4.7` |
| App Icons | `flutter_launcher_icons ^0.14.4` |

---

## Project Structure

```
lib/
├── main.dart                        # App entry point; Firebase, storage, FCM init
├── app.dart                         # GetMaterialApp setup
├── firebase_options.dart            # Generated Firebase config
├── routes/
│   └── app_routes.dart              # All named routes
├── core/
│   ├── bindings/                    # GetX controller bindings
│   ├── common/
│   │   ├── styles/                  # Global text styles
│   │   └── widgets/                 # Shared UI components (buttons, checkboxes)
│   ├── models/                      # Shared response models
│   ├── services/
│   │   ├── firebase/                # FCM handler, notification service
│   │   ├── network_caller.dart      # HTTP client with token refresh
│   │   ├── storage_service.dart     # SharedPreferences wrapper
│   │   └── native_file_picker.dart
│   ├── localization/                # App localization strings
│   └── utils/
│       ├── constants/               # Colors, icon paths, image paths, API URLs, enums
│       ├── theme/                   # App theme + custom sub-themes
│       ├── validators/              # Form validators
│       ├── formatters/
│       ├── helpers/
│       ├── device/
│       └── logging/
└── features/
    ├── splash/
    ├── onboarding/
    ├── auth/                        # Sign in, sign up, OTP, reset password
    ├── collect_info/                # 8-page profile wizard + AI brief
    ├── home/                        # Dashboard, progress, tips
    ├── practice/                    # Interview type selection + AI Coach Mode
    ├── learning_roadmap/
    ├── interview_planner/
    ├── pro_tips/
    ├── bottom_nav_bar/
    ├── view_notifications/
    └── nav_screens/
        └── profile/
            ├── view_profile/
            ├── edit/
            ├── history/
            ├── statistics/
            ├── notifications/
            ├── resumes/
            └── roles/
```

Each feature follows the **MVC pattern**:

```
feature/
├── controller/   # GetX controllers (business logic, API calls)
├── model/        # JSON-deserialized data models
└── views/
    ├── screens/  # Full-page widgets
    └── widgets/  # Reusable components scoped to this feature
```

---

## Getting Started

### Prerequisites

- Flutter SDK `>=3.9.2`
- Dart SDK `^3.9.2`
- Android Studio / Xcode for device/emulator targets
- A Firebase project with Android and iOS apps configured

### Environment Variables

Create a `.env` file in the project root (already gitignored) and populate it with the required API URLs. See `.env.example` if provided.

### Installation

```bash
# Clone the repository
git clone <repository-url>
cd dtc6464-main

# Install dependencies
flutter pub get

# Generate app icons and splash screen
dart run flutter_launcher_icons
dart run flutter_native_splash:create
```

### Firebase Setup

The project ships with a pre-configured `firebase_options.dart` and `google-services.json`. To connect your own Firebase project:

1. Replace `android/app/google-services.json` with your own file.
2. Replace `ios/GoogleService-Info.plist` with your own file.
3. Regenerate `lib/firebase_options.dart` with the FlutterFire CLI:
   ```bash
   flutterfire configure
   ```

### Running

```bash
# Debug on a connected device or emulator
flutter run

# Release build — Android
flutter build apk --release

# Release build — iOS
flutter build ipa --release
```

---

## API Reference

| Domain | Key Endpoints |
|---|---|
| Auth | `POST /auth/login`, `POST /auth/register`, `POST /auth/verify-email`, `POST /auth/password-reset/send-code` |
| User | `GET/PUT /user/profile`, `PUT /user/profile-update`, `GET /user/your-progress` |
| Practice | `POST /practice/start`, `POST /practice/submit-answers/:id`, `GET /practice/resume-status`, `GET /practice/resume-questions/:id` |
| Tips | `GET /tips/daily-tips`, `GET /tips/pro-tips` |
| Interview Planner | `POST /interview/plan`, `GET /interview/plans` |
| Roadmap | `GET /roadmap` |
| History | `GET /history/practice-sessions`, `GET /history/planner`, `GET /history/statistics` |
| Resumes | `POST /user/resume`, `GET /user/resumes` |
| Notifications | `GET /notifications`, `POST /notifications/mark-read/:id`, `POST /notifications/mark-all-read/` |
| FCM | `POST /user/fcm-token`, `DELETE /user/fcm-token` |

All protected endpoints require a `Bearer` token in the `Authorization` header. The `NetworkCaller` service automatically refreshes expired tokens via the refresh endpoint.

---

## Architecture Notes

- **GetX** is used for both reactive state (`Obx` / `Rx` observables) and dependency injection (`Get.put` / `Get.find`). Controllers are registered globally in `ControllerBinder`.
- **Skeleton loading** (`skeletonizer`) is applied on all data-driven screens — content shimmer plays while API calls are in flight so the UI is never blank.
- **Error states** are handled inline with a "No data found / Pull to refresh" widget rather than full-page error screens, keeping navigation non-destructive.
- **Voice input** uses `speech_to_text` for live transcription. The transcribed text is placed into a shared `TextEditingController` so users can freely edit before submitting — bridging voice and keyboard input seamlessly.
- **WebSocket** support is wired up in `core/websoketMathod/websoket.dart` for future real-time features.

---

## Version

`1.0.0+1`
