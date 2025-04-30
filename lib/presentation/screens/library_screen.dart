import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../data/repositories/mock_data_repository.dart';
import 'package:cached_network_image/cached_network_image.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['Playlists', 'Artists', 'Albums', 'Downloaded'];
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mockRepo = MockDataRepository();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildLibraryHeader(),
            _buildFilters(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPlaylistsTab(mockRepo),
                  _buildArtistsTab(mockRepo),
                  _buildAlbumsTab(),
                  _buildDownloadedTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLibraryHeader() {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.cardBackground,
            child: const Icon(
              Icons.person,
              size: 20,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: AppConstants.paddingM),
          const Text(
            'Your Library',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(
              Icons.search,
              color: AppColors.textPrimary,
            ),
            onPressed: () {
              // Open search in library
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.add,
              color: AppColors.textPrimary,
            ),
            onPressed: () {
              // Add new playlist
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filters row (Sort, Downloaded)
          Row(
            children: [
              // Sort filter pill
              Container(
                margin: const EdgeInsets.only(right: AppConstants.paddingS),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConstants.radiusCircular),
                  border: Border.all(color: AppColors.divider),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(AppConstants.radiusCircular),
                  onTap: () {
                    // Handle sort option
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppConstants.paddingM,
                      vertical: AppConstants.paddingXS,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Sort',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.textPrimary,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              // Downloaded filter pill
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConstants.radiusCircular),
                  border: Border.all(color: AppColors.divider),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(AppConstants.radiusCircular),
                  onTap: () {
                    // Handle downloaded filter
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppConstants.paddingM,
                      vertical: AppConstants.paddingXS,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_downward,
                          color: AppColors.textPrimary,
                          size: 12,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Filters',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppConstants.paddingM),
          
          // Redesigned tab bar
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _tabs.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedTabIndex == index;
                return Padding(
                  padding: const EdgeInsets.only(right: AppConstants.paddingS),
                  child: GestureDetector(
                    onTap: () {
                      _tabController.animateTo(index);
                    },
                    child: AnimatedContainer(
                      duration: AppConstants.animationDurationFast,
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? AppColors.primary.withOpacity(0.2) 
                            : AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(AppConstants.radiusM),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.paddingM,
                        vertical: AppConstants.paddingS,
                      ),
                      child: Center(
                        child: Text(
                          _tabs[index],
                          style: TextStyle(
                            color: isSelected 
                                ? AppColors.primary 
                                : AppColors.textSecondary,
                            fontWeight: isSelected 
                                ? FontWeight.w600 
                                : FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          const SizedBox(height: AppConstants.paddingS),
          
          // Divider
          Container(
            height: 1,
            color: AppColors.divider.withOpacity(0.5),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaylistsTab(MockDataRepository repo) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: AppConstants.paddingM),
      itemCount: repo.userPlaylists.length,
      itemBuilder: (context, index) {
        final playlist = repo.userPlaylists[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingM,
            vertical: AppConstants.paddingXS,
          ),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(AppConstants.radiusS),
            child: _buildPlaylistImage(playlist.coverImageUrl),
          ),
          title: Text(
            playlist.name,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            'Playlist • ${playlist.createdBy}',
            style: const TextStyle(
              color: AppColors.textSecondary,
            ),
          ),
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
    );
  }

  Widget _buildArtistsTab(MockDataRepository repo) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: AppConstants.paddingM),
      itemCount: repo.topArtists.length,
      itemBuilder: (context, index) {
        final artist = repo.topArtists[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingM,
            vertical: AppConstants.paddingXS,
          ),
          leading: CircleAvatar(
            radius: 28,
            backgroundImage: _getImageProvider(artist.imageUrl),
          ),
          title: Text(
            artist.name,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            'Artist',
            style: const TextStyle(
              color: AppColors.textSecondary,
            ),
          ),
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
        );
      },
    );
  }

  Widget _buildAlbumsTab() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.album,
            size: 64,
            color: AppColors.textSecondary,
          ),
          SizedBox(height: AppConstants.paddingM),
          Text(
            'No albums yet',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          SizedBox(height: AppConstants.paddingS),
          Text(
            'Albums you like will appear here',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDownloadedTab() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.download_done_rounded,
            size: 64,
            color: AppColors.textSecondary,
          ),
          SizedBox(height: AppConstants.paddingM),
          Text(
            'Nothing downloaded yet',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          SizedBox(height: AppConstants.paddingS),
          Text(
            'Downloaded content will appear here',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaylistImage(String imageUrl) {
    if (imageUrl.startsWith('assets/')) {
      return Image.asset(
        imageUrl,
        width: 56,
        height: 56,
        fit: BoxFit.cover,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        width: 56,
        height: 56,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: AppColors.shimmerBase,
          width: 56,
          height: 56,
        ),
        errorWidget: (context, url, error) {
          return Container(
            color: AppColors.cardBackground,
            width: 56,
            height: 56,
            child: const Icon(
              Icons.music_note,
              color: AppColors.textSecondary,
            ),
          );
        },
      );
    }
  }
  
  ImageProvider _getImageProvider(String imageUrl) {
    if (imageUrl.startsWith('assets/')) {
      return AssetImage(imageUrl);
    } else {
      return NetworkImage(imageUrl);
    }
  }
} 