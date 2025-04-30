import 'package:equatable/equatable.dart';
import 'track.dart';

class Playlist extends Equatable {
  final String id;
  final String name;
  final String description;
  final String coverImageUrl;
  final String createdBy;
  final List<Track> tracks;
  final bool isPersonalized;

  const Playlist({
    required this.id,
    required this.name,
    required this.description,
    required this.coverImageUrl,
    required this.createdBy,
    required this.tracks,
    this.isPersonalized = false,
  });

  Playlist copyWith({
    String? id,
    String? name,
    String? description,
    String? coverImageUrl,
    String? createdBy,
    List<Track>? tracks,
    bool? isPersonalized,
  }) {
    return Playlist(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      createdBy: createdBy ?? this.createdBy,
      tracks: tracks ?? this.tracks,
      isPersonalized: isPersonalized ?? this.isPersonalized,
    );
  }

  int get totalDuration => tracks.fold(
      0, (previousValue, track) => previousValue + track.durationInSeconds);

  int get trackCount => tracks.length;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        coverImageUrl,
        createdBy,
        tracks,
        isPersonalized,
      ];
} 