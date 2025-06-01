import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
      return  Column(
      children: [
        SizedBox(height: Dimensitions.height80,),
        // image 
       
             Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensitions.width60),
            child: SvgPicture.asset("assets/images/People_g548-2-2.svg",height: Dimensitions.height200,)),
        SizedBox(height: Dimensitions.height60,),


        // title text
        Text("C'est",style: GoogleFonts.openSans(
          textStyle:TextStyle(
            color: colors.sp,
            fontSize: Dimensitions.width16,
            fontWeight: FontWeight.w300,
          ),
        ),),
        Text(
          "Simple,",style: GoogleFonts.openSans(
          textStyle:TextStyle(
            height: 0.6,
            color: colors.sp,
            fontSize: Dimensitions.width30,
            fontWeight: FontWeight.bold,
          ),
        )),
        SizedBox(height: Dimensitions.height55,),
       



    Text("Rejoignez nous et",style: GoogleFonts.openSans(
          textStyle:TextStyle(
            height: 1.1,
        
            color: Colors.grey.shade700,
            fontSize: Dimensitions.width15,
            fontWeight: FontWeight.w500,
          ),
        ),),
        Text("commencez dès maintenant",style: GoogleFonts.openSans(
          textStyle:TextStyle(
            height: 1.1,

            color: Colors.grey.shade700,
            fontSize: Dimensitions.width15,
            fontWeight: FontWeight.w500,
          ),
        ),),
        Text("vôtre exploration.",style: GoogleFonts.openSans(
          textStyle:TextStyle(
            height: 1.1,

            color: Colors.grey.shade700,
            fontSize: Dimensitions.width15,
            fontWeight: FontWeight.w500,
          ),
        ),),
        // Text("où confiance, soin, et luxe se",style: GoogleFonts.openSans(
        //   textStyle:TextStyle(
        //     height: 1.1,

        //     color: Colors.grey.shade700,
        //     fontSize: Dimensitions.width15,
        //     fontWeight: FontWeight.w500,
        //   ),
        // ),),Text("rencontrent",style: GoogleFonts.openSans(
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