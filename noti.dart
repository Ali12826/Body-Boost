// noti.dart

import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
    // Initialize AwesomeNotifications
    AwesomeNotifications().initialize(
      'resource://drawable/ic_notification', // Replace with correct app icon path
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic notifications',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showNotification();
          },
          child: Text('Show Notification'),
        ),
      ),
    );
  }

  void showNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'New Message',
        body: 'You have a new message.',
        bigPicture: 'asset://assets/images/notification_image.png', // Example: specify a valid asset path for a notification image
      ),
    );
  }
}
