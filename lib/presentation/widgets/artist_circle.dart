import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../domain/entities/artist.dart';

class ArtistCircle extends StatelessWidget {
  final Artist artist;
  final VoidCallback? onTap;
  final double size;

  const ArtistCircle({
    Key? key,
    required this.artist,
    this.onTap,
    this.size = 120,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipOval(
            child: SizedBox(
              width: size,
              height: size,
              child: _buildImageWidget(artist.imageUrl),
            ),
          ),
          const SizedBox(height: AppConstants.paddingS),
          Text(
            artist.name,
            style: Theme.of(context).textTheme.titleSmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          if (artist.isFollowed) ...[
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.paddingS,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: AppColors.textSecondary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(AppConstants.radiusS),
              ),
              child: const Text(
                'Following',
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ],
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
            Icons.person,
            color: AppColors.textSecondary,
            size: 40,
          ),
        ),
      );
    }
  }
} 