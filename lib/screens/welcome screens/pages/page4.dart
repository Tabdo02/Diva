import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';

class FourthPage extends StatelessWidget {
  const FourthPage({super.key});

  @override
  Widget build(BuildContext context) {
  return  Column(
      children: [
        SizedBox(height: Dimensitions.height80,),
        // image 
       
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensitions.width60),
            child: SvgPicture.asset("assets/images/People_g503-5-5.svg",height: Dimensitions.height200,)),
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
          "Recherche,",style: GoogleFonts.openSans(
          textStyle:TextStyle(
            height: 0.6,
            color: colors.sp,
            fontSize: Dimensitions.width30,
            fontWeight: FontWeight.bold,
          ),
        )),
        SizedBox(height: Dimensitions.height55,),
       




    Text("vous cherchez quelque chose de",style: GoogleFonts.openSans(
          textStyle:TextStyle(
            height: 1.1,
        
            color: Colors.grey.shade700,
            fontSize: Dimensitions.width15,
            fontWeight: FontWeight.w500,
          ),
        ),),
        Text("spécial ? Ne vous inquiétez pas ,",style: GoogleFonts.openSans(
          textStyle:TextStyle(
            height: 1.1,

            color: Colors.grey.shade700,
            fontSize: Dimensitions.width15,
            fontWeight: FontWeight.w500,
          ),
        ),),
        Text("nous vous mettons en contact avec",style: GoogleFonts.openSans(
          textStyle:TextStyle(
            height: 1.1,

            color: Colors.grey.shade700,
            fontSize: Dimensitions.width15,
            fontWeight: FontWeight.w500,
          ),
        ),),
        Text("les meilleures vendeuses du secteur",style: GoogleFonts.openSans(
          textStyle:TextStyle(
            height: 1.1,

            color: Colors.grey.shade700,
            fontSize: Dimensitions.width15,
            fontWeight: FontWeight.w500,
          ),
        ),),Text("pour répondre à vos besoins.",style: GoogleFonts.openSans(
          textStyle:TextStyle(
            height: 1.1,
            color: Colors.grey.shade700,
            fontSize: Dimensitions.width15,
            fontWeight: FontWeight.w500,
          ),
        ),),
        // Text("vendeurs du secteur.",style: GoogleFonts.openSans(
        //   textStyle:TextStyle(
        //     height: 1.1,
        //     color: Colors.grey.shade700,
        //     fontSize: Dimensitions.width15,
        //     fontWeight: FontWeight.w500,
        //   ),
        // ),),
         
 



      ],
    );
  }
}