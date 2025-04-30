import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';

class PlaybackControls extends StatelessWidget {
  final bool isPlaying;
  final bool isShuffleOn;
  final bool isRepeatOn;
  final VoidCallback? onPlayPause;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  final VoidCallback? onShuffle;
  final VoidCallback? onRepeat;

  const PlaybackControls({
    Key? key,
    required this.isPlaying,
    this.isShuffleOn = false,
    this.isRepeatOn = false,
    this.onPlayPause,
    this.onPrevious,
    this.onNext,
    this.onShuffle,
    this.onRepeat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            Icons.shuffle,
            color: isShuffleOn ? AppColors.primary : AppColors.textSecondary,
            size: AppConstants.iconSizeM,
          ),
          onPressed: onShuffle,
        ),
        const SizedBox(width: AppConstants.paddingM),
        IconButton(
          icon: const Icon(
            Icons.skip_previous,
            color: AppColors.textPrimary,
            size: AppConstants.iconSizeL,
          ),
          onPressed: onPrevious,
        ),
        const SizedBox(width: AppConstants.paddingM),
        GestureDetector(
          onTap: onPlayPause,
          child: Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: AppColors.textPrimary,
                size: AppConstants.iconSizeL,
              )
              .animate(target: isPlaying ? 1 : 0)
              .scaleXY(
                begin: 1.0,
                end: 1.1,
                duration: AppConstants.animationDurationFast,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppConstants.paddingM),
        IconButton(
          icon: const Icon(
            Icons.skip_next,
            color: AppColors.textPrimary,
            size: AppConstants.iconSizeL,
          ),
          onPressed: onNext,
        ),
        const SizedBox(width: AppConstants.paddingM),
        IconButton(
          icon: Icon(
            isRepeatOn ? Icons.repeat_one : Icons.repeat,
            color: isRepeatOn ? AppColors.primary : AppColors.textSecondary,
            size: AppConstants.iconSizeM,
          ),
          onPressed: onRepeat,
        ),
      ],
    );
  }
} 