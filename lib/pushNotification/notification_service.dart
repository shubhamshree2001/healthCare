
import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';

import '../theme/app_color.dart';

class NotificationService
{

  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future<void> initialize()
  async {
    /// This code is executed for IOs platform
    AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
        'resource://mipmap/ic_launcher',

        [
          NotificationChannel(
              channelGroupKey: 'basic_channel_group',
              channelKey: "mindpeers",
              channelName: "Basic notifications",
              channelDescription: "Notification channel for basic",
              defaultColor: AppColors.colorPrimary,
              ledColor: Colors.white,
              importance: NotificationImportance.High
          ),
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
            channelGroupkey: 'basic_channel_group',
            channelGroupName: 'Basic group',
          ),
        ],
        debug: true
    );
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    notificationListeners();
  }


  static Future<void> displayNotification(RemoteMessage remoteMessage)
  async {
    final id=DateTime.now().millisecondsSinceEpoch ~/1000;
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: id,
            channelKey: "mindpeers",
            title: remoteMessage.notification!.title,
            body: remoteMessage.notification!.body,
            notificationLayout: NotificationLayout.BigPicture,
            //wakeUpScreen: true,
            fullScreenIntent: true,
            largeIcon: "https://feeds.abplive.com/onecms/images/uploaded-images/2021/09/07/e899ff058db6d305a1713dc5afa68bbc_original.jpg",
            bigPicture: 'https://feeds.abplive.com/onecms/images/uploaded-images/2021/09/07/e899ff058db6d305a1713dc5afa68bbc_original.jpg'),
            //bigPicture: remoteMessage.data['image'])
            actionButtons: [
              NotificationActionButton(
                  key: 'done',
                  label: 'Done',
              ),
              NotificationActionButton(
                  key: 'cancel',
                  label: 'Cancel'
              )
            ]
    );
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
    FirebaseMessaging.onMessage.listen((remoteMessage) async {
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
          await displayNotification(remoteMessage);
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


    AwesomeNotifications().actionStream.listen((event) {
      print("Payload=======${event.payload}") ;
      if(event.buttonKeyPressed=="done")
      {
        print("Event==${event.buttonKeyPressed}");
      }
      else if(event.buttonKeyPressed=="cancel")
      {
        print("Event==${event.buttonKeyPressed}");
      }
    });
  }

  static void redirectToScreens(String payload)
  {
    Map valueMap = json.decode(payload);
    Get.toNamed(Routes.doctorDetails);
    if (valueMap["type"] == "Therapy") {

    }
  }
}