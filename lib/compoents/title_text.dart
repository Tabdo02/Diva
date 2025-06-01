import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTitleText extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry padding;
  const MyTitleText({super.key,required this.title, this.padding=EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    return  Padding(
          padding: padding,
          child: Text(
            overflow: TextOverflow.ellipsis,
            title,
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              color: colors.text2,
              fontWeight: FontWeight.w500,
              fontSize: Dimensitions.width20,

            )
          ),
            ),
          );
  }
}