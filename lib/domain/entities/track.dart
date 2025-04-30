import 'package:equatable/equatable.dart';

class Track extends Equatable {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String albumArt;
  final int durationInSeconds;
  final bool isLiked;
  final double playbackPercentage;

  const Track({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.albumArt,
    required this.durationInSeconds,
    this.isLiked = false,
    this.playbackPercentage = 0.0,
  });

  Track copyWith({
    String? id,
    String? title,
    String? artist,
    String? album,
    String? albumArt,
    int? durationInSeconds,
    bool? isLiked,
    double? playbackPercentage,
  }) {
    return Track(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      albumArt: albumArt ?? this.albumArt,
      durationInSeconds: durationInSeconds ?? this.durationInSeconds,
      isLiked: isLiked ?? this.isLiked,
      playbackPercentage: playbackPercentage ?? this.playbackPercentage,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        artist,
        album,
        albumArt,
        durationInSeconds,
        isLiked,
        playbackPercentage,
      ];
} 