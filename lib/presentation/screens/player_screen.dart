import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../domain/entities/track.dart';
import '../blocs/player/player_cubit.dart';
import '../blocs/player/player_state.dart';
import '../widgets/playback_controls.dart';
import '../widgets/player_progress.dart';

class PlayerScreen extends StatelessWidget {
  final Track? initialTrack;

  const PlayerScreen({
    Key? key,
    this.initialTrack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PlayerCubit, PlayerState>(
        builder: (context, state) {
          final track = state.currentTrack ?? initialTrack;
          
          if (track == null) {
            return const Center(
              child: Text(
                'No track selected',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            );
          }

          final playerCubit = context.read<PlayerCubit>();
          
          if (initialTrack != null && state.currentTrack == null) {
            // Initialize with the track if it's provided and not already playing
            WidgetsBinding.instance.addPostFrameCallback((_) {
              playerCubit.playTrack(initialTrack!);
            });
          }

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.paddingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildHeader(context),
                  const Spacer(),
                  _buildAlbumArt(track),
                  const SizedBox(height: AppConstants.paddingXL),
                  _buildTrackInfo(track, playerCubit),
                  const SizedBox(height: AppConstants.paddingL),
                  PlayerProgress(
                    value: state.currentPosition,
                    currentSeconds: state.currentPositionInSeconds,
                    totalDurationSeconds: track.durationInSeconds,
                    onChanged: (value) {
                      playerCubit.seekTo(value);
                    },
                  ),
                  const SizedBox(height: AppConstants.paddingL),
                  PlaybackControls(
                    isPlaying: state.isPlaying,
                    isShuffleOn: state.isShuffleOn,
                    isRepeatOn: state.isRepeatOn,
                    onPlayPause: () => playerCubit.togglePlayPause(),
                    onPrevious: () => playerCubit.playPrevious(),
                    onNext: () => playerCubit.playNext(),
                    onShuffle: () => playerCubit.toggleShuffle(),
                    onRepeat: () => playerCubit.toggleRepeat(),
                  ),
                  const Spacer(),
                  _buildBottomControls(track, playerCubit),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.textPrimary,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        const Text(
          'Now Playing',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.more_vert,
            color: AppColors.textPrimary,
          ),
          onPressed: () {
            // Show options menu
          },
        ),
      ],
    );
  }

  Widget _buildAlbumArt(Track track) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppConstants.radiusL),
      child: SizedBox(
        width: AppConstants.albumArtSizeXL,
        height: AppConstants.albumArtSizeXL,
        child: _buildImageWidget(track.albumArt),
      ),
    );
  }
  
  Widget _buildImageWidget(String imageUrl) {
    if (imageUrl.startsWith('assets/')) {
      // Load from assets folder
      return Image.asset(
        imageUrl,
        fit: BoxFit.cover,
      );
    } else {
      // Load from network with caching
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: AppColors.shimmerBase,
        ),
        errorWidget: (context, url, error) => Container(
          color: AppColors.cardBackground,
          child: const Icon(
            Icons.music_note,
            color: AppColors.textSecondary,
            size: 80,
          ),
        ),
      );
    }
  }

  Widget _buildTrackInfo(Track track, PlayerCubit playerCubit) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    track.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    track.artist,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                track.isLiked ? Icons.favorite : Icons.favorite_border,
                color: track.isLiked ? AppColors.primary : AppColors.textSecondary,
                size: AppConstants.iconSizeM,
              ),
              onPressed: () => playerCubit.toggleFavorite(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomControls(Track track, PlayerCubit playerCubit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(
            Icons.devices,
            color: AppColors.textSecondary,
          ),
          onPressed: () {
            // Connect to device
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.share,
            color: AppColors.textSecondary,
          ),
          onPressed: () {
            // Share track
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.playlist_play,
            color: AppColors.textSecondary,
          ),
          onPressed: () {
            // Show queue
          },
        ),
      ],
    );
  }
} 