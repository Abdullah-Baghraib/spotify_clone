import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../domain/entities/playlist.dart';

class PlaylistCard extends StatelessWidget {
  final Playlist playlist;
  final VoidCallback? onTap;
  final bool showDescription;
  final double width;
  final double aspectRatio;

  const PlaylistCard({
    Key? key,
    required this.playlist,
    this.onTap,
    this.showDescription = true,
    this.width = 170,
    this.aspectRatio = 0.8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.all(AppConstants.paddingS),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppConstants.radiusL),
                child: _buildImageWidget(playlist.coverImageUrl),
              ),
            ),
            const SizedBox(height: AppConstants.paddingS),
            Text(
              playlist.name,
              style: Theme.of(context).textTheme.titleSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (showDescription) ...[
              const SizedBox(height: 4),
              Text(
                playlist.description,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
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
            size: 40,
          ),
        ),
      );
    }
  }
} 