import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diva/class/users.dart';
import 'package:diva/routes/route_helper.dart';
import 'package:diva/services/firebase_messaging.dart';
import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthFirestore {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference users = FirebaseFirestore.instance.collection("users");

  // SignIn user
  Future signIn(EUsers us,BuildContext context) async{
    showDialog(
    context: context,
    barrierDismissible: false, 
    builder: (context) => const Center(child: CircularProgressIndicator(color:colors.sp,),),
    );
    try{
       
              await _auth.signInWithEmailAndPassword(email: us.email, password: us.password);
             
              Get.offAllNamed(RouteHelper.homeToggle);
              await FirebaseApi().initNotifications();

    }on FirebaseAuthException catch (e){
       if (e.code == 'invalid-credential') {
                // Handle the case where the user is not found
                Get.snackbar(
                      "Adresse e-mail ou mot de passe incorrect",
                      "Veuillez utiliser des informations valides.",
                        backgroundColor: colors.sp,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                        margin: EdgeInsets.symmetric(
                          horizontal: Dimensitions.width10,
                          vertical: Dimensitions.height10,
                          ),
                        );
                        Future.delayed(Duration(milliseconds:4500 ),()=>Get.back());
              } 
    }
    //navigatorKey.currentState!.popUntil ((route)=>route.isFirst);
  }
  // SignIn user  
  Future signUp(EUsers us,BuildContext context) async{
    showDialog(
    context: context,
    barrierDismissible: false, 
    builder: (context) => const Center(child: CircularProgressIndicator(color:colors.sp,),),
    );
    try{
       

          UserCredential userCredential   =  await _auth.createUserWithEmailAndPassword(email: us.email, password: us.password);
              User? user = userCredential.user;
              if (user != null) {
              
              createUser  (us,user.uid);
              Get.offAllNamed(RouteHelper.homeToggle);
              await FirebaseApi().initNotifications();
              }
    }on FirebaseAuthException catch (e){
     if(e.code == 'email-already-in-use'){
                Get.snackbar(
                        "Compte existant",
                        "Veuillez utiliser un autre email, s'il vous plaît.",
                        backgroundColor: colors.sp,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                        margin: EdgeInsets.symmetric(
                          horizontal: Dimensitions.width10,
                          vertical: Dimensitions.height10,
                          ),
                        );
                      Future.delayed(Duration(milliseconds:4500 ),()=>Get.back());

              }
    }
    //navigatorKey.currentState!.popUntil ((route)=>route.isFirst);
  }
  // reset Password
  Future resetPassword(String email,BuildContext context,bool isIn) async{
    /*  showDialog(
    context: context,
    barrierDismissible: false, 
    builder: (context) => const Center(child: CircularProgressIndicator(color:colors.sp,),),
    );*/
    try {
      bool flag =await getUserByEmail(email);
      if(flag){
      
      await _auth.sendPasswordResetEmail(email: email);
     
         Get.snackbar(
                        "Envoyé avec succès",
                        "Votre demande de réinitialisation de mot de passe a été envoyée avec succès. Veuillez vérifier votre boîte de réception pour les instructions sur la façon de procéder.",
                        backgroundColor: colors.sp,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                        margin: EdgeInsets.symmetric(
                          horizontal: Dimensitions.width10,
                          vertical: Dimensitions.height10,
                          ),
                        );
                        


      }else{
        Get.snackbar(
                        "Email incorrecte",
                        "l'email n'existe pas",
                        backgroundColor: colors.sp,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                        margin: EdgeInsets.symmetric(
                          horizontal: Dimensitions.width10,
                          vertical: Dimensitions.height10,
                          ),
                        );

      }
      //Navigator.of(context).pop();


    }on FirebaseAuthException catch (e) {
      print(e.code);
      Navigator.of(context).pop();
    }
  }
  // Create
  Future<void> createUser  (EUsers us,String uid){
    return users.add(
      {
        "email":us.email,
        "name":us.name,
        "uid":uid,
        "type":us.type,
        "image":us.image,
        "firstTime":true,
        "date":"",
        "bio":"",
        "phone":"",
        "ville":"",
      });
      }
// get user by email
  Future<bool> getUserByEmail(String email) async {
  try {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    return snapshot.docs.isNotEmpty;
  } catch (e) {
    return false;
  }
}


}