import 'package:flutter/material.dart';
import '../../domain/entities/artist.dart';
import '../../domain/entities/playlist.dart';
import '../../domain/entities/track.dart';
import '../../presentation/screens/artist_screen.dart';
import '../../presentation/screens/main_screen.dart';
import '../../presentation/screens/player_screen.dart';
import '../../presentation/screens/playlist_screen.dart';
import '../constants/app_constants.dart';

class AppRouter {
  static Map<String, WidgetBuilder> routes = {
    AppConstants.homeRoute: (context) => const MainScreen(initialIndex: 0),
    AppConstants.searchRoute: (context) => const MainScreen(initialIndex: 1),
    AppConstants.libraryRoute: (context) => const MainScreen(initialIndex: 2),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppConstants.playerRoute:
        final track = settings.arguments as Track?;
        return MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => PlayerScreen(initialTrack: track),
        );

      case AppConstants.playlistRoute:
        final args = settings.arguments as Map<String, dynamic>;
        final playlist = args['playlist'] as Playlist?;
        final id = args['id'] as String;
        return MaterialPageRoute(
          builder: (_) => PlaylistScreen(playlist: playlist, id: id),
        );

      case AppConstants.artistRoute:
        final args = settings.arguments as Map<String, dynamic>;
        final artist = args['artist'] as Artist?;
        final id = args['id'] as String;
        return MaterialPageRoute(
          builder: (_) => ArtistScreen(artist: artist, id: id),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const MainScreen(initialIndex: 0),
        );
    }
  }
} 