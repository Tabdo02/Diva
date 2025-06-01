import 'package:diva/screens/auth%20screens/auth%20other%20page/welcom.dart';
import 'package:diva/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class GoHome extends StatefulWidget {
  final bool tt;
  final bool isv;
  const GoHome({super.key,required this.tt,required this.isv});

  @override
  State<GoHome> createState() => _GoHomeState();
}

class _GoHomeState extends State<GoHome> {
 
  @override
  Widget build(BuildContext context) {
      if (widget.tt) {
        return Wellcom();
      }else{
        return  Home(
          isv: widget.isv,
        );
      }
  }
  
}