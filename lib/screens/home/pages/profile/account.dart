import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diva/compoents/account/account_list_tile.dart';
import 'package:diva/compoents/title_text.dart';
import 'package:diva/provider/account/user_provider.dart';
import 'package:diva/routes/route_helper.dart';
import 'package:diva/services/sotorage_service.dart';
import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class Account extends StatefulWidget {
  final VoidCallback? onTap;

  const Account({super.key,required this.onTap});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
 bool _changeDeconnectionbackgroud=false;
 bool _changeQRbackgroud=false;
 bool _changeDVbackgroud=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: colors.bg,
     appBar:PreferredSize(
        preferredSize: Size.fromHeight(Dimensitions.height60), 
        child: Padding(
          padding: EdgeInsets.only(top: Dimensitions.height28,left: Dimensitions.width25,right:Dimensitions.width25, ),
          child: Column(
          children: [
            Row(
                    children: [
                     
                      SizedBox(
                        width: Dimensitions.width280,
                        child: MyTitleText(
                          title: "Profile",
                          
                          ),
                      ),
                    ],
                   ),
                   Container(
                margin: EdgeInsets.only(top: Dimensitions.height10 ),
                    height: Dimensitions.height2,
                    color: colors.sp,
                  ),
          ],
                ),
        )
        ),
// MyAppBar(
//       onTap: () {
//         if(onTap != null){
//           onTap!();
//         }
//       },
//       fn:false,
//       onTapNotif: ()=>Get.toNamed(RouteHelper.notification,id: 4),
//       onTapfav: ()=>Get.toNamed(RouteHelper.favorit,id: 4),
// ),

      body: Consumer<userProvider>(
        builder: (context, us, child) {
          //print(FirebaseAuth.instance.currentUser!.uid);
          if (us.euser==null) {
            us.fetchUser(FirebaseAuth.instance.currentUser!.uid);
          }
          if(!us.isv && us.euser!=null && FirebaseAuth.instance.currentUser != null){
            us.fetchboutique(us.euser!.docId,FirebaseAuth.instance.currentUser!.uid);
          }
          if (!us.checkTime && us.euser!=null && us.boutiqueDocId!=null) {
           us.chekTime(us.euser!.docId ,us.boutiqueDocId!);
          }
          if (us.boutique != null && us.PublicationNumber=="") {
            us.getPublicationLenght();
          }

          if (us.followersList==null && us.boutique != null) {
            us.getFollowersList(us.boutique!.docId); 
          }
          if (us.followingList==null) {
            us.getFollowingList();
          }
          return   us.euser==null
          ?
          Center(
            child: CircularProgressIndicator(
              color: colors.rose1,
              strokeWidth: Dimensitions.height1,
            ),
          )
          :
          SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: Dimensitions.height30,),
      // //title
      // Center(
      //         child: 
      //       MyTitleText(
      //         title: "Profile",
      //         padding: EdgeInsets.only(
      //           bottom: Dimensitions.height28,
      //           top: Dimensitions.height15,),
      //         )
           
      //       ),
      // profile picture
      Container(
          width: double.infinity,
          height: Dimensitions.height130,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/BANDE.png")
              )
          ),
          child:  Stack(
            children: [
            
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: Dimensitions.height2),
                  height: Dimensitions.height120,
                  width: Dimensitions.height120,
                  decoration: BoxDecoration(
                    color: colors.rose1,
                    border: Border.all(color: colors.sp,width: 1.5),
                    shape: BoxShape.circle,
                    image:us.euser!.image==""?
                    DecorationImage(
                      image: AssetImage("assets/images/img.png"),
                      fit: BoxFit.cover
                      ): DecorationImage(
                      image: NetworkImage(us.euser!.image),
                      fit: BoxFit.cover
                      )
                    ),
                            ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                   onTap:() async{
             
                 List<MediaFile> mediaFiles= await   GalleryPicker.pickMedia(
                      context: context,
                      singleMedia: true,
                 config: Config(
                 selected: "selectionner",
                 recents: "RÉCENTS",
                 gallery: "GALLERY",
                 lastMonth: "Mois dernier",
                 lastWeek: "Semaine dernière",
                 tapPhotoSelect: "Sélectionner votre images",
                 selectIcon: Container(
                  width: Dimensitions.width30,
                  height: Dimensitions.height30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.sp,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
              ),
                                  ) ?? [];
              if (mediaFiles.isNotEmpty) {
                try {
                  File ss = await  mediaFiles[0].getFile();
                  String  netImg= await storagService().uploadFile(ss, ss.path.split("/").last,"");
                    // Update the user's image and log the document ID
                 String userDocId = us.euser!.docId;
          
                  await FirebaseFirestore.instance.collection("users").doc(userDocId).update({
                    'image': netImg,
                  });
                  us.fetchUser(FirebaseAuth.instance.currentUser!.uid);
                  QuerySnapshot commentSnap =  
                  await FirebaseFirestore
                  .instance
                  .collection("comments")
                  .where("uid",isEqualTo:FirebaseAuth.instance.currentUser!.uid )
                  .get();

                  for (var c in commentSnap.docs) {
                  await FirebaseFirestore.instance.collection("comments").doc(c.id).update({
                    'image': netImg,
                  });  
                  }
                   QuerySnapshot socialUserSnap =  
                  await FirebaseFirestore
                  .instance
                  .collection("socialMedia")
                  .where("uid",isEqualTo:FirebaseAuth.instance.currentUser!.uid )
                  .get();
                  
                  for (var c in socialUserSnap.docs) {
                  await FirebaseFirestore.instance.collection("socialMedia").doc(c.id).update({
                    'imageU': netImg,
                  });  
                  }
                  QuerySnapshot notif = await FirebaseFirestore.instance.collection("usersNotifications").where("senderID",isEqualTo:FirebaseAuth.instance.currentUser!.uid ).get();
              print(notif.docs.length);
                 for (var n in notif.docs) {
                   await FirebaseFirestore.instance.collection("usersNotifications").doc(n.id).update({
                    "imageSender":netImg,
                   });
                 }
                  // Check if boutique is not null and log the document ID
                  if (us.boutique != null) {
                    String boutiqueDocId = us.boutique!.docId;
                    await FirebaseFirestore.instance.collection("boutiques").doc(boutiqueDocId).update({
                      'profileImage': netImg,
                    });
                    QuerySnapshot socialBoutiqueSnap =  
                  await FirebaseFirestore
                  .instance
                  .collection("socialMedia")
                  .where("bid",isEqualTo:boutiqueDocId )
                  .get();
                  
                  for (var c in socialBoutiqueSnap.docs) {
                  await FirebaseFirestore.instance.collection("socialMedia").doc(c.id).update({
                    'imageB': netImg,
                  });  
                  }
                  } 
                  if (us.boutique !=null) {
                    us.fetchboutique(us.euser!.docId, FirebaseAuth.instance.currentUser!.uid);
                  }
                  
                } catch (e) {
                  print("Error updating image: $e");
                  
                }
                 
                                    
                                  }

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: colors.shadow.withOpacity(0.55),
                          blurRadius: 5,
                          offset: Offset(0, 0)
                        ),
                      ]
                    ),
                    margin: EdgeInsets.only(left: Dimensitions.width90,bottom: Dimensitions.height10),
                    padding: EdgeInsets.all(Dimensitions.height5),
                    child: SvgPicture.asset(
                    "assets/icons/edit.svg",
                    height: Dimensitions.height20,
                    color: colors.sp,
                    ),
                  ),
                ),
              ),
            ],
          )
          
        ),

      // profile name and edit
      // name
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Text(
              us.euser!.name,
              style: GoogleFonts.openSans(
              textStyle: TextStyle(
                color: colors.text2,
                fontWeight: FontWeight.bold,
                fontSize: Dimensitions.width18,
              )
            ),
            ),
          ],
         ),
     us.euser!.bio==""?
     Container(): SizedBox(height: Dimensitions.height2,),
      // bio
     us.euser!.bio==""?
     Container()
     : Center(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: Dimensitions.width25),
            child: Text(
              overflow: TextOverflow.ellipsis,
              us.euser!.bio,
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: Dimensitions.width16,
                  fontWeight: FontWeight.w400,
                  color: colors.text2
                )
              ),
              ),
          ),
         ),
      // spearator
      Container(
          margin: EdgeInsets.only(top: Dimensitions.height8,bottom:Dimensitions.height5, ),
          height: Dimensitions.height1_5,
          width: Dimensitions.width300,
          color: colors.sp,
         ),
      // info
      AccountListTile(
        page: RouteHelper.getInfoPerson(us.euser!), 
        assetSvg: "assets/icons/manage_accounts.svg", 
        title: "Inforamtion personnelle"
        ),
      // mon reseau 
      AccountListTile(
        page: RouteHelper.monResau, 
        assetSvg: "assets/icons/réseau.svg", 
        title: "Mon réseau"
        ),
      
      // devenir
     us.euser!.type=="boutique"?
     us.isv && us.offre
     ?
     AccountListTile(
        page: RouteHelper.getBoutiqueProfile(us.boutique!), 
        assetSvg: "assets/icons/devenir.svg", 
        title: "Ma boutique"
        )
     :
     GestureDetector(
             onTap: () {
                  setState(() {
        _changeDVbackgroud=true;
        });
        Future.delayed(Duration(milliseconds: 150),(){
         setState(() {
        _changeDVbackgroud=false;
        });
        });
         Get.toNamed(RouteHelper.getDevenir(us.mode!,us.boutiqueDocId!,us.euser!.docId));
             },
             child: 
             Container(
              
              color: _changeDVbackgroud?colors.shadow.withOpacity(0.05):Colors.transparent,
              margin: EdgeInsets.only(
                left: Dimensitions.width25,
                right: Dimensitions.width25,
             
                ),
               
                height: Dimensitions.height35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
             Row(children: [
             
             Container(
          margin: EdgeInsets.only(right: Dimensitions.width5,),
          width: Dimensitions.width25,
          child: SvgPicture.asset("assets/icons/devenir.svg",height: Dimensitions.height20,),
        ),
             Text(
                    "Ma boutique",
                     style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    color: colors.text2,
                    fontWeight: FontWeight.w600,
                    fontSize: Dimensitions.width15,
                
                  )
                ),
                    ),
             ],),
                    Transform.rotate(
                    angle: pi/2,
                    child: SvgPicture.asset("assets/icons/taille.svg",height:  Dimensitions.height13,color: colors.sp,)),
             
                  ],
                ),
             ),
           
           )
      
     :
      AccountListTile(
        page: RouteHelper.getFormulaire(us.euser!.docId,us.euser!.image), 
        assetSvg: "assets/icons/devenir.svg", 
        title: "Devenir vendeuse"
        ), 
      // speararot
      Container(
             color: colors.sp,
              height: Dimensitions.height0_2,
              width: Dimensitions.width265,
              margin: EdgeInsets.only(
                top: Dimensitions.height8,
                bottom:Dimensitions.height5,
               ),
      
             ),
      // contacter e-wom
      AccountListTile(
        page: RouteHelper.getContacterEWom(us.euser!.email, us.euser!.name), 
        assetSvg: "assets/icons/contqcter.svg", 
        title: "Contacter e-wom"
        ),
          
      // confidentialité 
      AccountListTile(
        page: RouteHelper.confi, 
        assetSvg: "assets/icons/verified_user_.svg", 
        title: "Confidentialité"
        ),
        
      //separator 2
       Container(
             color: colors.sp,
              height: Dimensitions.height0_2,
              width: Dimensitions.width265,
              margin: EdgeInsets.only(
                top: Dimensitions.height8,
                bottom:Dimensitions.height5,
               ),
      
             ),
      // Centre d'aide
      AccountListTile(
        page: RouteHelper.centerAide, 
        assetSvg: "assets/icons/help_.svg", 
        title: "Centre d'aide"
        ),
      // qr
      GestureDetector(
             onTap: () {
               setState(() {
        _changeQRbackgroud=true;
        });
        Future.delayed(Duration(milliseconds: 150),(){
         setState(() {
        _changeQRbackgroud=false;
        });
        });
              Get.toNamed(RouteHelper.getMonQR(us.euser!.name,us.euser!.image));
              },
             child: 
             Container(
              color: _changeQRbackgroud?colors.shadow.withOpacity(0.05):Colors.transparent,
              margin: EdgeInsets.only(
                left: Dimensitions.width25,
                right: Dimensitions.width25,
             
                ),
               
                height: Dimensitions.height35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
             Row(children: [
             
             Container(
          margin: EdgeInsets.only(right: Dimensitions.width5,),
          width: Dimensitions.width25,
          child: SvgPicture.asset("assets/icons/qr.svg",height: Dimensitions.height20,),
        ),
             Text(
                    "Mon QR code",
                     style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    color: colors.text2,
                    fontWeight: FontWeight.w600,
                    fontSize: Dimensitions.width15,
                
                  )
                ),
                    ),
             ],),
                    Transform.rotate(
                    angle: pi/2,
                    child: SvgPicture.asset("assets/icons/taille.svg",height:  Dimensitions.height13,color: colors.sp,)),
             
                  ],
                ),
             ),
           
           ),    
      
      // deconnexion
      GestureDetector(
             onTap: () {
              setState(() {
        _changeDeconnectionbackgroud=true;
        });
        Future.delayed(Duration(milliseconds: 150),(){
         setState(() {
        _changeDeconnectionbackgroud=false;
        });
        });
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
                                onTap: () async{
                                   final fcmToken = await FirebaseMessaging.instance.getToken();
                                    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("tokens").where("token",isEqualTo: fcmToken).get();
                                    await FirebaseFirestore.instance.collection("tokens").doc(snapshot.docs.first.id).delete();
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
                              margin: EdgeInsets.only(left: Dimensitions.width5),
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
             
             child: 
             Container(
        color: _changeDeconnectionbackgroud?colors.shadow.withOpacity(0.05):Colors.transparent,

              margin: EdgeInsets.only(
                left: Dimensitions.width25,
                right: Dimensitions.width25,
             
                ),
               
                height: Dimensitions.height35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
             Row(children: [
            
             Container(
          margin: EdgeInsets.only(right: Dimensitions.width5,),
          width: Dimensitions.width25,
          child: SvgPicture.asset("assets/icons/login_.svg",height: Dimensitions.height20,),
        ),
             Text(
                    "Déconnexion",
                     style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    color: colors.text2,
                    fontWeight: FontWeight.w600,
                    fontSize: Dimensitions.width15,
                
                  )
                ),
                    ),
             ],),
                    Transform.rotate(
                    angle: pi/2,
                    child: SvgPicture.asset("assets/icons/taille.svg",height:  Dimensitions.height13,color: colors.sp,)),
             
                  ],
                ),
             ),
           
           ), 
          
      SizedBox(height: Dimensitions.height30,),
           
          ],
        )
        );
    
        },
        )
    
    );
  }
}