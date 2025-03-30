# GLizzet - Movie Trailer Streaming App

GLizzet is a modern Flutter application that provides users with a seamless experience to discover and watch movie trailers. The app integrates with various APIs to fetch movie data and trailers, offering a Netflix-like experience for movie previews.

## 🎥 Features

### User Authentication

- Email and password-based authentication
- Forgot password functionality
- User profile management
- Secure authentication using Firebase Auth

### Movie Discovery

- Browse trending movies
- Search functionality for finding specific movies
- Now playing section for latest releases
- Detailed movie information including cast, ratings, and descriptions

### Trailer Streaming

- High-quality video playback using YouTube Player integration
- Picture-in-picture support
- Smooth streaming experience
- Custom video controls

### User Interface

- Modern and intuitive design
- Bottom navigation for easy access to different sections
- Responsive layout that works across different screen sizes
- Smooth animations and transitions
- Loading states with shimmer effects

### Technical Features

- BLoC pattern for state management
- Firebase integration (Auth, Firestore, Analytics, Storage)
- RESTful API integration
- Local data persistence
- Responsive design

## 🛠️ Technologies Used

- Flutter SDK
- Firebase Services:
  - Firebase Authentication
  - Cloud Firestore
  - Firebase Analytics
  - Firebase Storage
- External APIs:
  - TMDB API for movie data
  - YouTube API for trailers
- State Management:
  - flutter_bloc
- Other Key Packages:
  - youtube_player_flutter
  - dio for HTTP requests
  - get_it for dependency injection
  - shimmer for loading effects

## 📱 Screenshots

[Demo Video](https://drive.google.com/file/d/1OIiImjpoqZ6UVBeySyQjB-iGLYKc4Sd5/view?usp=sharing)

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=2.18.2)
- Dart SDK
- Android Studio / VS Code
- Firebase project setup
- API keys for TMDB and YouTube

### Installation

1. Clone the repository:

```bash
git clone https://github.com/PanchamKumarr/Glizzet.git
```

2. Navigate to project directory:

```bash
cd Glizzet
```

3. Install dependencies:

```bash
flutter pub get
```

4. Setup Firebase:

- Create a new Firebase project
- Add Android and iOS apps to your Firebase project
- Download and add the configuration files:
  - `google-services.json` for Android
  - `GoogleService-Info.plist` for iOS

5. Add your API keys:

- Create a `.env` file in the root directory
- Add your TMDB and YouTube API keys

6. Run the app:

```bash
flutter run
```

## 📂 Project Structure

```
lib/
├── Views/              # UI components and screens
│   ├── Auth Views/     # Authentication related screens
│   ├── Nav Bar/        # Navigation components
│   └── Top Views/      # Main app screens
├── data/               # Data layer
│   ├── Models/         # Data models
│   └── repositories/   # Data repositories
├── logic/              # Business logic
│   └── api_data/       # API related state management
└── routes/             # App navigation

```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👨‍💻 Author

Pancham Kumar

## 🙏 Acknowledgments

- TMDB for providing the movie database API
- YouTube API for video integration
- Flutter team for the amazing framework
- Firebase team for backend services
