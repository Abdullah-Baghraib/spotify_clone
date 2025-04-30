import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/time_formatter.dart';
import '../../data/repositories/mock_data_repository.dart';
import '../../domain/entities/playlist.dart';
import '../blocs/player/player_cubit.dart';
import '../widgets/track_list_item.dart';

class PlaylistScreen extends StatelessWidget {
  final Playlist? playlist;
  final String id;

  const PlaylistScreen({
    Key? key,
    this.playlist,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mockRepo = MockDataRepository();
    // Use provided playlist or find it in repo using id
    final resolvedPlaylist = playlist ??
        mockRepo.userPlaylists.firstWhere(
          (p) => p.id == id,
          orElse: () => mockRepo.recommendedPlaylists.first,
        );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, resolvedPlaylist),
          _buildHeader(context, resolvedPlaylist),
          _buildPlayControls(context, resolvedPlaylist),
          _buildTrackList(context, resolvedPlaylist),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppConstants.paddingL),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, Playlist playlist) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            _buildPlaylistImage(playlist.coverImageUrl),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.background.withOpacity(0.7),
                    AppColors.background,
                  ],
                ),
              ),
            ),
          ],
        ),
        titlePadding: const EdgeInsets.all(AppConstants.paddingM),
        title: Text(
          playlist.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            // Show more options
          },
        ),
      ],
    );
  }

  Widget _buildPlaylistImage(String imageUrl) {
    if (imageUrl.startsWith('assets/')) {
      return Image.asset(
        imageUrl,
        fit: BoxFit.cover,
      );
    } else {
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

  Widget _buildHeader(BuildContext context, Playlist playlist) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              playlist.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.paddingS),
            Text(
              playlist.description,
              style: const TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppConstants.paddingS),
            Text(
              'Created by ${playlist.createdBy} • ${playlist.trackCount} songs, ${TimeFormatter.formatDuration(playlist.totalDuration)}',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayControls(BuildContext context, Playlist playlist) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingM,
          vertical: AppConstants.paddingS,
        ),
        child: Row(
          children: [
            ElevatedButton(
              onPressed: () {
                if (playlist.tracks.isNotEmpty) {
                  context.read<PlayerCubit>().playQueue(
                        playlist.tracks,
                        0,
                      );
                  Navigator.pushNamed(
                    context,
                    AppConstants.playerRoute,
                    arguments: playlist.tracks.first,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(AppConstants.paddingM),
              ),
              child: const Icon(
                Icons.play_arrow,
                size: AppConstants.iconSizeL,
              ),
            ),
            const SizedBox(width: AppConstants.paddingM),
            IconButton(
              icon: const Icon(
                Icons.favorite_border,
                color: AppColors.textSecondary,
              ),
              onPressed: () {
                // Add to favorites
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.arrow_circle_down_outlined,
                color: AppColors.textSecondary,
              ),
              onPressed: () {
                // Download playlist
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.share,
                color: AppColors.textSecondary,
              ),
              onPressed: () {
                // Share playlist
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackList(BuildContext context, Playlist playlist) {
    final playerCubit = context.read<PlayerCubit>();

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final track = playlist.tracks[index];
          return TrackListItem(
            track: track,
            onTap: () {
              playerCubit.playQueue(playlist.tracks, index);
              Navigator.pushNamed(
                context,
                AppConstants.playerRoute,
                arguments: track,
              );
            },
            onMoreTap: () {
              // Show track options
            },
          );
        },
        childCount: playlist.tracks.length,
      ),
    );
  }
} 