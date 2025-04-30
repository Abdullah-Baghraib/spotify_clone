# Spotify Clone

A modern Flutter application that replicates the core functionality and UI of Spotify, providing a familiar music streaming experience with a clean, responsive interface.

## Features

- **Home Screen**: Dynamic content showcasing playlists, artists, and recently played tracks with a personalized greeting based on time of day
- **Search Screen**: Browse music categories and search for artists, songs, and playlists
- **Library Screen**: Access your saved playlists, artists, and albums with an intuitive tabbed interface
- **Player Screen**: Full-featured music player with playback controls, progress bar, and track information
- **Artist Profiles**: View artist information, popular tracks, and related content
- **Playlist Views**: Browse playlists with track listings and playback options
- **Offline Mode Detection**: Visual indication when device is not connected to the internet
- **Responsive Design**: Works across various screen sizes and orientations

## Architecture

The application follows a clean architecture approach with clear separation of concerns:

- **Domain Layer**: Contains business entities and interfaces
- **Data Layer**: Implements data sources and repositories
- **Presentation Layer**: Manages UI components and state using BLoC pattern

### Project Structure

```
lib/
├── core/
│   ├── constants/
│   ├── services/
│   ├── theme/
│   └── utils/
├── data/
│   ├── models/
│   └── repositories/
├── domain/
│   └── entities/
└── presentation/
    ├── blocs/
    ├── screens/
    └── widgets/
```

## Technologies

- **Flutter**: Cross-platform UI framework
- **flutter_bloc**: State management
- **cached_network_image**: Efficient image loading and caching
- **connectivity_plus**: Network connectivity monitoring
- **provider**: Dependency injection and state management
- **Material Design 3**: Modern UI components with custom theming

## Development

This application demonstrates several Flutter best practices:

- Proper state management with BLoC pattern
- Effective use of Flutter's widget composition
- Custom theming for consistent visual identity
- Offline-first design with proper error handling
- Smooth animations and transitions
- Responsive layouts for different screen sizes

## Getting Started

1. Clone the repository
2. Install dependencies: `flutter pub get`
3. Run the app: `flutter run`

## Screenshots


