
import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/utils.dart';

class NotificationService2
{
  static const AndroidNotificationChannel channel =  AndroidNotificationChannel(
    'mindpeers', // id
    'High Importance Notifications', // title
    description: 'This channel is used for Mindpeers notifications.', // description
    importance: Importance.max,
    playSound: true,
  );

  static final  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future<void> initialize(BuildContext context)
  async {
    /// This code is executed for IOs platform
    if(GetPlatform.isIOS)
    {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: true,
        sound: true,
      );

      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      );

    }

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    InitializationSettings initializationSettings=const InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
        iOS: DarwinInitializationSettings()
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings,onDidReceiveNotificationResponse: (payload){
      selectNotification(payload);
    },
    );

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    notificationListeners();
  }

  static Future selectNotification(NotificationResponse payload) async {
    if (payload != null) {

      print("notification payload: $payload");
      redirectToScreens(json.encode(payload));
    }

  }

  static Future<void> displayNotification(RemoteMessage remoteMessage)
  async {
   try {
      final id=DateTime.now().millisecondsSinceEpoch ~/1000;
      final NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription:channel.description,
            importance: Importance.max,
            priority: Priority.high,
        ),
      );

      flutterLocalNotificationsPlugin.show(
          id,
          remoteMessage.notification!.title,
          remoteMessage.notification!.body,
          notificationDetails,
          payload:json.encode(remoteMessage.data)
      );
    } catch (e) {
      print(e);
    }
  }

  static notificationListeners()
  {

    /// For refresh FCM token
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      print("FCM_TOKEN==$fcmToken");
    });


    /// For getting FCM token
    FirebaseMessaging.instance.getToken().then((value) {
      print("FCM_TOKEN==$value");

    });

    /// Gives you the message on which user tabs on notification
    /// and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((remoteMessage){
      if(remoteMessage!=null)
      {
        redirectToScreens(json.encode(remoteMessage.data));
      }
    });


    /// This method is called when application is in foreground.
    FirebaseMessaging.onMessage.listen((remoteMessage) {
      if(remoteMessage!=null)
      {
        print("Title==${remoteMessage.notification!.title}");
        print("Body==${remoteMessage.notification!.body}");
        print("Payload==${remoteMessage.data}");
        print("remoteMsg==${remoteMessage.data}");

        String payload=json.encode(remoteMessage.data);

        Map valueMap = json.decode(payload);

        print("valueMap==${valueMap['metaData']}");

        //json.encode(remoteMessage.data);
       // Map valueMap = json.decode(payload);

       // print("Payload==${json.encode(remoteMessage)}");

        if(GetPlatform.isAndroid)
        {
          displayNotification(remoteMessage);
        }
      }
    });

    /// This method called when app is in background but opened or in memory and
    /// user tab on notification
    FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
      if(remoteMessage!=null)
      {
        redirectToScreens(json.encode(remoteMessage.data));
      }
    });
  }

  static void redirectToScreens(String payload)
  {
    Map valueMap = json.decode(payload);
    if (valueMap["type"] == "Therapy") {
    }
  }
}