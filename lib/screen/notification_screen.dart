import 'package:flutter/material.dart';

// Data model for notifications
class NotificationItem {
  final String title;
  final String subtitle;
  final String time;
  final bool highlight;
  final String section;

  NotificationItem({
    required this.title,
    required this.subtitle,
    required this.time,
    this.highlight = false,
    required this.section,
  });
}

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  // Sample notification data
  static List<NotificationItem> notifications = [
    NotificationItem(
      title: 'Payment confirm',
      subtitle:
          'Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae',
      time: '15 min ago',
      highlight: true,
      section: 'Today',
    ),
    NotificationItem(
      title: 'Bonus Notice',
      subtitle:
          'Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae',
      time: '25 min ago',
      section: 'Today',
    ),
    NotificationItem(
      title: 'Order Delivered',
      subtitle:
          'Your order #12345 has been successfully delivered to your address',
      time: '1 hour ago',
      highlight: false,
      section: 'Today',
    ),
    NotificationItem(
      title: 'Payment confirm',
      subtitle:
          'Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae',
      time: '2 hours ago',
      highlight: true,
      section: 'Yesterday',
    ),
    NotificationItem(
      title: 'Bonus Notice',
      subtitle:
          'Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae',
      time: '1 day ago',
      section: 'Yesterday',
    ),
    NotificationItem(
      title: 'Special Offer',
      subtitle:
          'Get 20% off on your next purchase. Limited time offer expires tomorrow',
      time: '1 day ago',
      section: 'Yesterday',
    ),
    NotificationItem(
      title: 'Bonus Notice',
      subtitle:
          'Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae',
      time: '1 day ago',
      section: 'Yesterday',
    ),
    NotificationItem(
      title: 'Payment confirm',
      subtitle:
          'Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae',
      time: '1 day ago',
      highlight: true,
      section: 'Yesterday',
    ),
    NotificationItem(
      title: 'Account Update',
      subtitle: 'Your profile information has been successfully updated',
      time: '2 days ago',
      section: 'This Week',
    ),
    NotificationItem(
      title: 'New Feature',
      subtitle: 'Check out the new dark mode feature in your settings',
      time: '3 days ago',
      section: 'This Week',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Group notifications by section
    Map<String, List<NotificationItem>> groupedNotifications = {};
    for (var notification in notifications) {
      if (!groupedNotifications.containsKey(notification.section)) {
        groupedNotifications[notification.section] = [];
      }
      groupedNotifications[notification.section]!.add(notification);
    }

    // Create a flat list with section headers
    List<dynamic> displayItems = [];
    List<String> sectionOrder = ['Today', 'Yesterday', 'This Week'];

    for (String section in sectionOrder) {
      if (groupedNotifications.containsKey(section)) {
        displayItems.add(section); // Add section header
        displayItems.addAll(groupedNotifications[
            section]!); // Add notifications for this section
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Notifications',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: displayItems.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No notifications',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: displayItems.length,
              itemBuilder: (context, index) {
                final item = displayItems[index];

                // If item is a String, it's a section header
                if (item is String) {
                  return SectionTitle(title: item);
                }

                // Otherwise, it's a notification
                final notification = item as NotificationItem;
                return NotificationCard(
                  title: notification.title,
                  subtitle: notification.subtitle,
                  time: notification.time,
                  highlight: notification.highlight,
                  onTap: () {
                    // Handle notification tap
                    print('Tapped on: ${notification.title}');
                  },
                );
              },
            ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, top: 12.0),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final bool highlight;
  final VoidCallback? onTap;

  const NotificationCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
    this.highlight = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: highlight ? const Color(0xFFE8F5E8) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: highlight
              ? Border.all(
                  color: const Color(0xFF4CAF50).withOpacity(0.3), width: 1)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notification icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: highlight
                    ? const Color(0xFF4CAF50).withOpacity(0.1)
                    : Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getNotificationIcon(title),
                color: highlight ? const Color(0xFF4CAF50) : Colors.grey[600],
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            // Notification content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.black.withOpacity(0.9),
                          ),
                        ),
                      ),
                      if (highlight)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF4CAF50),
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[700],
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getNotificationIcon(String title) {
    switch (title.toLowerCase()) {
      case 'payment confirm':
        return Icons.payment;
      case 'bonus notice':
        return Icons.card_giftcard;
      case 'order delivered':
        return Icons.local_shipping;
      case 'special offer':
        return Icons.local_offer;
      case 'account update':
        return Icons.account_circle;
      case 'new feature':
        return Icons.new_releases;
      default:
        return Icons.notifications;
    }
  }
}
