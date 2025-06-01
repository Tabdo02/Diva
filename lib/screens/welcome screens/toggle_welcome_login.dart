import 'package:diva/provider/account/user_provider.dart';
import 'package:diva/screens/auth%20screens/auth.dart';
import 'package:diva/screens/welcome%20screens/welcom_page.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class ToggleWelcomeLogin extends StatefulWidget {
  const ToggleWelcomeLogin({super.key});

  @override
  State<ToggleWelcomeLogin> createState() => _ToggleWelcomeLoginState();
}

class _ToggleWelcomeLoginState extends State<ToggleWelcomeLogin> {
  final _myBox=Hive.box('FirstTime');
  void writeData(){
    _myBox.put(1, true);
  }
  bool readData(){
    if(_myBox.get(1)== null){
      return false;
    }
    //print(_myBox.get(1));
    return _myBox.get(1);
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<userProvider>(
      
      builder: (context, value, child) {
        value.RanaMlah();
        return
        value.isGood
        ?readData()?AuthPage():WelcomePage()
        :Scaffold(
          backgroundColor: colors.bg,
        );
      },
      );
    // if(readData()){
    //   // here the auth page
    // return  AuthPage();

    // }else{
    // return  WelcomePage();

    // }
  }
}