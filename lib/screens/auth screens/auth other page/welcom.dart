import 'package:diva/routes/route_helper.dart';
import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Wellcom extends StatefulWidget {
  const Wellcom({super.key});

  @override
  State<Wellcom> createState() => _WellcomState();
}


class _WellcomState extends State<Wellcom> {
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GoToHome ();
  }
  void GoToHome () {     
   Future.delayed(
    Duration(milliseconds:2500),
    ()=> Get.offAllNamed(RouteHelper.getHome(false))
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.bg,
      body:Column(
        
        children: [
          SizedBox(height: Dimensitions.height50,),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        SizedBox(width: Dimensitions.width35,),
        Lottie.asset("assets/lottie/hand.json",height: Dimensitions.height250)]
        ),
 
          Expanded(
            child: SizedBox(
            child:
            Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: Dimensitions.height10),
                      Text(
                        "Bienvenue à",
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            height: 0.6,
                            color: colors.text,
                            fontSize: Dimensitions.width18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensitions.height20),
                      Container(
          height: Dimensitions.height40,
          
          margin: EdgeInsets.symmetric(horizontal: Dimensitions.width100),
          decoration:const  BoxDecoration(
            
            image: DecorationImage(image: AssetImage("assets/Logo/LOG.png"),fit: BoxFit.fill,
            )
          ),
        ),
                    
                    ],
                  ),
                ),
               
            
           Positioned(right: -Dimensitions.width65,bottom: 0,top: 0,child: SizedBox(
      
            child: Align(
              alignment: Alignment.bottomRight,
              child: SvgPicture.asset("assets/Logo/logo_part.svg",height: Dimensitions.height500,)),),
            ),

              ],
            ) 
          ,))
        
        ],
      )
    );
  }
}