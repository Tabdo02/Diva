import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diva/screens/auth%20screens/auth%20other%20page/verfyemail.dart';
import 'package:diva/screens/home/goToHome.dart';
import 'package:diva/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeToggle extends StatefulWidget {
   HomeToggle({super.key});

  @override
  State<HomeToggle> createState() => _HomeToggleState();
}

class _HomeToggleState extends State<HomeToggle> {
  final FirebaseAuth _auth =FirebaseAuth.instance;
  bool? flag;
  bool? isV;
  Future<void> state() async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .limit(1)
          .get();
        Map<String, dynamic>  user = querySnapshot.docs.first.data() as Map<String, dynamic>;
        QuerySnapshot querySnapshot2 = await FirebaseFirestore.instance
          .collection('boutiques')
          .where('docId', isEqualTo: querySnapshot.docs.first.id)
          .limit(1)
          .get();
        Map<String,dynamic> offre={};
        if (querySnapshot2.docs.length==1) {
        offre=querySnapshot2.docs.first["offre"];
        }
        setState(() {
          flag=user["firstTime"];
          isV=querySnapshot2.docs.length==1? querySnapshot2.docs.first["accepted"] && offre.isNotEmpty:false;
        });
        if(user["firstTime"]==true){
      DocumentReference docRef = querySnapshot.docs.first.reference;
      await docRef.update({
        'firstTime': false // or any value you wish to update it to
      }).then((_) {
        print("firstTime updated");
      }).catchError((error) {
        print("Error updating firstTime: $error");
      });
        }
        }

          @override
  void initState() {
    // TODO: implement initState
    super.initState();
    state();
  }
 

  @override
  Widget build(BuildContext context) {
    if (flag ==null) {
      return Scaffold(backgroundColor: colors.bg,);
    }else{
   
       if (_auth.currentUser!.emailVerified) {
        return GoHome(tt: flag!,isv: isV!,);
    }
    else{
    return  VerifyEmail(tt:flag! ,);
    }
    }
     
    
  }
}