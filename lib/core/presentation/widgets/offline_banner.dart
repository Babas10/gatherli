import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_spacing.dart';

/// Banner displayed at the top of the screen when device is offline.
///
/// Shows a clear message to users that they're viewing cached data
/// and changes will sync when connection is restored.
class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      color: Colors.orange.shade700,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_off, color: Colors.white, size: 16),
          SizedBox(width: AppSpacing.sm),
          Flexible(
            child: Text(
              'You\'re offline. Changes will sync when connection is restored.',
              style: TextStyle(color: Colors.white, fontSize: 12),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
