import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../infrastructures/routes/page_constants.dart';
import '../local_storage/local_storage.dart';
import '../local_storage/pref_const.dart';
import '../models/view_student_model.dart';
import 'package:http/http.dart' as http;


class SplashScreenController extends GetxController {
  // static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  // FlutterLocalNotificationsPlugin();
  var waitingTime = 3;
  var students = <Student>[].obs;
  var isSingle = "".obs;


  // NotificationServices notificationServices = NotificationServices();
  @override
  void onInit() {
//     // TODO: implement onInit
// notificationServices.requestNotificationPermission();
// notificationServices.firebaseInit();
// // notificationServices.isTokenRefresh();
// notificationServices.getDeviceToken().then((value) {
//   print("Device Token");
//   print(value);
// }

// );
    // firebaseInit();
    // getDeviceTokenToSendNotification();

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     flutterLocalNotificationsPlugin.show(
    //         notification.hashCode,
    //         notification.title,
    //         notification.body,
    //         NotificationDetails(
    //           android: AndroidNotificationDetails(
    //             channel.id,
    //             channel.name,
    //             channelDescription: channel.description,
    //             color: Colors.blue,
    //             playSound: true,
    //             icon: '@mipmap/ic_launcher',
    //           ),
    //         ));
    //   }
    //   initLocalNotification(context);
    //
    // });
    //
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print('A new onMessageOpenedApp event was published!');
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if (notification != null && android != null) {
    //    return;
    //   }
    // });
    nextPage();
    super.onInit();
  }

// void initLocalNotification(BuildContext context, RemoteMessage message)async{
//     var androidInitializationSettings = const AndroidInitializationSettings("@mipmap/ic_launcher");
//     var initializationSettings = InitializationSettings(
//       android: androidInitializationSettings
//     );
//    await _notificationsPlugin.initialize(
//       initializationSettings,
// onDidReceiveNotificationResponse: (payload){

// }
//    );

// }
  nextPage() {
    Future.delayed(Duration(seconds: waitingTime), () async {
      var isLogged =
          await PrefManager().readValue(key: PrefConst.loginValue) ?? "";
      var isFirst =
          await PrefManager().readValue(key: PrefConst.isIntroFirst) ?? "";
      if (isLogged == "yes") {
       await fetchStudentData();
       if(isSingle.value == "Yes"){
         await PrefManager().setUserData(userData: students.first);
         PrefManager().writeValue(key: PrefConst.siblingCount, value:students.length.toString());
         Get.offAndToNamed(
           RouteName.dashboard_screen,
         );
       }else{
         Get.offAndToNamed(
           RouteName.dashboard_screen,
         );
       }
      } else {
        Get.offAndToNamed(
          RouteName.login_screen,
        );
      }
    });
  }

  // getting notification token to send push notification
  Future<void> getDeviceTokenToSendNotification() async {
    final messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);
    await messaging.getToken().then((value) {
      print('FCM Token :==>\n$value"end"');
      PrefManager()
          .writeValue(key: PrefConst.fcmToken, value: value.toString());
    });
  }
  Future<void> fetchStudentData() async {
    try {
      // Retrieve stored values from PrefManager
      final parentID = await PrefManager().readValue(key: PrefConst.UserName);
      final pass = await PrefManager().readValue(key: PrefConst.UserPass);
      final session = await PrefManager().readValue(key: PrefConst.Session);
      final baseUrl =
      await PrefManager().readValue(key: PrefConst.baseUrlLocalSaved);

      // Construct the API URL
      final url =
          "${baseUrl}api/ParentApp/ViewStudentDetails/$parentID/$pass/$session";
      print("sibling url :${url}");
      // Make the API request
      final response = await http.get(Uri.parse(url));

      // Check if the response is successful
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final apiResponse = ApiResponse.fromJson(jsonResponse);

        // Ensure `data` is not null and update students list
        students.assignAll(apiResponse.data ?? []);
        // Handle single student scenario
        if (students.isNotEmpty && students.length == 1) {
          isSingle.value ="Yes";
          // Save student data and navigate to the dashboard

        }
        // Return the count of students as a string
      } else {
        // Handle non-200 status codes gracefully
        throw Exception('Failed to fetch student data: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      // Log the error and stack trace for debugging
      if (kDebugMode) {
        print("Error fetching student data: $e");
        print("Stack trace: $stackTrace");
      }
    } finally {
      // Ensure loading status is updated to complete

    }
  }

}
