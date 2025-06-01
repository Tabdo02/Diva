import 'package:diva/screens/auth%20screens/login_screen.dart';
import 'package:diva/screens/home/home_toggle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
   AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final FirebaseAuth _auth =FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
      if(_auth.currentUser !=null){
    return  HomeToggle();
    }else{
    return  SignIn();
    }
  }
}