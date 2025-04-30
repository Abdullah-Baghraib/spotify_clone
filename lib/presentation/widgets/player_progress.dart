import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/time_formatter.dart';

class PlayerProgress extends StatelessWidget {
  final double value;
  final int currentSeconds;
  final int totalDurationSeconds;
  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onChangeEnd;

  const PlayerProgress({
    Key? key,
    required this.value,
    required this.currentSeconds,
    required this.totalDurationSeconds,
    this.onChanged,
    this.onChangeEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 2,
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 6,
            ),
            overlayShape: const RoundSliderOverlayShape(
              overlayRadius: 14,
            ),
            activeTrackColor: AppColors.primary,
            inactiveTrackColor: AppColors.textSecondary.withOpacity(0.3),
            thumbColor: AppColors.textPrimary,
            overlayColor: AppColors.primary.withOpacity(0.3),
          ),
          child: Slider(
            value: value,
            onChanged: onChanged,
            onChangeEnd: onChangeEnd,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                TimeFormatter.formatDuration(currentSeconds),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                TimeFormatter.formatDuration(totalDurationSeconds),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
} 