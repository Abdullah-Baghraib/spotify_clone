import 'package:equatable/equatable.dart';
import 'track.dart';

class Artist extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final int monthlyListeners;
  final List<Track> topTracks;
  final bool isFollowed;

  const Artist({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.monthlyListeners,
    required this.topTracks,
    this.isFollowed = false,
  });

  Artist copyWith({
    String? id,
    String? name,
    String? imageUrl,
    int? monthlyListeners,
    List<Track>? topTracks,
    bool? isFollowed,
  }) {
    return Artist(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      monthlyListeners: monthlyListeners ?? this.monthlyListeners,
      topTracks: topTracks ?? this.topTracks,
      isFollowed: isFollowed ?? this.isFollowed,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        monthlyListeners,
        topTracks,
        isFollowed,
      ];
} 