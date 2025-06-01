import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diva/compoents/title_text.dart';
import 'package:diva/provider/account/user_provider.dart';
import 'package:diva/routes/route_helper.dart';
import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DeveirPurchase extends StatefulWidget {
  final String docId;
  final String usDocId;

  final String mode;
  const DeveirPurchase({super.key,required this.mode,required this.docId,required this.usDocId});

  @override
  State<DeveirPurchase> createState() => _DeveirPurchaseState();
}

class _DeveirPurchaseState extends State<DeveirPurchase> {
  final _controller2 = PageController();
  List<List<String>> titles=[["Basic","premium_g471-0"],["Premium","premium_g261-0"]];

  
  Map<String,List<String>> price={
    "B2C":["3000","28 000"],
    "B2B":["5000","58 000"],
  };
  int _currentPageIndex = 0;
  @override
  void initState() {
    super.initState();
    _controller2.addListener(_handlePageChange);
  }
  @override
  void dispose() {
    _controller2.removeListener(_handlePageChange);
    _controller2.dispose();
    super.dispose();
  }

  void _handlePageChange() {
    setState(() {
      _currentPageIndex = _controller2.page!.toInt();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.bg,
      body: Stack(
        children: [
          Container(
            height: Dimensitions.height400,
            width: double.maxFinite,
            decoration: BoxDecoration(
              gradient: 
          LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          
            colors: [
                     
             
                colors.roseg.withOpacity(0.0),
                colors.roseg.withOpacity(0.2),
                colors.roseg.withOpacity(0.4),
                colors.roseg.withOpacity(0.8),



                colors.roseg.withOpacity(0.9),
                colors.roseg,


],
stops: [
 0.37,
 0.47,
 0.57,
 0.67,
 0.77,





  1.0
                    ],
            )
            ),
             child:Padding(
          padding:  EdgeInsets.only(top: Dimensitions.height20,left: Dimensitions.width25,right: Dimensitions.width25 ),
          child: Column(
            children: [
              Container(
                height: Dimensitions.height40,
                child: Stack(
                  children: [
                     Align(
                      alignment: Alignment.centerLeft,
                       child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                                           
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
                            
                ],),
                ),
             
              
             Container(
           
             
              height: Dimensitions.height320,
           
              child: Stack(
                children: [
                  PageView.builder(
                controller: _controller2,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: AnimatedContainer(
                                          duration: Duration(milliseconds: 150), 
                                          height:  Dimensitions.height240,
                                          width:Dimensitions.width230,
                                          child: 
                                             SvgPicture.asset(
                                              "assets/images/${titles[index][1]}.svg",
                                              fit:index==0? BoxFit.fill:BoxFit.contain,
                                              ),
                                        ),
                                        ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child:
                                   MyTitleText(
                                        title: titles[index][0],
                                   )),
                                    ],
                                     );
                                   },
                ),
                 Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding:  EdgeInsets.only(top: Dimensitions.height50),
                    child: SmoothPageIndicator(   
                                     controller: _controller2,
                                     count: 2,
                                     effect: CustomizableEffect(
                                      spacing: Dimensitions.width10,
                                      dotDecoration: 
                                      DotDecoration(
                                       borderRadius: BorderRadius.circular(Dimensitions.height30),
                                       height: Dimensitions.height4,
                                       width: Dimensitions.height4,
                                       color: colors.text,
                                      ), 
                                      activeDotDecoration: DotDecoration(
                                       borderRadius: BorderRadius.circular(Dimensitions.height30),
                                       height: Dimensitions.height8,
                                       width: Dimensitions.height8,
                                       color: colors.text,
                                      ), 
                                      ),
                               ),
                  ),
                  
                ),
             
                ],
              ),
              
             ),
               

            ],
          ),
        )
          
          ),
            DraggableScrollableSheet(
       
      initialChildSize: 0.41,
      maxChildSize: 0.41,
      minChildSize: 0.41,
        builder: (BuildContext context,ScrollController scrollController) {

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensitions.height15),
              topRight: Radius.circular(Dimensitions.height15),
            ),
            boxShadow: [
              BoxShadow(
                color: colors.shadow.withOpacity(0.25),
                blurRadius: 10,
                offset: Offset(0, -5)
              )
            ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                    alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(top: Dimensitions.height15,bottom: Dimensitions.height30),
                    height: Dimensitions.height3,
                    width: Dimensitions.width65,
                    decoration: BoxDecoration(
                      color: colors.shadow.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(Dimensitions.height10)
                    ),
                  
                  ),
                ),
              // price
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensitions.width25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyTitleText(title: "Abonnement ${_currentPageIndex==0 ?"mensuel":"annuelle"}"),
                      Text(
                        "${price[widget.mode]![_currentPageIndex]} DA",
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w500,
                          color: colors.text2,
                          fontSize: Dimensitions.width17
                        ),
                        )
                    ],
                  ),
                ),
            SizedBox(height: Dimensitions.height15,),
            Padding(
              padding:  EdgeInsets.only(left: Dimensitions.width25),
              child: Text(
                  "des information sur l'abonnement",
                  style: GoogleFonts.openSans(
                    color: colors.text2,
                    fontSize: Dimensitions.width13,
                    fontWeight: FontWeight.w400,
                  ),
                  ),
            )  
            ,
            
            SizedBox(height: Dimensitions.height5,),
             Padding(
              padding:  EdgeInsets.only(left: Dimensitions.width25),
              child: Text(
                  "Création de profil Attractive",
                  style: GoogleFonts.openSans(
                    color: colors.text2,
                    fontSize: Dimensitions.width13,
                    fontWeight: FontWeight.w400,
                  ),
                  ),
            )  
            ,
              Padding(
              padding:  EdgeInsets.only(left: Dimensitions.width25),
              child: Text(
                  "Partage de photos et vidéos",
                  style: GoogleFonts.openSans(
                    color: colors.text2,
                    fontSize: Dimensitions.width13,
                    fontWeight: FontWeight.w400,
                  ),
                  ),
            )  
            ,
             

            Align(
                alignment: Alignment.center,
              child: GestureDetector(
                onTap: () async{
                  await FirebaseFirestore.instance.collection("boutiques").doc(widget.docId).update(
                    {
                      'offre':{
                        'time':_currentPageIndex==0 ?"mensuel":"annuelle",
                        'pricing':price[widget.mode]![_currentPageIndex],
                        'date':Timestamp.now(), 
                      }
                    }
                  );
                  Provider.of<userProvider>(context,listen: false).fetchboutique(widget.usDocId, FirebaseAuth.instance.currentUser!.uid);
                  Provider.of<userProvider>(context,listen: false).offreStart();
                  Get.offAllNamed(RouteHelper.getinitial(),);
                },
                child: Container(
                          margin: EdgeInsets.only(top: Dimensitions.height30),
                          width: Dimensitions.width110,
                          height: Dimensitions.height30,
                          decoration: BoxDecoration(
                            color: colors.rose3,
                            borderRadius: BorderRadius.circular(Dimensitions.height10),
                  boxShadow: [
                                BoxShadow(
                               color:colors.rose5.withOpacity(0.9),
                                blurRadius: 4,
                                offset: Offset(0, 0)
                                  ),
                              ],     
                            
                          ),
                          child: Center(
                            child: Text("Acheter!",style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: Dimensitions.width12,
                              fontWeight: FontWeight.bold
                              
                            ),),
                          ),
                        ),
              ),
            ),
            
            ],
          ),
        );
        }
      )
        ],
      ),
    );
  }
}