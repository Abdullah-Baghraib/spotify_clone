import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../data/repositories/mock_data_repository.dart';
import '../../domain/entities/artist.dart';
import '../blocs/player/player_cubit.dart';
import '../widgets/track_list_item.dart';

class ArtistScreen extends StatelessWidget {
  final Artist? artist;
  final String id;

  const ArtistScreen({
    Key? key,
    this.artist,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mockRepo = MockDataRepository();
    // Use provided artist or find it in repo using id
    final resolvedArtist = artist ??
        mockRepo.topArtists.firstWhere(
          (a) => a.id == id,
          orElse: () => mockRepo.topArtists.first,
        );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildArtistHeader(context, resolvedArtist),
          _buildActionButtons(context, resolvedArtist),
          _buildPopularSection(context, resolvedArtist),
          // In a real app, you would add more sections like albums, singles, appears on, etc.
          const SliverToBoxAdapter(
            child: SizedBox(height: AppConstants.paddingL),
          ),
        ],
      ),
    );
  }

  Widget _buildArtistHeader(BuildContext context, Artist artist) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            _buildArtistImage(artist.imageUrl),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: AppConstants.paddingL,
              left: AppConstants.paddingM,
              right: AppConstants.paddingM,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    artist.name,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppConstants.paddingS),
                  Text(
                    '${(artist.monthlyListeners / 1000000).toStringAsFixed(1)}M monthly listeners',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
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

  Widget _buildArtistImage(String imageUrl) {
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
            Icons.person,
            color: AppColors.textSecondary,
            size: 80,
          ),
        ),
      );
    }
  }

  Widget _buildActionButtons(BuildContext context, Artist artist) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingM),
        child: Row(
          children: [
            OutlinedButton(
              onPressed: () {
                // Follow/unfollow artist
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusCircular),
                ),
                side: BorderSide(
                  color: artist.isFollowed ? AppColors.primary : AppColors.textSecondary,
                ),
              ),
              child: Text(
                artist.isFollowed ? 'Following' : 'Follow',
                style: TextStyle(
                  color: artist.isFollowed ? AppColors.primary : AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(width: AppConstants.paddingM),
            ElevatedButton(
              onPressed: () {
                if (artist.topTracks.isNotEmpty) {
                  // Shuffle play artist's tracks
                  context.read<PlayerCubit>().playQueue(
                        artist.topTracks,
                        0,
                      );
                  Navigator.pushNamed(
                    context,
                    AppConstants.playerRoute,
                    arguments: artist.topTracks.first,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusCircular),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shuffle),
                  SizedBox(width: 4),
                  Text('Shuffle Play'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularSection(BuildContext context, Artist artist) {
    final playerCubit = context.read<PlayerCubit>();

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == 0) {
            return const Padding(
              padding: EdgeInsets.all(AppConstants.paddingM),
              child: Text(
                'Popular',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            );
          }

          final trackIndex = index - 1;
          if (trackIndex >= artist.topTracks.length) {
            return null;
          }

          final track = artist.topTracks[trackIndex];
          return TrackListItem(
            track: track,
            onTap: () {
              playerCubit.playQueue(artist.topTracks, trackIndex);
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
        childCount: artist.topTracks.length + 1, // +1 for the header
      ),
    );
  }
} 