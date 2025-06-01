import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';

class TherdPage extends StatelessWidget {
  const TherdPage({super.key});

  @override
  Widget build(BuildContext context) {
     return Column(
      children: [
        SizedBox(height: Dimensitions.height80,),
     
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensitions.width60),
            child: SvgPicture.asset("assets/images/People_g435-8-7.svg",height: Dimensitions.height200,)),
        SizedBox(height: Dimensitions.height60,),
      

        // title text
        Text("Vous",style: GoogleFonts.openSans(
          textStyle:TextStyle(
            color: colors.sp,
            fontSize: Dimensitions.width16,
            fontWeight: FontWeight.w300,
          ),
        ),),
        Text(
          "Découvrez",style: GoogleFonts.openSans(
          textStyle:TextStyle(
            height: 0.6,
            color: colors.sp,
            fontSize: Dimensitions.width30,
            fontWeight: FontWeight.bold,
          ),
        )),
        SizedBox(height: Dimensitions.height55,),
    Text("Explorez notre sélection",style: GoogleFonts.openSans(
          textStyle:TextStyle(
            height: 1.1,
        
            color: Colors.grey.shade700,
            fontSize: Dimensitions.width15,
            fontWeight: FontWeight.w500,
          ),
        ),),
        Text("soigneusement choisie de",style: GoogleFonts.openSans(
          textStyle:TextStyle(
            height: 1.1,

            color: Colors.grey.shade700,
            fontSize: Dimensitions.width15,
            fontWeight: FontWeight.w500,
          ),
        ),),
        Text("produits haut de gamme et",style: GoogleFonts.openSans(
          textStyle:TextStyle(
            height: 1.1,

            color: Colors.grey.shade700,
            fontSize: Dimensitions.width15,
            fontWeight: FontWeight.w500,
          ),
        ),),
        Text("luxueux, allant de la joaillerie aux",style: GoogleFonts.openSans(
          textStyle:TextStyle(
            height: 1.1,

            color: Colors.grey.shade700,
            fontSize: Dimensitions.width15,
            fontWeight: FontWeight.w500,
          ),
        ),),Text("pièces de mode exclusives.",style: GoogleFonts.openSans(
          textStyle:TextStyle(
            height: 1.1,
            color: Colors.grey.shade700,
            fontSize: Dimensitions.width15,
            fontWeight: FontWeight.w500,
          ),
        ),),
        
         
 



      ],
    );
  }
}