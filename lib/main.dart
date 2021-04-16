import 'package:News/newsAPI.dart';
import 'package:News/screens/Home.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:News/core/ui_components/info_widget.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'API.dart';
import 'Auth/auth.dart';
import 'Background/local_notification.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const String TAG = "BackGround_Work";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var initializationSettingsAndroid =
      AndroidInitializationSettings('codex_logo');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {});
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });

  ////////////////////////////////////////////////////////workmanager
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager.initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode: false // This should be false

      );
  /////////////////////////
  runApp(DevicePreview(builder: (context) => home()));
}

////////////////////////////////////////////////////////////////////////////////////////////////////
void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {
    print(TAG + "callbackDispatcher");
    News news = News();
    notifcation n = new notifcation();
    await news.getNews(
        'http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=2a372c7196aa4c8dacddaf330b3c4053');
    newslist = news.news;
    n.notifcation_Func(news.news[0].title);
    return Future.value(true);
  });
}

var newslist;
void getNews() async {
  News news = News();
  notifcation n = new notifcation();
  await news.getNews(
      'http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=2a372c7196aa4c8dacddaf330b3c4053');
  newslist = news.news;
  n.notifcation_Func(newslist[0].title);
}

class BackGroundWork {
  BackGroundWork._privateConstructor();

  static final BackGroundWork _instance = BackGroundWork._privateConstructor();

  static BackGroundWork get instance => _instance;

  _loadCounterValue(int value) async {
    getNews();
    // newslist[i].title

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('BackGroundCounterValue', value);
  }

  Future<int> _getBackGroundCounterValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    int counterValue = prefs.getInt('BackGroundCounterValue') ?? 0;
    return counterValue;
  }
}
///////////////////////////////////////////////////////////////////////////////////////////////////

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Data().getData();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      builder: DevicePreview.appBuilder,
      home: Scaffold(
        body: Container(
          color: Colors.black,
          width: screenWidth / 2,
          height: screenHeight / 2,
          child: InfoWidget(
            builder: (context, deviceInfo) {
              print(deviceInfo.orientation);
              print(deviceInfo.deviceType);
              print(deviceInfo.screenWidth);
              print(deviceInfo.screenHeight);
              print(deviceInfo.localWidth);
              print(deviceInfo.localHeight);
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:workmanager/workmanager.dart';

// const String TAG = "BackGround_Work";

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   Workmanager.initialize(
//       callbackDispatcher, // The top level function, aka callbackDispatcher
//       isInDebugMode: false // This should be false
//       );
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'BackGround Work Sample',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: BackGroundWorkSample(),
//     );
//   }
// }

// class BackGroundWorkSample extends StatefulWidget {
//   @override
//   _BackGroundWorkSampleState createState() => _BackGroundWorkSampleState();
// }

// class _BackGroundWorkSampleState extends State<BackGroundWorkSample> {
//   int _counterValue = 0;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     //This task runs periodically
//     //It will wait at least 10 seconds before its first launch
//     //Since we have not provided a frequency it will be the default 15 minutes
//     Workmanager.registerPeriodicTask(
//       TAG,
//       "simplePeriodicTask",
//       initialDelay: Duration(seconds: 10),
//     );
//     loalData();
//   }

//   void loalData() async {
//     _counterValue = await BackGroundWork.instance._getBackGroundCounterValue();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('BackGround Work Sample'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text("Counter Value: ${_counterValue}"),
//               RaisedButton(
//                 onPressed: () {
//                   loalData();
//                 },
//                 child: Text("Fetch Current Counter Value"),
//               )
//             ],
//           ),
//         ));
//   }
// }

// void callbackDispatcher() {
//   Workmanager.executeTask((task, inputData) async {
//     print(TAG + "callbackDispatcher");
//     int value = await BackGroundWork.instance._getBackGroundCounterValue();
//     BackGroundWork.instance._loadCounterValue(value + 1);
//     return Future.value(true);
//   });
// }

// class BackGroundWork {
//   BackGroundWork._privateConstructor();

//   static final BackGroundWork _instance = BackGroundWork._privateConstructor();

//   static BackGroundWork get instance => _instance;

//   _loadCounterValue(int value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setInt('BackGroundCounterValue', value);
//   }

//   Future<int> _getBackGroundCounterValue() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     //Return bool
//     int counterValue = prefs.getInt('BackGroundCounterValue') ?? 0;
//     return counterValue;
//   }
// }
