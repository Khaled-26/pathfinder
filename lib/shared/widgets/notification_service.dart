import 'package:flutter/material.dart';
import 'package:pathfinder/core/theme/app_theme.dart';

class NotificationService {
  static Future<void> init() async {}

  static void showNotification({
    required BuildContext context,
    required String title,
    required String body,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.notifications_rounded,
                  color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 13)),
                  Text(body,
                      style: const TextStyle(
                          color: Colors.white70,
                          fontFamily: 'Poppins',
                          fontSize: 11)),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: AppTheme.primary,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
