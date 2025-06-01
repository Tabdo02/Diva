import 'package:diva/firebase_options.dart';
import 'package:diva/provider/account/user_provider.dart';
import 'package:diva/provider/home/category_provider.dart';
import 'package:diva/routes/route_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async{
  // initalize hive
  await Hive.initFlutter();
  // open the box 
  // ignore: unused_local_variable
  var box =await Hive.openBox('FirstTime');
  // ignore: unused_local_variable
  var box2 =await Hive.openBox('newNotification');

  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
 FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // Handle the notification that opened the app
  FirebaseMessaging.instance
      .getInitialMessage()
      .then((RemoteMessage? message) {
    if (message != null) {
      print('Notification caused app to open');
  // Handle the notification data here
    }
  });
     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness:Brightness.dark,
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp()); 
}

// reference the code 
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message ) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.notification!.body}');

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CategoryProvider(),),
        ChangeNotifierProvider(create: (context) => userProvider(),),
      ],
      child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteHelper.getinitial(),
      getPages: RouteHelper.routes,
    ),
      );
  }
}