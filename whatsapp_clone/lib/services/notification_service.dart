// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:http/http.dart' as http;

// class NotificationService {
//   final messaging = FirebaseMessaging.instance;
//   final local = FlutterLocalNotificationsPlugin();

//   Future<void> initNotification() async {
//     await messaging.requestPermission();
//     final fcmToken = await messaging.getToken();
//     print(fcmToken);

//     const android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const settings = InitializationSettings(android: android);
//     await local.initialize(settings: settings);

//     FirebaseMessaging.onMessage.listen((RemoteMessage msg) {});
//   }

//   Future<void> showNotification(String title, String body) async {
//     const androidDetails = AndroidNotificationDetails(
//       'chat_channel',
//       'Chat Notifications',
//       importance: Importance.max,
//       priority: Priority.high,
//     );

//     const NotificationDetails details = NotificationDetails(
//       android: androidDetails,
//     );

//     await local.show(
//       id: 0,
//       title: title,
//       body: body,
//       notificationDetails: details,
//     );
//   }

//   Future<void> sendPushNotification({
//     required String token,
//     required String senderName,
//     required String message,
//   }) async {
//     await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
//     headers: {
//       'Content-Type': 'application/json',
//       'Authorization':
//           'key=YOUR_SERVER_KEY', // from Firebase Console
//     }
//     );

//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _local =
      FlutterLocalNotificationsPlugin();

  /// Call this once in main() or in your home screen initState
  Future<void> initNotification() async {
    // Request permissions for iOS
    await _messaging.requestPermission();

    // Get and print device FCM token
    final fcmToken = await _messaging.getToken();
    print("FCM Token: $fcmToken");

    // Initialize local notification for foreground display
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const settings = InitializationSettings(android: androidSettings);
    await _local.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (details) {
        // Handle notification tap when app is foreground/background
        // You can navigate to specific chat screen here
      },
    );

    // Listen for foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage msg) {
      final notification = msg.notification;
      if (notification != null) {
        showNotification(notification.title ?? '', notification.body ?? '');
      }
    });

    // Listen for background/terminated message taps
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage msg) {
      // Handle navigation when user taps notification
      final data = msg.data;
      final chatId = data['chatId'];
      if (chatId != null) {
        // Navigate to chat screen with chatId
        // Navigator.pushNamed(context, '/chat', arguments: chatId);
      }
    });

    // Handle token refresh automatically
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      print("New FCM Token: $newToken");
      // Send this new token to your Firestore user document
    });
  }

  /// Show local notification (foreground)
  Future<void> showNotification(String title, String body) async {
    const androidDetails = AndroidNotificationDetails(
      'chat_channel',
      'Chat Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    await _local.show(id: 0, title: title,body:  body,notificationDetails:  details);
  }

  /// Send push notification via Cloud Function
  Future<void> sendPushNotification({
    required String token,
    required String senderName,
    required String message,
    String? chatId, // Optional, to open chat on tap
  }) async {
    final url = Uri.parse(
      'https://us-central1-YOUR_PROJECT.cloudfunctions.net/sendNotification',
    );

    final body = {
      'token': token,
      'senderName': senderName,
      'message': message,
      if (chatId != null) 'chatId': chatId,
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      print("Notification sent successfully");
    } else {
      print("Failed to send notification: ${response.body}");
    }
  }
}
