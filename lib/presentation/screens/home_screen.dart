import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/time_formatter.dart';
import '../../data/repositories/mock_data_repository.dart';
import '../widgets/artist_circle.dart';
import '../widgets/grid_playlist_tile.dart';
import '../widgets/playlist_card.dart';
import '../widgets/section_title.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mockRepo = MockDataRepository();
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 100,
            backgroundColor: AppColors.background,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.symmetric(
                horizontal: AppConstants.paddingM,
                vertical: AppConstants.paddingS,
              ),
              title: Text(
                TimeFormatter.getGreeting(),
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.cardBackground,
                  child: Icon(
                    Icons.person,
                    size: 20,
                    color: AppColors.textPrimary,
                  ),
                ),
                onPressed: () {
                  // Navigate to settings or profile
                },
              ),
              const SizedBox(width: AppConstants.paddingS),
            ],
          ),
          // Recently Played Grid
          SliverToBoxAdapter(
            child: SectionTitle(
              title: 'Recently Played',
              onSeeAllPressed: () {},
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: AppConstants.paddingS,
                crossAxisSpacing: AppConstants.paddingS,
                childAspectRatio: 3,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final playlist = mockRepo.recentlyPlayed[index];
                  return GridPlaylistTile(
                    playlist: playlist,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppConstants.playlistRoute,
                        arguments: {
                          'playlist': playlist,
                          'id': playlist.id,
                        },
                      );
                    },
                  );
                },
                childCount: mockRepo.recentlyPlayed.length,
              ),
            ),
          ),
          // Made For You Section
          SliverToBoxAdapter(
            child: SectionTitle(
              title: 'Made For You',
              onSeeAllPressed: () {},
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 240,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
                scrollDirection: Axis.horizontal,
                itemCount: mockRepo.recommendedPlaylists.length,
                itemBuilder: (context, index) {
                  final playlist = mockRepo.recommendedPlaylists[index];
                  return PlaylistCard(
                    playlist: playlist,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppConstants.playlistRoute,
                        arguments: {
                          'playlist': playlist,
                          'id': playlist.id,
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
          // Your Top Artists Section
          SliverToBoxAdapter(
            child: SectionTitle(
              title: 'Your Top Artists',
              onSeeAllPressed: () {},
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 170,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
                scrollDirection: Axis.horizontal,
                itemCount: mockRepo.topArtists.length,
                itemBuilder: (context, index) {
                  final artist = mockRepo.topArtists[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: AppConstants.paddingM),
                    child: ArtistCircle(
                      artist: artist,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppConstants.artistRoute,
                          arguments: {
                            'artist': artist,
                            'id': artist.id,
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          // Jump Back In Section
          SliverToBoxAdapter(
            child: SectionTitle(
              title: 'Jump Back In',
              onSeeAllPressed: () {},
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 240,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
                scrollDirection: Axis.horizontal,
                itemCount: mockRepo.recommendedPlaylists.length,
                itemBuilder: (context, index) {
                  final playlist = mockRepo.recommendedPlaylists.reversed.toList()[index];
                  return PlaylistCard(
                    playlist: playlist,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppConstants.playlistRoute,
                        arguments: {
                          'playlist': playlist,
                          'id': playlist.id,
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppConstants.paddingL),
          ),
        ],
      ),
    );
  }
} 