import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
     return Column(
      children: [
        SizedBox(height: Dimensitions.height80,),
        
         Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensitions.width60),
            child: SvgPicture.asset("assets/images/People_g382-6-1.svg",height: Dimensitions.height200,)),
        SizedBox(height: Dimensitions.height60,),

        // title text
        Text("Welcom to",style: GoogleFonts.openSans(
          textStyle:TextStyle(
            color: colors.sp,
            fontSize: Dimensitions.width16,
            fontWeight: FontWeight.w300,
          ),
        ),),
       
        Container(
          height: Dimensitions.height40,
          
          margin: EdgeInsets.symmetric(horizontal: Dimensitions.width120),
          decoration:const  BoxDecoration(
            
            image: DecorationImage(image: AssetImage("assets/Logo/LOG.png"),fit: BoxFit.fill,
            )
          ),
        ),
        SizedBox(height: Dimensitions.height35,),
    Text("Nous sommes ravis de vous",style: GoogleFonts.openSans(
          textStyle:TextStyle(
            height: 1.1,
        
            color: Colors.grey.shade700,
            fontSize: Dimensitions.width15,
            fontWeight: FontWeight.w500,
          ),
        ),),
        Text("accueillir nôtre communauté",style: GoogleFonts.openSans(
          textStyle:TextStyle(
            height: 1.1,

            color: Colors.grey.shade700,
            fontSize: Dimensitions.width15,
            fontWeight: FontWeight.w500,
          ),
        ),),
        Text("Chez Ewom , nous croyons à",style: GoogleFonts.openSans(
          textStyle:TextStyle(
            height: 1.1,

            color: Colors.grey.shade700,
            fontSize: Dimensitions.width15,
            fontWeight: FontWeight.w500,
          ),
        ),),
        Text("l’immense potentiel des femmes",style: GoogleFonts.openSans(
          textStyle:TextStyle(
            height: 1.1,

            color: Colors.grey.shade700,
            fontSize: Dimensitions.width15,
            fontWeight: FontWeight.w500,
          ),
        ),),Text("entrepreneures Algérienne.",style: GoogleFonts.openSans(
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