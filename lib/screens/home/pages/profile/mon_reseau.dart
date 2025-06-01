import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diva/class/boutique.dart';
import 'package:diva/compoents/home/app_bar.dart';
import 'package:diva/provider/account/user_provider.dart';
import 'package:diva/routes/route_helper.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:diva/utils/Dimensions.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MonReseau extends StatelessWidget {
  const MonReseau({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar:MyAppBar(
      tit: "Mon réseau",
      fn:true,
      ),
    backgroundColor: colors.bg,
    body: Consumer<userProvider>(
      builder: (context, us, child) {
        return  SingleChildScrollView(
      child: Column(
        children: [
           SizedBox(height:  us.boutique !=null?Dimensitions.height20:0,),
          us.boutique !=null?  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: Dimensitions.width25,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                      "Afficher par",
                      style: GoogleFonts.openSans(
                        color: colors.text,
                        fontSize: Dimensitions.width14,
                        fontWeight: FontWeight.w600,
                      ),
                      ),
                ),
             IndexedStack(
             index: us.socialIndex,
             children: [
                    
                           GestureDetector(
                            onTap: ()=>us.updateMysocialIndex(1),
                             child: Container(
                              margin: EdgeInsets.only(left: Dimensitions.width15),
                               padding: EdgeInsets.symmetric(vertical: Dimensitions.height2,horizontal: Dimensitions.width8),
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(Dimensitions.height5),
                                 border: Border.all(color: colors.purpel1,)
                               ),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Text(
                                     us.socialValue,
                                     style: GoogleFonts.openSans(
                                       color: colors.purpel3,
                                       fontWeight: FontWeight.w300,
                                       fontSize: Dimensitions.width13
                                     ),
                                     ),
                                   SizedBox(width: Dimensitions.width3,),
                                   
                                   SvgPicture.asset("assets/icons/down-arrow.svg",color: colors.purpel3,height: Dimensitions.height17,),
                                 ],
                               ),
                             ),
                           ),
                            Container(
                 height: Dimensitions.height45,
                            margin: EdgeInsets.only(left: Dimensitions.width15),
                             padding: EdgeInsets.symmetric(vertical: Dimensitions.height2,horizontal: Dimensitions.width8),
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(Dimensitions.height5),
                               border: Border.all(color: colors.purpel1,),
                             ),
                             child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 GestureDetector(
                                  onTap: () {
                                    us.updateMysocialValue("Abonnées");
                                    us.updateMysocialIndex(0);
                                  },
                                   child: Text(
                                                                        "Abonnées",
                                                                        style: GoogleFonts.openSans(
                                   color: colors.purpel3,
                                   fontWeight: FontWeight.w300,
                                   fontSize: Dimensitions.width13
                                                                        ),
                                                                        
                                                                        ),
                                 ),
                                                                     // SizedBox(height: Dimensitions.height3,),
                                 GestureDetector(
                                  onTap: () {
                                    us.updateMysocialValue("Abonnement");
                                    us.updateMysocialIndex(0);
                                  },
                                   child: Text(
                                                                        "Abonnement",
                                                                        style: GoogleFonts.openSans(
                                   color: colors.purpel3,
                                   fontWeight: FontWeight.w300,
                                   fontSize: Dimensitions.width13
                                                                        ),
                                                                        ),
                                 ),
                               ],
                             ),
                           ).animate(delay: Duration(milliseconds: 130)).fade(),
                   
             
             ],
                          ),   
              ],
            ):SizedBox(),
           
            SizedBox(height: Dimensitions.height25,),
            
        us.boutique == null ?
         Column(
                  children: us.followingList!.map((e) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: Dimensitions.height20, ),
                      child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async{
                  DocumentSnapshot snap=  await FirebaseFirestore.instance.collection("boutiques").doc(e.bid).get();
                  Provider.of<userProvider>(context,listen: false).getOtherFollowers(e.bid);
                            Provider.of<userProvider>(context,listen: false).getOtherFollowing(snap["docId"]);
                              List<dynamic> dynamicList = snap["liens"];
          List<dynamic> sanitizedLiens = dynamicList.map((url) => url.replaceAll('&', '%26')).toList();
                          Get.toNamed(
                          RouteHelper.getBoutiqueProfile(
                            Boutique(
                              owner: false,
                              docId: snap.id, 
                              bio: snap["bio"], 
                              category: snap["category"], 
                              usDocID: snap["docId"], 
                              liens: sanitizedLiens, 
                              name: snap["name"], 
                              phone: snap["phone"], 
                              profilPicture: snap["profileImage"].toString().replaceAll('&', '%26'), 
                              sCategory: snap["sCate"], 
                              ville: snap["ville"], 
                              followers: snap["followers"], 
                              following: snap["following"]
                              )
                          ));
                  },
                  child: Row(
                    children: [
                      Container(
                        height: Dimensitions.height30,
                        width: Dimensitions.width30,
                        margin: EdgeInsets.only(left: Dimensitions.width25,right: Dimensitions.width10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: e.imageB==""?
                          DecorationImage(image: AssetImage("assets/images/img.png"),fit: BoxFit.cover):
                          DecorationImage(image: NetworkImage(e.imageB),fit: BoxFit.cover),
                         boxShadow: [
                          BoxShadow(
                          
                            color: colors.shadow.withOpacity(0.1),
                            blurRadius: 5,
                            offset: Offset(0, 0)
                          ),
                          
                        ]
                        ),
                      ),
                       Text(
                      e.nameB,
                      style: GoogleFonts.openSans(
                        color: colors.text,
                        fontSize: Dimensitions.width13,
                        fontWeight: FontWeight.w600,
                      ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                       GestureDetector(
                        onTap: () => us.addRemoveRemovedFollowingList(e),
                         child: Container(
                               margin: EdgeInsets.only(right: Dimensitions.width3),
                                padding: EdgeInsets.symmetric(vertical: Dimensitions.height3,horizontal: Dimensitions.width15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensitions.height5),
                                  border: Border.all(color: colors.rose7,),
                                 color: us.removedFollowingList.contains(e)?colors.rose7:colors.bg,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Abonné",
                                      style: GoogleFonts.openSans(
                                        color: us.removedFollowingList.contains(e)?Colors.white:colors.rose7,
                                        fontWeight: FontWeight.w500,
                                        fontSize: Dimensitions.width13
                                      ),
                                      ),
                                    SizedBox(width: Dimensitions.width3,),
                                    
                                  ],
                                ),
                              ),
                       ),
                                  SvgPicture.asset("assets/icons/dots-3.svg",color: colors.text2,height: Dimensitions.height19,),
                                  SizedBox(width: Dimensitions.width17,),
      
                  ],
                ),
              ],
            ),
            
                      );
                  },).toList().cast<Widget>(),
                )
        :   IndexedStack(
              index: us.socialValue=="Abonnées"?0:1,
              children: [
                  Column(
                  children: us.followersList!.map((e) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: Dimensitions.height20, ),
                      child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: Dimensitions.height30,
                      width: Dimensitions.width30,
                      margin: EdgeInsets.only(left: Dimensitions.width25,right: Dimensitions.width10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: e.imageU==""?
                        DecorationImage(image: AssetImage("assets/images/img.png"),fit: BoxFit.cover):
                        DecorationImage(image: NetworkImage(e.imageU),fit: BoxFit.cover),
                       boxShadow: [
        BoxShadow(
        
          color: colors.shadow.withOpacity(0.1),
          blurRadius: 5,
          offset: Offset(0, 0)
        ),
        
      ]
                      ),
                    ),
                     Text(
                    e.nameU,
                    style: GoogleFonts.openSans(
                      color: colors.text,
                      fontSize: Dimensitions.width13,
                      fontWeight: FontWeight.w600,
                    ),
                    ),
                  ],
                ),
                Row(
                  children: [
                                  SvgPicture.asset("assets/icons/dots-3.svg",color: colors.text2,height: Dimensitions.height19,),
                                  SizedBox(width: Dimensitions.width17,),
      
                  ],
                ),
              ],
            ),
            
                      );
                  },).toList().cast<Widget>(),
                ),
              
                Column(
                  children: us.followingList!.map((e) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: Dimensitions.height20, ),
                      child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                   onTap: () async{
                  DocumentSnapshot snap=  await FirebaseFirestore.instance.collection("boutiques").doc(e.bid).get();
                  Provider.of<userProvider>(context,listen: false).getOtherFollowers(e.bid);
                            Provider.of<userProvider>(context,listen: false).getOtherFollowing(snap["docId"]);
                              List<dynamic> dynamicList = snap["liens"];
          List<dynamic> sanitizedLiens = dynamicList.map((url) => url.replaceAll('&', '%26')).toList();
                          Get.toNamed(
                          RouteHelper.getBoutiqueProfile(
                            Boutique(
                              owner: false,
                              docId: snap.id, 
                              bio: snap["bio"], 
                              category: snap["category"], 
                              usDocID: snap["docId"], 
                              liens: sanitizedLiens, 
                              name: snap["name"], 
                              phone: snap["phone"], 
                              profilPicture: snap["profileImage"].toString().replaceAll('&', '%26'), 
                              sCategory: snap["sCate"], 
                              ville: snap["ville"], 
                              followers: snap["followers"], 
                              following: snap["following"]
                              )
                          ));
                  },
                  child: Row(
                    children: [
                      Container(
                        height: Dimensitions.height30,
                        width: Dimensitions.width30,
                        margin: EdgeInsets.only(left: Dimensitions.width25,right: Dimensitions.width10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: e.imageB==""?
                          DecorationImage(image: AssetImage("assets/images/img.png"),fit: BoxFit.cover):
                          DecorationImage(image: NetworkImage(e.imageB),fit: BoxFit.cover),
                         boxShadow: [
                          BoxShadow(
                          
                            color: colors.shadow.withOpacity(0.1),
                            blurRadius: 5,
                            offset: Offset(0, 0)
                          ),
                          
                        ]
                        ),
                      ),
                       Text(
                      e.nameB,
                      style: GoogleFonts.openSans(
                        color: colors.text,
                        fontSize: Dimensitions.width13,
                        fontWeight: FontWeight.w600,
                      ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                       GestureDetector(
                        onTap: () => us.addRemoveRemovedFollowingList(e),
                         child: Container(
                               margin: EdgeInsets.only(right: Dimensitions.width3),
                                padding: EdgeInsets.symmetric(vertical: Dimensitions.height3,horizontal: Dimensitions.width15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensitions.height5),
                                  border: Border.all(color: colors.rose7,),
                                 color: us.removedFollowingList.contains(e)?colors.rose7:colors.bg,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Abonné",
                                      style: GoogleFonts.openSans(
                                        color: us.removedFollowingList.contains(e)?Colors.white:colors.rose7,
                                        fontWeight: FontWeight.w500,
                                        fontSize: Dimensitions.width13
                                      ),
                                      ),
                                    SizedBox(width: Dimensitions.width3,),
                                    
                                  ],
                                ),
                              ),
                       ),
                                  SvgPicture.asset("assets/icons/dots-3.svg",color: colors.text2,height: Dimensitions.height19,),
                                  SizedBox(width: Dimensitions.width17,),
      
                  ],
                ),
              ],
            ),
            
                      );
                  },).toList().cast<Widget>(),
                ),
              
              ],
            ),
      
        ],
      ),
    );
       
      },
    ),
         
        );
   
  }
}