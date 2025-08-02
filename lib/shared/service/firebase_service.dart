import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:uuid/uuid.dart';

class FirebaseService {
  // Singleton
  static final FirebaseService instance = FirebaseService._internal();
  FirebaseService._internal();

  Future<String?> uploadImages(File? image) async {
    if (image == null) return null;

    try {
      const uuid = Uuid();
      final storageRef =
          FirebaseStorage.instance.ref().child("images/${uuid.v4()}");
      await storageRef.putFile(File(image.path));
      String urli = await storageRef.getDownloadURL();
      return urli;
    } catch (e) {
      return null;
    }
  }

  Future<String> uploadImagesData(Uint8List imageBytes) async {
    final storageRef = FirebaseStorage.instance.ref();
    final imageId = const Uuid().v4();
    final imageRef = storageRef.child('products/$imageId.jpg');

    final uploadTask = await imageRef.putData(
      imageBytes,
      SettableMetadata(contentType: 'image/jpeg'),
    );

    final downloadUrl = await uploadTask.ref.getDownloadURL();
    return downloadUrl;
  }

  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final _localNotifications = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    final fcmToken = await _firebaseMessaging.getToken();
    print('FCM Token: $fcmToken');

    // Cấu hình local notification
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);
    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        // Xử lý khi người dùng nhấn vào thông báo
        print('Notification tapped: ${details.payload}');
      },
    );

    // Lắng nghe foreground message
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Khi nhấn vào notification từ background hoặc killed
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification tapped (from background): ${message.data}');
    });

    final initialMsg = await _firebaseMessaging.getInitialMessage();
    if (initialMsg != null) {
      print('Notification tapped (from terminated): ${initialMsg.data}');
    }
  }

  static void _handleForegroundMessage(RemoteMessage message) {
    final notification = message.notification;
    if (notification != null && notification.android != null) {
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'default_channel',
            'Thông báo',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
          ),
        ),
        payload: message.data['payload'] ?? '',
      );
    }
  }
}
