import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nikitchem/support/imageassets.dart';

class NotificationController extends GetxController {
  // Dummy notification data (replace with API call later)
  final RxList<Map<String, dynamic>> notifications = <Map<String, dynamic>>[
    {
      'message': 'Highest Alert: Please Update On App you are not active',
      'timestamp': DateTime.now().subtract(Duration(minutes: 15)),
      'imagePath': ImageAssets.notificationicon,
    },
    {
      'message': 'Reminder: Update your profile details',
      'timestamp': DateTime.now().subtract(Duration(hours: 2)),
      'imagePath': ImageAssets.notificationicon,
    },
    {
      'message': 'New offer available for Paint X',
      'timestamp': DateTime.now().subtract(Duration(days: 1, hours: 1)),
      'imagePath': ImageAssets.notificationicon,
    },
    {
      'message': 'System maintenance scheduled tomorrow',
      'timestamp': DateTime.now().subtract(Duration(days: 2)),
      'imagePath': ImageAssets.notificationicon,
    },
  ].obs;

  // Group notifications by date
  Map<String, List<Map<String, dynamic>>> getGroupedNotifications() {
    final Map<String, List<Map<String, dynamic>>> grouped = {};
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));

    for (var notification in notifications) {
      final date = DateTime(
          notification['timestamp'].year,
          notification['timestamp'].month,
          notification['timestamp'].day);
      String key;
      if (date == today) {
        key = 'Today';
      } else if (date == yesterday) {
        key = 'Yesterday';
      } else {
        key = DateFormat('MMMM d, yyyy').format(date); // e.g., "May 14, 2025"
      }

      grouped.putIfAbsent(key, () => []).add(notification);
    }

    return grouped;
  }

  // Calculate relative time (e.g., "15 mins ago")
  String getRelativeTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} years ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} months ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} mins ago';
    } else {
      return 'Just now';
    }
  }
}