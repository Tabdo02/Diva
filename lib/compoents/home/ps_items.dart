import 'package:diva/routes/route_helper.dart';
import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PsItems extends StatelessWidget {
  final  List<Color> mcolors;
  final List<double>? stops;
  final String imagePS;
  final String namePS;
  final List<dynamic> scte;

  const PsItems({
    super.key,
    required this.imagePS,
    required this.mcolors,
    required this.stops,
    required this.namePS,
    required this.scte,
    });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
       
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap:()=>Get.toNamed(RouteHelper.getSousCate(namePS,scte),id: 1,),
              child: Container(
                padding: EdgeInsets.only(bottom: Dimensitions.height3),
                      height: Dimensitions.height125,
                      margin: EdgeInsets.only(left: Dimensitions.width5,right:Dimensitions.width5),
                      decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Dimensitions.height10),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors:mcolors
                        ,stops: stops,
                        ),
                      boxShadow: [
                   BoxShadow(
                color: colors.shadow.withOpacity(0.2),
                         blurRadius: 2,
                        offset: Offset(1, -2)
                      ),
                      
                      
                      ]
              
                      ),
                      width: Dimensitions.width90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: Dimensitions.height5,right: Dimensitions.width5,left: Dimensitions.width5,),
                            height: Dimensitions.height80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(imagePS,),
                                fit: BoxFit.scaleDown
                            
                                )
                            ),
                          
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            namePS,
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: Dimensitions.width11,
                              fontWeight: FontWeight.w500
                            ),
                            )
                            ),
              
                        ],
                      ),
                    ),
            ),
          ),
  
      ],
    );
  
  }
}