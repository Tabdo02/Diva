import 'dart:math';

import 'package:diva/auth_Firestor/users.dart';
import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPassword extends StatefulWidget {
  final String email;

  const ResetPassword({super.key,required this.email});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool canReset= true;
  void updateReset() async{
    setState(() =>canReset=false);
    // change the email
    AuthFirestore().resetPassword(widget.email, context,true);
    Get.back();
    await Future.delayed(const Duration(seconds: 15));
    setState(() =>canReset=true);
  }
  void jjj () async{
    setState(() =>canReset=false);
    await Future.delayed(const Duration(seconds: 15));
    setState(() =>canReset=true);
  }
  @override
 void initState() {
    // TODO: implement initState
    super.initState();
    jjj ();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: colors.bg,
      body: Column(
        children: [
          SizedBox(height: Dimensitions.height40,),
          GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: Dimensitions.width25),
                          padding: EdgeInsets.all(Dimensitions.height10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                           color:colors.shadow.withOpacity(0.18),
                            blurRadius: 4,
                            offset: Offset(0, 0)
                              ),
                          ],     
                          ),
                          child: Transform.rotate(
                          angle: -pi/2,
                          child: SvgPicture.asset("assets/icons/taille.svg",height:  Dimensitions.height10,color: colors.sp,)),
                        ),
                      ),
                    ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensitions.width26),
            child: SvgPicture.asset("assets/images/inbox_.svg",height: Dimensitions.height250,)),
          SizedBox(height: Dimensitions.height60,),
          Text(
            "Mot de passe oublié?",style: GoogleFonts.openSans(
            textStyle:TextStyle(
              height: 0.6,
              color: colors.text,
              fontSize: Dimensitions.width20,
              fontWeight: FontWeight.bold,
            ),
          )),
          SizedBox(height: Dimensitions.height30,),
         
      
      
      
      
      Text("Nous avons bien envoyé un e-mail pour",style: GoogleFonts.openSans(
            textStyle:TextStyle(
              height: 1.1,
          
              color: Colors.grey.shade700,
              fontSize: Dimensitions.width15,
              fontWeight: FontWeight.w500,
            ),
          ),),
          Text("réinitialiser votre mot de passe.",style: GoogleFonts.openSans(
            textStyle:TextStyle(
              height: 1.1,
      
              color: Colors.grey.shade700,
              fontSize: Dimensitions.width15,
              fontWeight: FontWeight.w500,
            ),
          ),),
          Text("Veuillez vérifier votre boîte",style: GoogleFonts.openSans(
            textStyle:TextStyle(
              height: 1.1,
      
              color: Colors.grey.shade700,
              fontSize: Dimensitions.width15,
              fontWeight: FontWeight.w500,
            ),
          ),),
          Text("de réception.",style: GoogleFonts.openSans(
            textStyle:TextStyle(
              height: 1.1,
      
              color: Colors.grey.shade700,
              fontSize: Dimensitions.width15,
              fontWeight: FontWeight.w500,
            ),
          ),),
          
           SizedBox(height: Dimensitions.height90,),
       
      Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text("vous n'avez pas reçu d'e-mail ? ",
             style: GoogleFonts.openSans(
              textStyle:TextStyle(
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w600,
                fontSize: Dimensitions.width15,
              ),
             ),
            ),
             GestureDetector(
              onTap: canReset?updateReset:null,
               child: Text("renvoyer",
               style: GoogleFonts.openSans(
                textStyle:TextStyle(
                  color:canReset ? colors.rose4:Colors.grey.shade800,
                  fontWeight: FontWeight.w600,
                  fontSize: Dimensitions.width15,
                ),
               ),
                ),
             ),

                
            ],),
      
      
        ],
      ),
    );
  }
}