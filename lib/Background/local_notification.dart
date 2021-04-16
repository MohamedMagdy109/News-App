import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';

class notifcation {
  notifcation_Func(String title) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'media channel id',
      'media channel name',
      'media channel description',
      //color: Colors.red,
      icon: null,
      enableLights: true,
      // largeIcon: DrawableResourceAndroidBitmap("codex_logo"),
      visibility: NotificationVisibility.Public,

      styleInformation: MediaStyleInformation(),
    );
    var platformChannelSpecifics =
        NotificationDetails(androidPlatformChannelSpecifics, null);
    await flutterLocalNotificationsPlugin.show(
        0, title, 'see the full article', platformChannelSpecifics);
  }
}

// class notifcation {
//   notifcation_Func() {
//     var schedule = DateTime.now().add(Duration(seconds: 10));

//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'alarm_notif',
//       'alarm_notif',
//       'Channel for Alarm notification',
//       icon: 'codex_logo',
//       //sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
//       largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
//     );

//     var iOSPlatformChannelSpecifics = IOSNotificationDetails(
//        // sound: 'a_long_cold_sting.wav',
//         presentAlert: true,
//         presentBadge: true,
//         presentSound: true);

//     var platformChannelSpecifics = NotificationDetails(
//         androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

//     flutterLocalNotificationsPlugin.schedule(0, 'ana fashy5',
//         'hiiiiiiiiiiiiiiiiiii', schedule, platformChannelSpecifics);
//   }
// }
//codex_logo
