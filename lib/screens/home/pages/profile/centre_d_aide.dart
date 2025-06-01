import 'package:diva/compoents/home/app_bar.dart';
import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/big_strings.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CentreDaide extends StatelessWidget {
  const CentreDaide({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:MyAppBar(
        tit: "Centre d'aide",
        fn:true,
        ),
      backgroundColor: colors.bg,
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: Dimensitions.width25),
        child: Column(
          children: [
         SizedBox(height: Dimensitions.height15,),

           Align(
            alignment: Alignment.center,
             child: Text(
              "Assistance téléphonique",
              style: GoogleFonts.openSans(
                color: colors.text,
                fontSize: Dimensitions.width13,
                fontWeight: FontWeight.w600,
              ),
              ),
           )
         , 
         SizedBox(height: Dimensitions.height5,),
         Align(
            alignment: Alignment.topLeft,
             child: Text(
              BigStrings.ca1,
              style: GoogleFonts.openSans(
                color: colors.text,
                fontSize: Dimensitions.width13,
                fontWeight: FontWeight.w600,
              ),
              ),
           )
          ,
         SizedBox(height: Dimensitions.height15,),
          
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensitions.width10),
            child: Column(
           
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "1.Navigation dans l'application: ",
                          style: GoogleFonts.openSans(
                            fontStyle: FontStyle.italic,
                            color: colors.text,
                            fontSize: Dimensitions.width13,
                            fontWeight: FontWeight.w500,
                          )
                        ),
                        TextSpan(
                          text: BigStrings.ca2,
                          style: GoogleFonts.openSans(
                            color: colors.text,
                            fontSize: Dimensitions.width13,
                            fontWeight: FontWeight.normal,
                          )
                        ),
                      ]
                    )
                    ),
                ),

              ],
            ),
            ),
          
           SizedBox(height: Dimensitions.height15,),
          
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensitions.width10),
            child: Column(
           
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "2.Problémes techniques: ",
                          style: GoogleFonts.openSans(
                            fontStyle: FontStyle.italic,
                            color: colors.text,
                            fontSize: Dimensitions.width13,
                            fontWeight: FontWeight.w500,
                          )
                        ),
                        TextSpan(
                          text: BigStrings.ca3,
                          style: GoogleFonts.openSans(
                            color: colors.text,
                            fontSize: Dimensitions.width13,
                            fontWeight: FontWeight.normal,
                          )
                        ),
                      ]
                    )
                    ),
                ),

              ],
            ),
            ),
           SizedBox(height: Dimensitions.height15,),
          
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensitions.width10),
            child: Column(
           
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "3.Assistance sur les fonctionnalités: ",
                          style: GoogleFonts.openSans(
                            fontStyle: FontStyle.italic,
                            color: colors.text,
                            fontSize: Dimensitions.width13,
                            fontWeight: FontWeight.w500,
                          )
                        ),
                        TextSpan(
                          text: BigStrings.ca4,
                          style: GoogleFonts.openSans(
                            color: colors.text,
                            fontSize: Dimensitions.width13,
                            fontWeight: FontWeight.normal,
                          )
                        ),
                      ]
                    )
                    ),
                ),

              ],
            ),
            ),
          
          ],
        ),
      ),
    );
  }
}