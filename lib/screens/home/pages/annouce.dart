import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diva/class/notification.dart';
import 'package:diva/class/product.dart';
import 'package:diva/class/social_class.dart';
import 'package:diva/compoents/profile/text_from_field.dart';
import 'package:diva/compoents/title_text.dart';
import 'package:diva/provider/account/user_provider.dart';
import 'package:diva/services/push_notification_services.dart';
import 'package:diva/services/sotorage_service.dart';
import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
class annouce extends StatefulWidget {
  const annouce({super.key});

  @override
  State<annouce> createState() => _annouceState();
}

class _annouceState extends State<annouce> {
  final _priceController =TextEditingController();
  final _productName =TextEditingController();
  final _productDescription=TextEditingController();
  List<File> _slectedFiles=[];
  late Color appbarColor;
  List<String> val = ["En haut","En bas"];
  String currentVal = "En haut";
  bool? isCheckedH =false;
  bool? isCheckedB = false;
  int price = 4000;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appbarColor=colors.sp;
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.bg,
      appBar: PreferredSize(
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
                          title: "Créer une annonce",
                          
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
     
      floatingActionButton: Padding(
          padding: EdgeInsets.only(left: Dimensitions.width35),
          child: Consumer<userProvider>(
            builder: (context, value, child) {
              return    Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              value.booster?
              Container(
                              
                              width: Dimensitions.width110,
                              height: Dimensitions.height30,
                              decoration: BoxDecoration(
                               color: colors.bg,
                                border: Border.all(color: colors.rose3,width: Dimensitions.width2),
                                borderRadius: BorderRadius.circular(Dimensitions.height10),
                  boxShadow: [
                                    BoxShadow(
                                   color:colors.shadow.withOpacity(0.3),
                                    blurRadius: 4,
                                    offset: Offset(0, 0)
                                      ),
                                  ],     
                                
                              ),
                              child: Center(
                                child: Text("= $price DA",style: GoogleFonts.openSans(
                                  color: colors.text,
                                  fontSize: Dimensitions.width11,
                                  fontWeight: FontWeight.bold
                                  
                                ),),
                              ),
                            )
              :SizedBox.shrink(),
           value.booster  ? SizedBox(
                width: Dimensitions.width15,
              ):SizedBox.shrink(),
              GestureDetector(
                onTap: () async{
                  
                  if (_slectedFiles.isEmpty ||_productName.text.isEmpty ||_productDescription.text.isEmpty || _priceController.text.isEmpty ) {
                    Get.snackbar(
                      "Informations manquantes", 
                      "Veuillez remplir toutes les informations. La chaîne requise n'a pas été trouvée dans la liste.",
                      backgroundColor: colors.sp,
                      snackPosition: SnackPosition.BOTTOM,
                      colorText: Colors.white,
                      );
                  }else{
                    List<String> _netImages =[];
                    
                showDialog(
                  context: context,
                  barrierDismissible: false, 
                  builder: (context) => const Center(child: CircularProgressIndicator(color:colors.sp,),),
                  );
                     for (var e in _slectedFiles) {
                  String  netImg= await storagService().uploadFile(e, e.path.split("/").last,"products/");
                  _netImages.add(netImg);
                  }
               final docref= await FirebaseFirestore.instance.collection("products").add({
                    'idBoutique':Provider.of<userProvider>(context,listen: false).boutique!.docId,
                    'images':_netImages,
                    'name':_productName.text,
                    'description':_productDescription.text,
                    'price':_priceController.text,
                    'time':Timestamp.now(),
                    'promotion':false,
                    'rating':'0',
                    'pubs':value.booster
                    ?
                    {
                      'time':Timestamp.now(),
                      'week':value.weeks,
                      'place':currentVal==val[0]?"a":"b",
                    }
                    :
                    {},
                  });
                  if (isCheckedH! ||isCheckedB!) {
                    await FirebaseFirestore.instance.collection("boutiques").doc(value.boutique!.docId).update({
                      'pubs':{
                      'time':Timestamp.now(),
                      'week':value.weeks,
                      'place':isCheckedH!?"a":"b",
                      }
                    });
                  }
                  if (value.booster) {
                    value.updateBooster();
                    setState(() {
                          isCheckedH=false;
                          isCheckedB=false;
                          currentVal=val[0];
                        });
                        _calculatePrice();
                  }
                  if (_netImages.isNotEmpty) {
                     Provider.of<userProvider>(context,listen: false).loadAgain(
                    Products(
                      boutiqueId: Provider.of<userProvider>(context,listen: false).boutique!.docId, 
                      descriptiont: _productDescription.text, 
                      iamges:_netImages , 
                      name: _productName.text, 
                      price: _priceController.text,
                      productId: docref.id, 
                      promotion: false, 
                      pubs: {}, 
                      rating: '0'
                      )
                );
                Provider.of<userProvider>(context,listen: false).getPublicationLenght();
                if(Provider.of<userProvider>(context,listen: false).followersList != null){
                  List<String> ids =[];
                  for (socialMedia sc in Provider.of<userProvider>(context,listen: false).followersList!) {
                    ids.add(sc.uid);
                  }
                  if(ids.length >0){
                    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                    .collection("tokens")
                    .where("uid", whereIn: ids)
                    .get();
                    for (var t in querySnapshot.docs) {
                      PushNotificationServices.sendNotificationToSelectedDriver(
                        deviceToken: t["token"], 
                        notifi: MyNotificationClass(
                          senderID: Provider.of<userProvider>(context,listen: false).boutique!.docId, 
                          reciverID: t["uid"], 
                          content: "Découvrez notre dernier produit exclusif ajouté par ${Provider.of<userProvider>(context,listen: false).boutique!.name}. Ne manquez pas cette nouveauté, disponible dès maintenant !", 
                          imageSender: Provider.of<userProvider>(context,listen: false).boutique!.profilPicture, 
                          nameSender: Provider.of<userProvider>(context,listen: false).boutique!.name, 
                          timestamp: DateTime.now().toString(),
                          ), 
                        title: "Nouvelle Arrivée ! 🏵️"
                        );
                        for (var id in ids) {
                            await FirebaseFirestore.instance.collection("usersNotifications").add({
                            "senderID": Provider.of<userProvider>(context,listen: false).boutique!.docId,
                            "reciverID":id , 
                            "content": "Découvrez notre dernier produit exclusif ajouté par ${Provider.of<userProvider>(context,listen: false).boutique!.name}. Ne manquez pas cette nouveauté, disponible dès maintenant !", 
                            "imageSender": Provider.of<userProvider>(context,listen: false).boutique!.profilPicture, 
                            "nameSender": Provider.of<userProvider>(context,listen: false).boutique!.name, 
                            "timestamp": Timestamp.now(),
                          });
                        }
                      
                    }
                  }
                   
                }
                    
                  }else{
                    print("list is empty");
                  }
                 
                  Get.back();
                
                  setState(() {
                    _slectedFiles.clear();
                    _productName.clear(); 
                    _productDescription.clear();  
                    _priceController.clear();
                  });
Get.snackbar(
                      "Confirmation d'ajout", 
                      "Le produit a été ajouté avec succès.",
                      backgroundColor: colors.sp,
                      snackPosition: SnackPosition.BOTTOM,
                      colorText: Colors.white,
                      );
                  }
                 
                 
                },
                child: Container(
                              
                              width: Dimensitions.width110,
                              height: Dimensitions.height30,
                              decoration: BoxDecoration(
                                color: colors.rose3,
                                borderRadius: BorderRadius.circular(Dimensitions.height10),
                  boxShadow: [
                                    BoxShadow(
                                   color:colors.shadow.withOpacity(0.3),
                                    blurRadius: 4,
                                    offset: Offset(0, 0)
                                      ),
                                  ],     
                                
                              ),
                              child: Center(
                                child: Text("Publier",style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontSize: Dimensitions.width12,
                                  fontWeight: FontWeight.bold
                                  
                                ),),
                              ),
                            ),
              ),
            ],
          );
       
            },
            ),
       
        ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensitions.width25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Dimensitions.height10,),
              // image prodcut
              Text(
                    "Ajouter une image",
                    style: GoogleFonts.openSans(
                      color: colors.text,
                      fontSize: Dimensitions.width13,
                      fontWeight: FontWeight.w600,
                    ),
                    ),
              
         _slectedFiles.length==0?
         Container()
         : 
         Container(
                margin: EdgeInsets.only(
                  top: Dimensitions.height20,
                 
                ),
                height: Dimensitions.height120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _slectedFiles.length,
                  itemBuilder: (context, index) {
                 
                    
                    return Stack(

                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.only(right: Dimensitions.width15),
                            height: Dimensitions.height100,
                            width: Dimensitions.width95,
                            decoration: BoxDecoration(
                            color: colors.text3,
                            borderRadius: BorderRadius.circular(Dimensitions.height10),
                            border: Border.all(color: colors.sp,width: Dimensitions.width1_5),
                            image: DecorationImage(image: FileImage(_slectedFiles[index]),fit: BoxFit.cover)
                            ),
                          ),
                        ),
                      ],
                    );
                    
                  },
                  ),
              ),

        Align(
                alignment: Alignment.center,
                child: GestureDetector(
                 
                  onTap:() async{
                    List<File> paths= [];
                 List<MediaFile> mediaFiles= await   GalleryPicker.pickMedia(
                      context: context,
                      singleMedia: false,
                 config: Config(

// backgroundColor: colors.bg,
    // appbarColor: Colors.white,
    // bottomSheetColor: const Color.fromARGB(255, 247, 248, 250),
    // appbarIconColor: const Color.fromARGB(255, 130, 141, 148),
    // underlineColor: colors.sp,
    // selectedMenuStyle: const TextStyle(color: Colors.black),
    // unselectedMenuStyle:
    //     const TextStyle(color: Color.fromARGB(255, 102, 112, 117)),
    // textStyle: const TextStyle(
    //     color: Color.fromARGB(255, 108, 115, 121),
    //     fontWeight: FontWeight.bold),
    // appbarTextStyle: const TextStyle(color: Colors.black),
    // textStyle: GoogleFonts.openSans(
    //   color: colors.text2,
    //   fontSize: Dimensitions.width16,
    //   fontWeight: FontWeight.w500
    // ),
    selected: "selectionner",
    recents: "RÉCENTS",
    gallery: "GALLERY",
    lastMonth: "Mois dernier",
    lastWeek: "Semaine dernière",
    tapPhotoSelect: "Sélectionner des images",


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


                 _slectedFiles.clear();
                 for (var e in mediaFiles) {
                          File ss = await  e.getFile();
                          paths.add(ss);
                        }
                      setState(() {
                        _slectedFiles=paths;
                      });
                   
      

                  },
                  
                  child: Container(
                    margin: EdgeInsets.only(top: Dimensitions.height15,),
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensitions.width30,
                      vertical: Dimensitions.height10
                    ),
                    decoration: BoxDecoration(
                      color: colors.sp,
                      borderRadius: BorderRadius.circular(Dimensitions.height10)
                    ),
                    child: Text(
                      "Ajouter",
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: Dimensitions.width16,
                        fontWeight: FontWeight.w500,
                      ),
                      ),
                  ),
                ),
              ),
              
              
              // name product
              MyProfileTextField(
              label: "Nom",
              fillColor: Colors.white,
              textInputAction: TextInputAction.next,
              controller: _productName,
              ),
              // description prodcut
              MyProfileTextField(
              label: "Description",
              fillColor: Colors.white,
              textInputAction: TextInputAction.next,
              controller: _productDescription,
              ),
              // price
              MyProfileTextField(
                onChanged: (p0) {
            if (p0!=" DA") {
                     if (!_priceController.text.endsWith(' DA')) {
      _priceController.text = _priceController.text.replaceAll(' DA', '') + ' DA';
      _priceController.selection = TextSelection.fromPosition(
        TextPosition(offset: _priceController.text.length - 3),
      );
    }     
            }else{
              _priceController.clear();
            }
                },
              textAlign: TextAlign.center,
              label: "Prix de vente",
              fillColor: Colors.white,
              textInputAction: TextInputAction.done,
              controller: _priceController,
              keyboardType: TextInputType.number,
              ),
              SizedBox(height: Dimensitions.height5,),
              
              // Booster
             Consumer<userProvider>(
              builder: (context, value, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                           onTap: () {
                        value.updateBooster();
                        if (!value.booster) {
                        setState(() {
                          isCheckedH=false;
                          isCheckedB=false;
                          currentVal=val[0];
                        });
                        _calculatePrice();
                        }
                      },
                      child: SizedBox(
                        width: Dimensitions.width100,
                                    
                                     child: Row(
                       children: [
                        Transform.rotate(
                          angle:value.booster? pi:0,
                          child: SvgPicture.asset("assets/icons/down-arrow.svg",color: colors.sp,height: Dimensitions.height25,)),
                        SizedBox(width: Dimensitions.width5,),
                         Text(
                                "Booster",
                                style: GoogleFonts.openSans(
                                  color: colors.sp,
                                  fontSize: Dimensitions.width15,
                                  fontWeight: FontWeight.bold,
                                ),
                                ),
                       ],
                                     ),
                                   ),
                    ),
                    value.booster
                    ?Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Dimensitions.height15,),
                        Text(
                    "Durée",
                    style: GoogleFonts.openSans(
                      color: colors.text,
                      fontSize: Dimensitions.width14,
                      fontWeight: FontWeight.w600,
                    ),
                    ),
                        SizedBox(height: Dimensitions.height10,),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: Dimensitions.width7),
                          child: Row(
                              children: [
                               Text(
                                                     "1000 DA",
                                                     style: GoogleFonts.openSans(
                                                       color: colors.text,
                                                       fontSize: Dimensitions.width12,
                                                       fontWeight: FontWeight.w600,
                                                     ),
                                                     ),
                                Spacer(),
                                Text(
                                                     "2000 DA",
                                                     style: GoogleFonts.openSans(
                                                       color: colors.text,
                                                       fontSize: Dimensitions.width12,
                                                       fontWeight: FontWeight.w600,
                                                     ),
                                                     ),
                                Spacer(),
                                   Text(
                                                     "3000 DA",
                                                     style: GoogleFonts.openSans(
                                                       color: colors.text,
                                                       fontSize: Dimensitions.width12,
                                                       fontWeight: FontWeight.w600,
                                                     ),
                                                     ),
                              ],
                            ),
                        ),
                        SizedBox(height: Dimensitions.height5,),
                        
                        Stack(
                          children: [
                            Padding(
                          padding: EdgeInsets.symmetric(horizontal: Dimensitions.width35),
                          child: Row(
                            children: [
                          Container(
                               width:Dimensitions.width1_5,
                                height: Dimensitions.height6,
                                color: colors.sp,
                              ),
                              Expanded(
                                child: Container(
                                  height: Dimensitions.height1,
                                  color: value.weeks !=1?colors.sp:colors.text3,
                                )
                                ),
                              Container(
                                width:Dimensitions.width1_5,
                                height: Dimensitions.height6,
                                color: value.weeks ==3?colors.sp:colors.text3,
                              ),
                              Expanded(
                                child: Container(
                                   height: Dimensitions.height1,
                                  color: value.weeks ==3?colors.sp:colors.text3,
                                )
                                ),
                                Container(
                                width:Dimensitions.width1_5,
                                height: Dimensitions.height6,
                                color: colors.text3,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: Dimensitions.width32),
                          child: Row(
                            children: [
                            GestureDetector(
                            onTap: (){value.updateWeeks(1);_calculatePrice();},
                             child: Container(
                                  width: Dimensitions.height8,
                                  height: Dimensitions.height8,
                                  decoration: BoxDecoration(
                                  color:value.weeks==1? colors.sp:Colors.transparent,
                                  shape: BoxShape.circle
                                  ),
                                ),
                           ),
                             Spacer(),
                              GestureDetector(
                            onTap: (){value.updateWeeks(2);_calculatePrice();},
                             child: Container(
                                  width: Dimensitions.height8,
                                  height: Dimensitions.height8,
                                  decoration: BoxDecoration(
                                  color:value.weeks==2? colors.sp:Colors.transparent,
                                  shape: BoxShape.circle
                                  ),
                                ),
                           ),
                              Spacer(),
                               GestureDetector(
                            onTap: (){value.updateWeeks(3);_calculatePrice();},
                             child: Container(
                                  width: Dimensitions.height8,
                                  height: Dimensitions.height8,
                                  decoration: BoxDecoration(
                                  color:value.weeks==3? colors.sp:Colors.transparent,
                                  shape: BoxShape.circle
                                  ),
                                ),
                           ),
                            ],
                          ),
                        ),
                        
                          ],
                        ),
                        SizedBox(height: Dimensitions.height5,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: Dimensitions.width10),
                          child: Row(
                              children: [
                               GestureDetector(
                        
                                onTap: (){value.updateWeeks(1);_calculatePrice();},
                                 child: Column(
                                   children: [
                                     Text(
                                      "1",
                                      style: GoogleFonts.openSans(
                                      fontSize: Dimensitions.width12,
                                      color: value.weeks==1?colors.sp:colors.text3,
                                      fontWeight: FontWeight.w600,
                                                                   ),
                                      ),
                                      Text(
                                                             "Semaine",
                                                             style: GoogleFonts.openSans(
                                  fontSize: Dimensitions.width12,
                                  color: value.weeks==1?colors.sp:colors.text3,
                                  fontWeight: FontWeight.w600,
                                                             ),
                                                             ),
                                   ],
                                 ),
                               ),
                                Spacer(),
                                 GestureDetector(
                                onTap: (){value.updateWeeks(2);_calculatePrice();},
                          
                                   child: Column(
                                     children: [
                                       Text(
                                        "2",
                                        style: GoogleFonts.openSans(
                                                                       fontSize: Dimensitions.width12,
                                                                       color: value.weeks==2?colors.sp:colors.text3,
                                                                       fontWeight: FontWeight.w600,
                                                                     ),
                                        ),
                                        Text(
                                                               "Semaine",
                                                               style: GoogleFonts.openSans(
                                                                 fontSize: Dimensitions.width12,
                                                                 color: value.weeks==2?colors.sp:colors.text3,
                                                                 fontWeight: FontWeight.w600,
                                                               ),
                                                               ),
                                     ],
                                   ),
                                 ),
                                Spacer(),
                                   GestureDetector(
                                onTap: (){value.updateWeeks(3);_calculatePrice();},
                          
                                     child: Column(
                                       children: [
                                         Text(
                                          "3",
                                          style: GoogleFonts.openSans(
                                                                         fontSize: Dimensitions.width12,
                                                                         color:value.weeks==3?colors.sp: colors.text3,
                                                                         fontWeight: FontWeight.w600,
                                                                       ),
                                          ),
                                          Text(
                                                                 "Semaine",
                                                                 style: GoogleFonts.openSans(
                                                                   fontSize: Dimensitions.width12,
                                                                   color: value.weeks==3?colors.sp:colors.text3,
                                                                   fontWeight: FontWeight.w600,
                                                                 ),
                                                                 ),
                                       ],
                                     ),
                                   ),
                              ],
                            ),
                        ),
                        
                        SizedBox(height: Dimensitions.height15,),
                        // photo
                         Text(
                    "Photo",
                    style: GoogleFonts.openSans(
                      color: colors.text,
                      fontSize: Dimensitions.width14,
                      fontWeight: FontWeight.w600,
                    ),
                    ),
                    SizedBox(
                          height: Dimensitions.height10,
                        ),
                    // recherche photo
                    Row(
                      children: [
                        SizedBox(
                          width: Dimensitions.width15,
                        ),
                        Column(
                          children: [
                            Text(
                    "Recherche",
                    style: GoogleFonts.openSans(
                      color: colors.text,
                      fontSize: Dimensitions.width12,
                      fontWeight: FontWeight.w600,
                    ),
                    ),
                    Container(
                      width: Dimensitions.width50,
                     
                      height: Dimensitions.height1_5,
                     
                     color: colors.sp,
                    ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensitions.height15,),
                    Row(
                      children: [
                

                         Container(
                      width: Dimensitions.width35,
                     
                     
                      child: Transform.scale(
                         scale: 1.2,
                        child: Radio(
                         materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          focusColor: colors.sp,
                          activeColor: colors.sp,
                          groupValue: currentVal,
                          value: val[0],
                          onChanged: (value) {
                             setState(() {
                              currentVal= value!;
                            });
                        _calculatePrice();

                          },
                          
                          ),
                      ),
                    ),
                               SizedBox(
                           width: Dimensitions.width70,
                                
                                 child: Text(
                                                     "En haut",
                                                     style: GoogleFonts.openSans(
                                                       color: colors.text,
                                                       fontSize: Dimensitions.width12,
                                                       fontWeight: FontWeight.w600,
                                                     ),
                                                     ),
                               ),
                               Text(
                                                     "(3000 DA)",
                                                     style: GoogleFonts.openSans(
                                                       color: colors.text,
                                                       fontSize: Dimensitions.width12,
                                                       fontWeight: FontWeight.w600,
                                                     ),
                                                     ),
                      ],
                    ),
              

                     Row(
                      children: [
                   

                        Container(
                      width: Dimensitions.width35,
                     
                     
                      child: Transform.scale(
                         scale: 1.2,
                        child: Radio(
                         materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                         activeColor: colors.sp,
                      
                          focusColor: colors.sp,
                          groupValue: currentVal,
                          value: val[1],
                          onChanged: (value) {
                             setState(() {
                              currentVal= value!;
                            });
                        _calculatePrice();

                          },
                          
                          ),
                      ),
                    ),
                               SizedBox(
                              width: Dimensitions.width70,
                                 child: Text(
                                                     "En bas",
                                                     style: GoogleFonts.openSans(
                                                       color: colors.text,
                                                       fontSize: Dimensitions.width12,
                                                       fontWeight: FontWeight.w600,
                                                     ),
                                                     ),
                               ),
                               Text(
                                                     "(2000 DA)",
                                                     style: GoogleFonts.openSans(
                                                       color: colors.text,
                                                       fontSize: Dimensitions.width12,
                                                       fontWeight: FontWeight.w600,
                                                     ),
                                                     ),
                      ],
                    ),
                      
                      SizedBox(
                        height: Dimensitions.height10,
                      ),
                      // boutique text
                         Text(
                    "Boutique",
                    style: GoogleFonts.openSans(
                      color: colors.text,
                      fontSize: Dimensitions.width14,
                      fontWeight: FontWeight.w600,
                    ),
                    ),
                    SizedBox(height: Dimensitions.height10,),

                    //search   
                    Padding(
                      padding:  EdgeInsets.only(left:Dimensitions.width15 ),
                      child: Column(
                        children: [
                          Text(
                                          "Recherche",
                                          style: GoogleFonts.openSans(
                                            color: colors.text,
                                            fontSize: Dimensitions.width12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          ),
                                          Container(
                                            width: Dimensitions.width50,
                                           
                                            height: Dimensitions.height1_5,
                                           
                                           color: colors.sp,
                                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Dimensitions.height15,),
                    Row(
                      children: [
                  

                         Container(
                      width: Dimensitions.width35,
                     child: Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: isCheckedH, 
                      activeColor: colors.sp,
                      onChanged: (newBool) {
                        setState(() {
                          isCheckedH=newBool;
                          isCheckedB=false;
                        });
                        _calculatePrice();

                      },
                      ),
                     
                      
                    ),
                               SizedBox(
                                width: Dimensitions.width70,
                               
                                 child: Text(
                                                     "En haut",
                                                     style: GoogleFonts.openSans(
                                                       color: colors.text,
                                                       fontSize: Dimensitions.width12,
                                                       fontWeight: FontWeight.w600,
                                                     ),
                                                     ),
                               ),
                               Text(
                                                     "(3000 DA)",
                                                     style: GoogleFonts.openSans(
                                                       color: colors.text,
                                                       fontSize: Dimensitions.width12,
                                                       fontWeight: FontWeight.w600,
                                                     ),
                                                     ),
                      ],
                    ),
              

                     Row(
                      children: [

                        Container(
                      width: Dimensitions.width35,
                      child:Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: isCheckedB, 
                      activeColor: colors.sp,
                      onChanged: (newBool) {
                        setState(() {
                          isCheckedB=newBool;
                          isCheckedH=false;
                        });
                        _calculatePrice();
                      },
                      ),
                     
                    ),
                               SizedBox(
                                                                width: Dimensitions.width70,

                                 child: Text(
                                                     "En bas",
                                                     style: GoogleFonts.openSans(
                                                       color: colors.text,
                                                       fontSize: Dimensitions.width12,
                                                       fontWeight: FontWeight.w600,
                                                     ),
                                                     ),
                               ),
                               Text(
                                                     "(2000 DA)",
                                                     style: GoogleFonts.openSans(
                                                       color: colors.text,
                                                       fontSize: Dimensitions.width12,
                                                       fontWeight: FontWeight.w600,
                                                     ),
                                                     ),
                      ],
                    ),
                      
                      ],
                    )
                    :Container(),
                  
                  ],
                );
             
              },
              ),
            
             Container(
              //color: colors.purpel1,
              height: Dimensitions.height100,),

            ],
          ),
          ),
      ),
    
    );
  }
  void _calculatePrice(){
    int weeks=0;int image =0;int boutique=0;
    switch (Provider.of<userProvider>(context,listen: false).weeks) {
      case 1:
      weeks=1000;
        break;
      case 2:
      weeks=2000;
        break;
      case 3:
      weeks=3000;
        break;
      default:
      weeks=1000;
    }
    if (currentVal==val[0]) {
      image=3000;
    }else{
      image=2000;
    }
    if (isCheckedB!) {
      boutique=2000;
    }
    if (isCheckedH!) {
      boutique=3000;
    }
    setState(() {
      price=boutique+image+weeks;
    });

  }
}