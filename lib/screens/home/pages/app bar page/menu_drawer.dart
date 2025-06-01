import 'dart:math';
import 'package:diva/compoents/title_text.dart';
import 'package:diva/routes/route_helper.dart';
import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: Dimensitions.width210,
      decoration: BoxDecoration(
        color: colors.bg,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(Dimensitions.height10),
          bottomRight:  Radius.circular(Dimensitions.height10),
          
          ),
          boxShadow: [
             BoxShadow(
                       color:colors.text,
                        blurRadius: 4,
                        offset: Offset(0, 0)
                          ),
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
          MyTitleText(
            title: "Menu",
             padding: EdgeInsets.only(
              top:Dimensitions.height30,
              left: Dimensitions.width25,
              bottom:Dimensitions.height15,
                ),
            ),
          // contacter e wom
          GestureDetector(
            onTap: ()=>Get.toNamed(RouteHelper.contacterEwom,),
            child: Container(
              
                padding: EdgeInsets.symmetric(horizontal: Dimensitions.width25),
                
                height: Dimensitions.height45,
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/contqcter.svg",height:  Dimensitions.height23,),
                    SizedBox(width: Dimensitions.width12,),
                    Expanded(child: Text(
                      "Contacter\ne-wom",
                      style: GoogleFonts.openSans(
                        height: Dimensitions.height1,
                        color: colors.text,
                        fontWeight: FontWeight.w600,
                        fontSize: Dimensitions.width14,
                      ),
                      )),
                    Transform.rotate(
                        angle: pi/2,
                        child: SvgPicture.asset("assets/icons/taille.svg",height:  Dimensitions.height13,color: colors.sp,)),
                  ],
                ),
              ),
          ),
          // Confidentialite
          GestureDetector(
            onTap: ()=>Get.toNamed(RouteHelper.confi,),
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensitions.width25),
               
                height: Dimensitions.height30,
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/verified_user_.svg",height:  Dimensitions.height23,),
                    SizedBox(width: Dimensitions.width10,),
                    Expanded(child: Text(
                      "Confidentialité",
                      style: GoogleFonts.openSans(
                        height: Dimensitions.height1,
                        color: colors.text,
                        fontWeight: FontWeight.w600,
                        fontSize: Dimensitions.width14,
                      ),
                      )),
                    Transform.rotate(
                        angle: pi/2,
                        child: SvgPicture.asset("assets/icons/taille.svg",height:  Dimensitions.height13,color: colors.sp,)),
                  ],
                ),
              ),
 ),
          // spearator
          Container(
                      
          
                    color: colors.sp,
          
                     height: Dimensitions.height0_2,
                     width: Dimensitions.width300,
                     margin: EdgeInsets.only(top: Dimensitions.height10,bottom:Dimensitions.height10,left: Dimensitions.width35,right: Dimensitions.width35 ),
          
                    ),
          // centre d'aide
          GestureDetector(
            onTap: ()=>Get.toNamed(RouteHelper.centerAide,),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensitions.width25),
               
                height: Dimensitions.height35,
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/help_.svg",height:  Dimensitions.height23,),
                    SizedBox(width: Dimensitions.width10,),
                    Expanded(child: Text(
                      "Centre d'aide",
                      style: GoogleFonts.openSans(
                        height: Dimensitions.height1,
                        color: colors.text,
                        fontWeight: FontWeight.w600,
                        fontSize: Dimensitions.width14,
                      ),
                      )),
                    Transform.rotate(
                        angle: pi/2,
                        child: SvgPicture.asset("assets/icons/taille.svg",height:  Dimensitions.height13,color: colors.sp,)),
                  ],
                ),
              ),
),
          // mon qr code
          GestureDetector(
            onTap: ()=>Get.toNamed(RouteHelper.monQr,),
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensitions.width25),
               
                height: Dimensitions.height35,
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/qr.svg",height:  Dimensitions.height23,),
                    SizedBox(width: Dimensitions.width10,),
                    Expanded(child: Text(
                      "Mon QR code",
                      style: GoogleFonts.openSans(
                        height: Dimensitions.height1,
                        color: colors.text,
                        fontWeight: FontWeight.w600,
                        fontSize: Dimensitions.width14,
                      ),
                      )),
                    Transform.rotate(
                        angle: pi/2,
                        child: SvgPicture.asset("assets/icons/taille.svg",height:  Dimensitions.height13,color: colors.sp,)),
                  ],
                ),
              ),
 ),
         // disconnect
          GestureDetector(
           onTap: () {
              showDialog(
      
                context: context, 
                builder: (context) {
                  return AlertDialog(
                    
                  contentPadding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    content: Container(
                      margin: EdgeInsets.symmetric(horizontal: Dimensitions.width10),
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensitions.width10,
                        vertical: Dimensitions.height15,
                      ),
                    height: Dimensitions.height130,
                   // width: Dimensitions.width50,
                    decoration: BoxDecoration(
                    color: colors.bg,
                    border: Border.all(color: colors.text2,width: 2),
                    borderRadius: BorderRadius.circular(Dimensitions.height10),
                      
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: Dimensitions.height5,
                            
                          ),
                          child: Text(
                            "Vous etes sur?",
                            textAlign: TextAlign.center,
                                  style: GoogleFonts.openSans(
                                    fontSize: Dimensitions.width14,
                                    color:colors.text2,
                                    fontWeight: FontWeight.w600,
                                
                                  ),
                          ),
                          ),
                        Row(
                          children: [
                            Expanded(
                              child: 
                              GestureDetector(
                                onTap: () {
                                     FirebaseAuth.instance.signOut();
                                     GoogleSignIn().signOut();
                                     Get.offAllNamed(RouteHelper.signIn);
                                },
                                child: Text(
                                  
                                  "Déconnexion",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.openSans(
                                    fontSize: Dimensitions.width14,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600,
                                
                                  ),
                                  ),
                              )
                              ),
                            Container(
                              width:0.5,
                              height: Dimensitions.height20,
                              color: colors.text3,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => Get.back(),
                                child: Text(
                                    
                                    "rester",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.openSans(
                                      fontSize: Dimensitions.width14,
                                      color: colors.rose7,
                                      fontWeight: FontWeight.w600,
                                
                                    ),
                                    ),
                              ),
                            )
                        
                          ],
                        ),
                      ],
                    ),
      
                  ),
                  );
                },
                );
                       
                       },
             
   child: Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensitions.width25),
               
                height: Dimensitions.height35,
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/login_.svg",height:  Dimensitions.height23,),
                    SizedBox(width: Dimensitions.width10,),
                    Expanded(child: Text(
                      "Déconnexion",
                      style: GoogleFonts.openSans(
                        height: Dimensitions.height1,
                        color: colors.text,
                        fontWeight: FontWeight.w600,
                        fontSize: Dimensitions.width14,
                      ),
                      )),
                    Transform.rotate(
                        angle: pi/2,
                        child: SvgPicture.asset("assets/icons/taille.svg",height:  Dimensitions.height13,color: colors.sp,)),
                  ],
                ),
              ),
 ),
 
        ],
      ),
    );
    
  }
}