import 'package:equatable/equatable.dart';
import '../../../domain/entities/track.dart';

enum PlayerStatus { initial, loading, playing, paused, error }

class PlayerState extends Equatable {
  final PlayerStatus status;
  final Track? currentTrack;
  final List<Track> queue;
  final int currentIndex;
  final double currentPosition;
  final bool isShuffleOn;
  final bool isRepeatOn;
  final String? errorMessage;

  const PlayerState({
    this.status = PlayerStatus.initial,
    this.currentTrack,
    this.queue = const [],
    this.currentIndex = 0,
    this.currentPosition = 0.0,
    this.isShuffleOn = false,
    this.isRepeatOn = false,
    this.errorMessage,
  });

  PlayerState copyWith({
    PlayerStatus? status,
    Track? currentTrack,
    List<Track>? queue,
    int? currentIndex,
    double? currentPosition,
    bool? isShuffleOn,
    bool? isRepeatOn,
    String? errorMessage,
  }) {
    return PlayerState(
      status: status ?? this.status,
      currentTrack: currentTrack ?? this.currentTrack,
      queue: queue ?? this.queue,
      currentIndex: currentIndex ?? this.currentIndex,
      currentPosition: currentPosition ?? this.currentPosition,
      isShuffleOn: isShuffleOn ?? this.isShuffleOn,
      isRepeatOn: isRepeatOn ?? this.isRepeatOn,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get isPlaying => status == PlayerStatus.playing;

  int get currentPositionInSeconds {
    if (currentTrack == null) return 0;
    return (currentPosition * currentTrack!.durationInSeconds).floor();
  }

  @override
  List<Object?> get props => [
        status,
        currentTrack,
        queue,
        currentIndex,
        currentPosition,
        isShuffleOn,
        isRepeatOn,
        errorMessage,
      ];
} 