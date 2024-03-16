import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fcm_firebase/notification.dart';

class NotificationListenerProvider {

  void getMessage(BuildContext context) {
    print(":::::::::::::::::::::::::::");
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      RemoteNotification? notification = event.notification;
      print(":::::::::::::::::::::::::::: $notification");
      if (notification != null && event.notification!.android != null) {
        AndroidNotification androidNotification = event.notification!.android!;
        // Check if the notification is a Firebase In-App Messaging notification
        if (event.data.containsKey('google.c.a.e')) {
          // This is a FIAM notification
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(notification.title!),
                content: Text(notification.body!),
              );
            },
          );
        } else {
          // This is a regular FCM notification
          // Show local notification
          sendNotification(title: notification.title!, body: notification.body!);
          // Show Alert dialog

        }
      }
    });
  }
}
