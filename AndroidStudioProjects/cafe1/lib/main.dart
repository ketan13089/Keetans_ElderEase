//import 'package:cafe1/notifications/noti_service.dart';
import 'package:cafe1/pages/land.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Create a NotiService instance and initialize notifications
  // final notiService = NotiService();
  // await notiService.initNotification();

  runApp(MyApp()); // Pass NotiService to MyApp
}

class MyApp extends StatelessWidget {
 // final NotiService notiService; // Receive NotiService instance via constructor

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CoffeePage(),

    );
  }
}
