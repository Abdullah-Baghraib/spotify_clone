import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/time_formatter.dart';
import '../../domain/entities/track.dart';

class TrackListItem extends StatelessWidget {
  final Track track;
  final VoidCallback? onTap;
  final VoidCallback? onMoreTap;
  final bool showAlbumArt;
  final bool isPlaying;
  final bool showDuration;

  const TrackListItem({
    Key? key,
    required this.track,
    this.onTap,
    this.onMoreTap,
    this.showAlbumArt = true,
    this.isPlaying = false,
    this.showDuration = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingM,
          vertical: AppConstants.paddingS,
        ),
        decoration: BoxDecoration(
          color: isPlaying ? AppColors.cardBackground : Colors.transparent,
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
        ),
        child: Row(
          children: [
            if (showAlbumArt) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(AppConstants.radiusS),
                child: SizedBox(
                  width: AppConstants.albumArtSizeS,
                  height: AppConstants.albumArtSizeS,
                  child: _buildImageWidget(track.albumArt),
                ),
              ),
              const SizedBox(width: AppConstants.paddingM),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    track.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isPlaying ? AppColors.primary : AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    track.artist,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (track.isLiked)
              const Icon(
                Icons.favorite,
                color: AppColors.primary,
                size: AppConstants.iconSizeS,
              ),
            if (showDuration) ...[
              const SizedBox(width: AppConstants.paddingS),
              Text(
                TimeFormatter.formatDuration(track.durationInSeconds),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
            IconButton(
              icon: const Icon(
                Icons.more_vert,
                color: AppColors.textSecondary,
              ),
              onPressed: onMoreTap,
            ),
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
          ),
        ),
      );
    }
  }
} 