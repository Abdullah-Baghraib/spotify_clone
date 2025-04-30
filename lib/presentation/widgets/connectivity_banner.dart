import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/services/connectivity_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_constants.dart';

class ConnectivityBanner extends StatelessWidget {
  const ConnectivityBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final connectivityService = Provider.of<ConnectivityService>(context);
    
    return ValueListenableBuilder<bool>(
      valueListenable: connectivityService.isConnected,
      builder: (context, isConnected, child) {
        if (isConnected) {
          return const SizedBox.shrink();
        }
        
        return Container(
          color: AppColors.error,
          padding: const EdgeInsets.symmetric(
            vertical: AppConstants.paddingS,
            horizontal: AppConstants.paddingM,
          ),
          width: double.infinity,
          child: const Row(
            children: [
              Icon(
                Icons.wifi_off_rounded,
                color: Colors.white,
                size: 16,
              ),
              SizedBox(width: AppConstants.paddingS),
              Text(
                'No internet connection',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
} 