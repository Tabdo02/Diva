import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  
    Container(
      
            height: Dimensitions.height50,
            margin: EdgeInsets.only(left: Dimensitions.width25,right: Dimensitions.width25,top: Dimensitions.height30,bottom:  Dimensitions.height20,),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimensitions.height10),
             boxShadow: [
       BoxShadow(
          
          color: colors.shadow.withOpacity(0.11),
          blurRadius: 8,
          offset: Offset(0, 0)
        ),
      ]
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: Dimensitions.width10),
                    child: Text(
                      "Recherche...",
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            color: colors.purpel5,
                            fontSize: Dimensitions.width18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                  ),
                 
                 
                  ),
                  
                Container(
                  margin: EdgeInsets.only(left: Dimensitions.width8),
                  width: Dimensitions.width50,
                  decoration: BoxDecoration(
                  color: colors.purpel3,
                  borderRadius: BorderRadius.circular(Dimensitions.height10),
                  
                  ),
                  child: Center(
                      child: SvgPicture.asset(

                        "assets/icons/magnifier_search_zoom_i (1).svg",
                        height: Dimensitions.height25,
                        color: Colors.white,),
                   
                    
                  ),
                )
              ],
            ),
          )
         
          ;
  }
}