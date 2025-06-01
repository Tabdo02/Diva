import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWelcome extends StatelessWidget {
  final String name;
  final bool isBold;
  final void Function()? onTap;
  const ButtonWelcome({super.key,required this.name,required this.onTap,this.isBold=true});

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensitions.width100),
            child: GestureDetector(
              onTap: onTap,
              child: Container(
               
                decoration: BoxDecoration(
                color: colors.sp,
                borderRadius: BorderRadius.circular(Dimensitions.width10)
              
                ),
                height: Dimensitions.height40,
               
                child: Center(
                  child: Text(
                    name,
                    style: GoogleFonts.openSans(
                      textStyle:TextStyle(
                        color: Colors.white,
                        fontWeight:isBold? FontWeight.bold:FontWeight.w500,
                        fontSize: Dimensitions.width16
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}