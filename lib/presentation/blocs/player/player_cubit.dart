import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/track.dart';
import 'player_state.dart';

class PlayerCubit extends Cubit<PlayerState> {
  Timer? _positionTimer;

  PlayerCubit() : super(const PlayerState());

  void togglePlayPause() {
    if (state.currentTrack == null) return;

    if (state.status == PlayerStatus.playing) {
      _pausePlayback();
    } else {
      _startPlayback();
    }
  }

  void playTrack(Track track, {List<Track>? queue, int index = 0}) {
    emit(state.copyWith(
      status: PlayerStatus.loading,
      currentTrack: track,
      queue: queue ?? [track],
      currentIndex: index,
      currentPosition: 0.0,
    ));

    _startPlayback();
  }

  void playQueue(List<Track> queue, int index) {
    if (queue.isEmpty) return;
    final track = queue[index];
    playTrack(track, queue: queue, index: index);
  }

  void _startPlayback() {
    emit(state.copyWith(status: PlayerStatus.playing));
    _startPositionTimer();
  }

  void _pausePlayback() {
    _positionTimer?.cancel();
    emit(state.copyWith(status: PlayerStatus.paused));
  }

  void _stopPlayback() {
    _positionTimer?.cancel();
    emit(const PlayerState());
  }

  void seekTo(double position) {
    if (state.currentTrack == null) return;
    emit(state.copyWith(currentPosition: position));
  }

  void playNext() {
    if (state.queue.isEmpty || state.currentTrack == null) return;

    final nextIndex = (state.currentIndex + 1) % state.queue.length;
    playTrack(state.queue[nextIndex], queue: state.queue, index: nextIndex);
  }

  void playPrevious() {
    if (state.queue.isEmpty || state.currentTrack == null) return;

    // If we're more than 3 seconds into the song, go back to the start
    if (state.currentPosition > 0.1) {
      seekTo(0.0);
      return;
    }

    final previousIndex = (state.currentIndex - 1 + state.queue.length) % state.queue.length;
    playTrack(
      state.queue[previousIndex],
      queue: state.queue,
      index: previousIndex,
    );
  }

  void toggleShuffle() {
    emit(state.copyWith(isShuffleOn: !state.isShuffleOn));
    // In a real app, we would reshuffle the queue here
  }

  void toggleRepeat() {
    emit(state.copyWith(isRepeatOn: !state.isRepeatOn));
  }

  void toggleFavorite() {
    if (state.currentTrack == null) return;

    final updatedTrack = state.currentTrack!.copyWith(
      isLiked: !state.currentTrack!.isLiked,
    );

    final newQueue = List<Track>.from(state.queue);
    newQueue[state.currentIndex] = updatedTrack;

    emit(state.copyWith(
      currentTrack: updatedTrack,
      queue: newQueue,
    ));
  }

  void _startPositionTimer() {
    _positionTimer?.cancel();
    _positionTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (state.currentTrack == null) {
        timer.cancel();
        return;
      }

      final newPosition = state.currentPosition + 0.2 / state.currentTrack!.durationInSeconds;
      if (newPosition >= 1.0) {
        if (state.isRepeatOn) {
          // If repeat one is on, restart current track
          seekTo(0.0);
        } else if (state.currentIndex < state.queue.length - 1 || state.isRepeatOn) {
          // If repeat all is on or there are more tracks, play next
          playNext();
        } else {
          // Otherwise stop playback
          _stopPlayback();
        }
      } else {
        emit(state.copyWith(currentPosition: newPosition));
      }
    });
  }

  @override
  Future<void> close() {
    _positionTimer?.cancel();
    return super.close();
  }
} 