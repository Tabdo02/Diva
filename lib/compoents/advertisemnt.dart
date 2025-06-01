import 'package:cached_network_image/cached_network_image.dart';
import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Advertisemnt extends StatelessWidget {
  final List<String> pubs;
  final PageController controller;
  const Advertisemnt({super.key,required this.pubs,required this.controller});

  @override
  Widget build(BuildContext context) {
    return  Container(
          margin: EdgeInsets.only(left: Dimensitions.width25,right: Dimensitions.width25,top: Dimensitions.height10,bottom:Dimensitions.height25, ),
          height: Dimensitions.height170,
         decoration: BoxDecoration(
          border: Border.all(color: colors.sp,width: 2),
          borderRadius: BorderRadius.circular(Dimensitions.height3),
          
         ),
         child: Stack(
          children: [
            PageView.builder(
              
              controller: controller,
          itemCount: pubs.length,
          itemBuilder: (context, index) {
           
            return Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
            image: DecorationImage(
            image: CachedNetworkImageProvider(pubs[index]),
            fit: BoxFit.fill
            ),
              ),
             
            );
          },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: Dimensitions.height30,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: colors.sp.withOpacity(0.7),
                    blurRadius: 14,
                    offset: Offset(0, 0)
                  )
                ],
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                      colors.sp.withOpacity(0.1),

                      colors.sp.withOpacity(0.39),
                      

                      colors.sp,
],
                          stops: [
                      

                            0.4,
                           0.5,
                            1.0
                                              ]
                  )
              ),
           child:  Padding(
             padding:  EdgeInsets.only(right: Dimensitions.width8),
             child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: Dimensitions.width20,),
                  Expanded(
                    child: Center(
                    child: SmoothPageIndicator(
                                    
                                    controller: controller,
                                    count: pubs.length,
                                   effect: CustomizableEffect(
                                    spacing: Dimensitions.width15,
                                    dotDecoration: 
                                    DotDecoration(
                                     borderRadius: BorderRadius.circular(Dimensitions.height30),
                                     height: Dimensitions.height7,
                                     width: Dimensitions.height7,
                                    
                                    color: Colors.transparent,
                                     dotBorder: DotBorder(
                      width: 1.3,
                      color: Colors.white,
                                     )
                                    ), 
                                    activeDotDecoration: DotDecoration(
                                     borderRadius: BorderRadius.circular(Dimensitions.height30),
                      height: Dimensitions.height10,
                      width: Dimensitions.height10,
                      color: Colors.white,
                                    ), 
                                    ),
                             ),
                    
                    ),
                  ),
             
                     SvgPicture.asset("assets/icons/heart-add.svg",height: Dimensitions.height20,color: Colors.white,),
             
             
              ],
             ),
           )
            ),
          ),
          ],
         )
         )
         ;
  }
}