import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diva/routes/route_helper.dart';
import 'package:diva/screens/auth%20screens/login_screen.dart';
import 'package:diva/screens/home/goToHome.dart';
import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class VerifyEmail extends StatefulWidget {
  final bool tt;
  const VerifyEmail({super.key,required this.tt});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerfied=false;
  Timer? timer;
  bool canResend=false;
  @override 
  void initState(){
    super.initState();
    isEmailVerfied=FirebaseAuth.instance.currentUser!.emailVerified;
    if(!isEmailVerfied){
      sendVerficationEmail();

     timer= Timer.periodic(
        const Duration(seconds: 3), 
       (_)=>chekEmailVerfied(),
        );
    }
  }
  @override
  void dispose() {
    timer?.cancel();
    // TODO: implement dispose
    super.dispose();
  }
  Future chekEmailVerfied() async{
    // call after email verfication
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerfied=FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerfied) timer?.cancel();
  }
  Future sendVerficationEmail() async{
    try {
      
    final user =FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();
    setState(() =>canResend=false);
    await Future.delayed(const Duration(seconds: 20));
    setState(() =>canResend=true);

    } catch (e) {
      print(e.toString());
      //  Get.snackbar(
      //                   "Error",
      //                   e.toString(),
      //                   backgroundColor: colors.sp,
      //                   colorText: Colors.white,
      //                   snackPosition: SnackPosition.BOTTOM,
      //                   margin: EdgeInsets.symmetric(
      //                     horizontal: Dimensitions.width10,
      //                     vertical: Dimensitions.height10,
      //                     ),
      //                   );
      
    }
  }
  @override
  Widget build(BuildContext context) => isEmailVerfied? GoHome(tt: widget.tt,isv: false,):
   Scaffold(
      backgroundColor: colors.bg,
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return Column(
            children: [
              SizedBox(height: Dimensitions.height40,),
          GestureDetector(
                      onTap: () async{
                        QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("tokens").where("uid",isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
                        await FirebaseFirestore.instance.collection("tokens").doc(snapshot.docs.first.id).delete();
                        Get.toNamed(RouteHelper.getsignIn());
                        FirebaseAuth.instance.signOut();
                      },
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
              SizedBox(width: Dimensitions.width35,),
              // Align(
              //   alignment: Alignment.center,
              //   child: ),
              Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        SizedBox(width: Dimensitions.width15,),
        Lottie.asset("assets/lottie/Animation - 1722200173009.json",height: Dimensitions.height200)]
        ),
              SizedBox(height: Dimensitions.height60,),
              Text(
                "vérifiez votre adresse e-mail",style: GoogleFonts.openSans(
                textStyle:TextStyle(
                  height: 0.6,
                  color: colors.text,
                  fontSize: Dimensitions.width20,
                  fontWeight: FontWeight.bold,
                ),
              )),
              SizedBox(height: Dimensitions.height30,),
             
          
          
          
          Text("nous vous avons envoyé un code",style: GoogleFonts.openSans(
                textStyle:TextStyle(
                  height: 1.1,
              
                  color: Colors.grey.shade700,
                  fontSize: Dimensitions.width15,
                  fontWeight: FontWeight.w500,
                ),
              ),),
              Text("temporaire pour vérifier votre",style: GoogleFonts.openSans(
                textStyle:TextStyle(
                  height: 1.1,
          
                  color: Colors.grey.shade700,
                  fontSize: Dimensitions.width15,
                  fontWeight: FontWeight.w500,
                ),
              ),),
              Text("adresse e-mail. vérifiez",style: GoogleFonts.openSans(
                textStyle:TextStyle(
                  height: 1.1,
          
                  color: Colors.grey.shade700,
                  fontSize: Dimensitions.width15,
                  fontWeight: FontWeight.w500,
                ),
              ),),
              Text("et cliquez sur le lien",style: GoogleFonts.openSans(
                textStyle:TextStyle(
                  height: 1.1,
          
                  color: Colors.grey.shade700,
                  fontSize: Dimensitions.width15,
                  fontWeight: FontWeight.w500,
                ),
              ),),
               SizedBox(height: Dimensitions.height45,),
           
          Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     GestureDetector(
                      onTap: () {
                          FirebaseAuth.instance.signOut();
                          Get.off(()=>SignIn());
                      },
                       child: Text("vous n'avez pas reçu d'e-mail ? ",
                                        style: GoogleFonts.openSans(
                                         textStyle:TextStyle(
                                           color: Colors.grey.shade800,
                                           fontWeight: FontWeight.w600,
                                           fontSize: Dimensitions.width15,
                                         ),
                                        ),
                                       ),
                     ),
                 GestureDetector(
                  onTap:canResend?sendVerficationEmail:null,
      
                   child: Text("renvoyer",
                   style: GoogleFonts.openSans(
                    textStyle:TextStyle(
                      color:canResend? colors.rose4:Colors.grey.shade800,
                      fontWeight: FontWeight.w600,
                      fontSize: Dimensitions.width15,
                    ),
                   ),
                               ),
                 ),
          
                    
                ],),
          
          
            ],
          );
        }
      ),
    );
  }
