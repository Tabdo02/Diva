import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi{
  final _firestore = FirebaseFirestore.instance;
  final _firebaseMessaing = FirebaseMessaging.instance;
  final _auth =FirebaseAuth.instance;
  Future<void> initNotifications() async{
    await _firebaseMessaing.requestPermission();
    final fcmToken = await _firebaseMessaing.getToken();
   
    if (fcmToken != "") {
      QuerySnapshot tokens = await _firestore.collection("tokens").where("token",isEqualTo: fcmToken).get();
      if (tokens.docs.length==0) {
        await _firestore.collection("tokens").add({
          'uid':_auth.currentUser!.uid,
          'token':fcmToken,
        });
      }
      
    }
  }

  // handl the message
  void handleMessage(RemoteMessage? message){
    if (message == null) return;

    // no deep linking i saind
  }

  // function to intialize background settings
  Future initPushNotification() async{
    // hand notification if the app was terminated
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    //atach event listner for when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}