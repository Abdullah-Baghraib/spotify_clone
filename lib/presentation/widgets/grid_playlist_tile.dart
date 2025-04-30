import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../domain/entities/playlist.dart';

class GridPlaylistTile extends StatelessWidget {
  final Playlist playlist;
  final VoidCallback? onTap;
  final double height;

  const GridPlaylistTile({
    Key? key,
    required this.playlist,
    this.onTap,
    this.height = 80,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppConstants.radiusM),
                bottomLeft: Radius.circular(AppConstants.radiusM),
              ),
              child: SizedBox(
                width: height,
                height: height,
                child: _buildImageWidget(playlist.coverImageUrl),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.paddingM),
                child: Text(
                  playlist.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
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
          color: AppColors.shimmerBase,
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