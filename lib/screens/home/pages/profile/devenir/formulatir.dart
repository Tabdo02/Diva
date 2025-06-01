import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diva/class/home/ps.dart';
import 'package:diva/compoents/home/app_bar.dart';
import 'package:diva/compoents/profile/phone_class.dart';
import 'package:diva/compoents/profile/text_from_field.dart';
import 'package:diva/provider/account/user_provider.dart';
import 'package:diva/provider/home/category_provider.dart';
import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class formulair extends StatefulWidget {
  final String docId;
  final String image;
  const formulair({super.key,required this.docId,required this.image});

  @override
  State<formulair> createState() => _formulairState();
}

class _formulairState extends State<formulair> {
  bool _showClearButton = false;
  // String _previousText = '';
  TextEditingController _controller = TextEditingController();
   final TextEditingController _textController = TextEditingController();
   final TextEditingController _boutiqueNameController = TextEditingController();
   final TextEditingController _boutiquebioController = TextEditingController();


   final String _userPostfix = "+213";
   String _ville ="";
   String _mode ="";
   String _psValue="";
   String _sCate ="";
   bool showVille= false;
   bool showMode= false;
   bool showPsValue= false;
   bool showScte= false;
   List<dynamic> liens=[];

  int indx=0;
   List<PS> myPs=[];
   List<String> myMode=["B2B","B2C"];
   List<String> wilayas = [
  "Adrar",
  "Chlef",
  "Laghouat",
  "Oum El Bouaghi",
  "Batna",
  "Béjaïa",
  "Biskra",
  "Béchar",
  "Blida",
  "Bouira",
  "Tamanrasset",
  "Tébessa",
  "Tlemcen",
  "Tiaret",
  "Tizi Ouzou",
  "Algiers",
  "Djelfa",
  "Jijel",
  "Sétif",
  "Saïda",
  "Skikda",
  "Sidi Bel Abbès",
  "Annaba",
  "Guelma",
  "Constantine",
  "Médéa",
  "Mostaganem",
  "M'Sila",
  "Mascara",
  "Ouargla",
  "Oran",
  "El Bayadh",
  "Illizi",
  "Bordj Bou Arreridj",
  "Boumerdès",
  "El Tarf",
  "Tindouf",
  "Tissemsilt",
  "El Oued",
  "Khenchela",
  "Souk Ahras",
  "Tipaza",
  "Mila",
  "Aïn Defla",
  "Naâma",
  "Aïn Témouchent",
  "Ghardaïa",
  "Relizane",
  "Timimoun",
  "Bordj Badji Mokhtar",
  "Ouled Djellal",
  "Béni Abbès",
  "In Salah",
  "In Guezzam",
  "Touggourt",
  "Djanet",
  "El M'Ghair",
  "El Meniaa"
];

    void _clearText() {
    _controller.clear(); // Clear the text in the controller
    setState(() {
             _showClearButton = false;
            });
  }

  @override
  Widget build(BuildContext context) {

    return 
    Provider.of<userProvider>(context,listen: false).euser!.type=="waiting"?
    Scaffold(
      appBar:MyAppBar(
        tit: "Formulaire",
        fn:true,
        ),
      backgroundColor: colors.bg,
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: Dimensitions.width20),
        child: Column(
          children: [
            SizedBox(height: Dimensitions.height20,),
            Text("Nous avons bien reçu votre soumission. Merci de nous avoir contactés. Vous recevrez une réponse bientôt."
            ,style: GoogleFonts.openSans(
              fontSize: Dimensitions.width15,
              fontWeight: FontWeight.w500
            ),
            ),
          ],
        ),
      ),
    )
    :
    Scaffold(
      appBar:MyAppBar(
        tit: "Formulaire",
        fn:true,
        ),
      backgroundColor: colors.bg,
        floatingActionButton:  Padding(
          padding: EdgeInsets.only(left: Dimensitions.width25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
              onTap: () async{
                if (
                  _textController.text.isEmpty || _boutiqueNameController.text.isEmpty || _boutiquebioController.text.isEmpty ||
                  _ville==""||_psValue=="" || (myPs[indx].sCategory!.length !=0 && _sCate=="" ) || _mode=="" || liens.length ==0
                  ) {
                    
                    Get.snackbar(
                      "Informations manquantes", 
                      "Veuillez remplir toutes les informations. La chaîne requise n'a pas été trouvée dans la liste.",
                      backgroundColor: colors.sp,
                      snackPosition: SnackPosition.BOTTOM,
                      colorText: Colors.white,
                      );
                }else{
                  
                  List<String> ll =[];
                  for (var element in liens) {
                      ll.add(element[0]);
                  }
                  await FirebaseFirestore.instance.collection("boutiques").add({
                    "accepted":false,
                    "bio":_boutiquebioController.text,
                    "category":_psValue,
                    "docId":widget.docId,
                    "liens":ll,
                    "mode":_mode,
                    "name":_boutiqueNameController.text,
                    "offre":{},
                    "phone":_textController.text.trim(),
                    "profileImage":Provider.of<userProvider>(context,listen: false).euser?.image ?? "",
                    "sCate":_sCate,
                    "time":Timestamp.now(),
                    "ville":_ville,
                    "followers":"0",
                    "following":"0",
                    "pubs":{},
                  });
                  await FirebaseFirestore.instance.collection("users").doc(widget.docId).update({
                    "type":"waiting"
                  });

                  Provider.of<userProvider>(context,listen: false).fetchUser(FirebaseAuth.instance.currentUser!.uid);

                  Get.back(id: 4);
                   Get.snackbar(
                      "Formulaire soumis avec succès", 
                      "Merci d'avoir rempli le formulaire. Vos informations ont été soumises avec succès.",
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
                                child: Text("Sauvgarder",style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontSize: Dimensitions.width12,
                                  fontWeight: FontWeight.bold
                                  
                                ),),
                              ),
                            ),
              ),
            ],
          ),
        ),

      body: Consumer<CategoryProvider>(builder: (context, PsItems, child) {
        if(PsItems.service.length==0){
          PsItems.allService();
        }
        if (PsItems.service.length!=0 && myPs.length==0) {
          for (var s in PsItems.service) {
        
            myPs.add(s);
        
        }
        for (var p in PsItems.produit) {
         
            myPs.add(p);
          
        }
        }
       

       
        return  PsItems.service.length==0?
        Center(
          child: CircularProgressIndicator(color: colors.rose1,strokeWidth: Dimensitions.height1,),
        )
        :
        SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Dimensitions.width25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Dimensitions.height20,),
              // boutique name
               MyProfileTextField(
                  label: "Nom du boutique",
                  hintText: "votre nom ici",
                  controller: _boutiqueNameController,
                  fillColor: colors.bg,
                  textInputAction: TextInputAction.done,
                  maxLength: 23,
                 ),
            // boutique bio
               MyProfileTextField(
                  label: "Bio",
                  hintText: "votre bio ici...",
                  fillColor: colors.bg,
                  textInputAction: TextInputAction.done,
                 controller: _boutiquebioController,
                 maxLength: 110 ,
                 ),
           
           SizedBox(height: Dimensitions.height5,),
            // boutique location
              Text(
                      "Localisation",
                      style: GoogleFonts.openSans(
                        color: colors.text,
                        fontSize: Dimensitions.width13,
                        fontWeight: FontWeight.w600,
                      ),
                      ),
              
             Stack(
              children: [
                 GestureDetector(
                  onTap: () => setState(() {
                    showVille=true;
                  }),
                   child: Container(
                                 margin: EdgeInsets.only(top: Dimensitions.height15,bottom: Dimensitions.height20),
                                 width: double.maxFinite,
                                 height: Dimensitions.height50,
                                 decoration: BoxDecoration(
                    border: Border.all(color: colors.text3),
                    borderRadius: BorderRadius.circular(Dimensitions.height10),
                    
                                 ),
                                 child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(_ville==""?
                            "Ville":_ville,
                            style: GoogleFonts.openSans(
                              fontSize: Dimensitions.width15,
                              fontWeight: FontWeight.w500,
                              color: colors.text
                            ),
                            
                            ),
                            SizedBox(width: Dimensitions.width3,),
                          SvgPicture.asset("assets/icons/down-arrow.svg",height: Dimensitions.height23,color: colors.text3,)
                       
                   
                    ],
                                 ),
                               ),
                 ),
                     showVille?  
             AnimatedContainer(
                margin: EdgeInsets.only(top: Dimensitions.height15,bottom: Dimensitions.height20),
                  duration: Duration(milliseconds: 130),
                  height: Dimensitions.height250,
                  decoration: BoxDecoration(
                  color: colors.bg,
                  borderRadius: BorderRadius.circular(Dimensitions.height10),
                  border: Border.all(color: colors.text3),
                  boxShadow: [
                    BoxShadow(
                      color: colors.shadow.withOpacity(0.11),
                      blurRadius: 4,
                      offset: Offset(0, 2)
                    ),
                    BoxShadow(
                      color: colors.shadow.withOpacity(0.11),
                      blurRadius: 4,
                      offset: Offset(0, -2)
                    ),
                     BoxShadow(
                      color: colors.shadow.withOpacity(0.11),
                      blurRadius: 4,
                      offset: Offset(2, 0)
                    ),
                    BoxShadow(
                      color: colors.shadow.withOpacity(0.11),
                      blurRadius: 4,
                      offset: Offset(-2, 0)
                    )
                  ]
                         
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: Dimensitions.height10,),
                    Stack(
                      children: [
                          Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
                          "Ville",
                          style: GoogleFonts.openSans(
                            fontSize: Dimensitions.width15,
                            fontWeight: FontWeight.w500,
                            color: colors.text
                          ),
                          
                          ),
                     
                         
                  ],
                ),
             
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding:  EdgeInsets.only(left: Dimensitions.width60),
                            child: Transform.rotate(
                              angle: -pi,
                              child: SvgPicture.asset("assets/icons/down-arrow.svg",height: Dimensitions.height23,color: colors.text3,)),
                          ),
                        )
                     ,
                      ],
                    ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: Dimensitions.height10,horizontal: Dimensitions.width40),
                  color: colors.text3,
                  height: Dimensitions.height0_5,
                     ),
                    Expanded(
                      child: ListView(
                        children: wilayas.map((e) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: Dimensitions.width40),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _ville=e;
                                  showVille=false;
                                });
                              },
                              child: SizedBox(
                                height: Dimensitions.height30,
                                child: Text(
                                                      textAlign: TextAlign.center,
                                                      e,
                                                      style:  GoogleFonts.openSans(
                                    fontSize: Dimensitions.width15,
                                    fontWeight: FontWeight.w500,
                                    color: colors.text
                                  ),
                                                      ),
                              ),
                            ),
                          ) ;
                        },)
                        .toList().cast<Widget>(),
                      ),
                    ),
                     
                         
                    ],
                  ),
                ).animate(delay: Duration(milliseconds: 130)).fade()
              :Container(),
              ],
             ),
            // boutique number
            Text(
                      "Numero du telephone",
                      style: GoogleFonts.openSans(
                        color: colors.text,
                        fontSize: Dimensitions.width13,
                        fontWeight: FontWeight.w600,
                      ),
                      ),

          SizedBox(height: Dimensitions.height15,),

                        Container(
            height: Dimensitions.height70,
            child: 
            TextFormField(
             
              controller: _textController,
               onChanged: (value) {
             
                   if (value == _userPostfix) {
                    _textController.text = "";
                    return;
                  }
                  value.startsWith(_userPostfix)
                      ? _textController.text = value
                      : _textController.text = _userPostfix+value;
                  
                },
            
              textAlign: TextAlign.center,
               inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'\s')),
                   LengthLimitingTextInputFormatter(17),
                PhoneNumberFormatter()
               ],
                      style: GoogleFonts.openSans(
                          fontSize: Dimensitions.width15,
                          fontWeight: FontWeight.w500,
                          color: colors.text
                        ),
                     maxLength: 17,
                     
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        
                    
                      
                      
                        counterText:"" ,
                       
                   
                        fillColor: colors.bg,
                        filled: true,
                        hintText: "+213  --- -- -- --",
                        hintStyle: GoogleFonts.openSans(
                          fontSize: Dimensitions.width15,
                          fontWeight: FontWeight.w500,
                          color: colors.text
                        ),
                  
                        enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensitions.height10),
                        borderSide: BorderSide(color: colors.text3)
                    
                        ),
                        disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensitions.height10),
                        borderSide: BorderSide(color: colors.text3)
                    
                        ),
                        focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensitions.height10),
                        borderSide: BorderSide(color: colors.rose3)
                    
                        ),
                      ),
            
            ),
          
          ),
          // categorie de boutique
            Text(
                      "Categorie de boutique",
                      style: GoogleFonts.openSans(
                        color: colors.text,
                        fontSize: Dimensitions.width13,
                        fontWeight: FontWeight.w600,
                      ),
                      ),
              
             Stack(
              children: [
                 GestureDetector(
                  onTap: () => setState(() {
                    showPsValue=true;
                  }),
                   child: Container(
                                 margin: EdgeInsets.only(top: Dimensitions.height15,bottom: Dimensitions.height20),
                                 width: double.maxFinite,
                                 height: Dimensitions.height50,
                                 decoration: BoxDecoration(
                    border: Border.all(color: colors.text3),
                    borderRadius: BorderRadius.circular(Dimensitions.height10),
                    
                                 ),
                                 child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(_psValue==""?
                            "Categorie":_psValue,
                            style: GoogleFonts.openSans(
                              fontSize: Dimensitions.width15,
                              fontWeight: FontWeight.w500,
                              color: colors.text
                            ),
                            
                            ),
                            SizedBox(width: Dimensitions.width3,),
                          SvgPicture.asset("assets/icons/down-arrow.svg",height: Dimensitions.height23,color: colors.text3,)
                       
                   
                    ],
                                 ),
                               ),
                 ),
                     showPsValue?  
             AnimatedContainer(
                margin: EdgeInsets.only(top: Dimensitions.height15,bottom: Dimensitions.height20),
                  duration: Duration(milliseconds: 130),
                  height: Dimensitions.height250,
                  decoration: BoxDecoration(
                  color: colors.bg,
                  borderRadius: BorderRadius.circular(Dimensitions.height10),
                  border: Border.all(color: colors.text3),
                  boxShadow: [
                    BoxShadow(
                      color: colors.shadow.withOpacity(0.11),
                      blurRadius: 4,
                      offset: Offset(0, 2)
                    ),
                    BoxShadow(
                      color: colors.shadow.withOpacity(0.11),
                      blurRadius: 4,
                      offset: Offset(0, -2)
                    ),
                     BoxShadow(
                      color: colors.shadow.withOpacity(0.11),
                      blurRadius: 4,
                      offset: Offset(2, 0)
                    ),
                    BoxShadow(
                      color: colors.shadow.withOpacity(0.11),
                      blurRadius: 4,
                      offset: Offset(-2, 0)
                    )
                  ]
                         
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: Dimensitions.height10,),
                    Stack(
                      children: [
                          Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
                          "Categorie",
                          style: GoogleFonts.openSans(
                            fontSize: Dimensitions.width15,
                            fontWeight: FontWeight.w500,
                            color: colors.text
                          ),
                          
                          ),
                     
                         
                  ],
                ),
             
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding:  EdgeInsets.only(left: Dimensitions.width90),
                            child: Transform.rotate(
                              angle: -pi,
                              child: SvgPicture.asset("assets/icons/down-arrow.svg",height: Dimensitions.height23,color: colors.text3,)),
                          ),
                        )
                     ,
                      ],
                    ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: Dimensitions.height10,horizontal: Dimensitions.width40),
                  color: colors.text3,
                  height: Dimensitions.height0_5,
                     ),
                    Expanded(
                      child: ListView(
                        children: myPs.map((e) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: Dimensitions.width40),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  indx=myPs.indexOf(e);
                                  _psValue=e.name;
                                  _sCate="";
                                  showPsValue=false;
                                });
                              },
                              child: SizedBox(
                                height: Dimensitions.height30,
                                child: Text(
                                                      textAlign: TextAlign.center,
                                                      e.name,
                                                      style:  GoogleFonts.openSans(
                                    fontSize: Dimensitions.width15,
                                    fontWeight: FontWeight.w500,
                                    color: colors.text
                                  ),
                                                      ),
                              ),
                            ),
                          ) ;
                        },)
                        .toList().cast<Widget>(),
                      ),
                    ),
                     
                         
                    ],
                  ),
                ).animate(delay: Duration(milliseconds: 130)).fade()
              :Container(),
              ],
             ),
          // sous categorie de boutique
      myPs[indx].sCategory!.length !=0 && _psValue !=""?  
       Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
                      "Sous Categorie",
                      style: GoogleFonts.openSans(
                        color: colors.text,
                        fontSize: Dimensitions.width13,
                        fontWeight: FontWeight.w600,
                      ),
                      ),
              
          Stack(
              children: [
                 GestureDetector(
                  onTap: () => setState(() {
                    showScte=true;
                  }),
                   child: Container(
                                 margin: EdgeInsets.only(top: Dimensitions.height15,bottom: Dimensitions.height20),
                                 width: double.maxFinite,
                                 height: Dimensitions.height50,
                                 decoration: BoxDecoration(
                    border: Border.all(color: colors.text3),
                    borderRadius: BorderRadius.circular(Dimensitions.height10),
                    
                                 ),
                                 child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(_sCate==""?
                            "Sous categorie":_sCate,
                            style: GoogleFonts.openSans(
                              fontSize: Dimensitions.width15,
                              fontWeight: FontWeight.w500,
                              color: colors.text
                            ),
                            
                            ),
                            SizedBox(width: Dimensitions.width3,),
                          SvgPicture.asset("assets/icons/down-arrow.svg",height: Dimensitions.height23,color: colors.text3,)
                       
                   
                    ],
                                 ),
                               ),
                 ),
                     showScte?  
             AnimatedContainer(
                margin: EdgeInsets.only(top: Dimensitions.height15,bottom: Dimensitions.height20),
                  duration: Duration(milliseconds: 130),
                  height: Dimensitions.height250,
                  decoration: BoxDecoration(
                  color: colors.bg,
                  borderRadius: BorderRadius.circular(Dimensitions.height10),
                  border: Border.all(color: colors.text3),
                  boxShadow: [
                    BoxShadow(
                      color: colors.shadow.withOpacity(0.11),
                      blurRadius: 4,
                      offset: Offset(0, 2)
                    ),
                    BoxShadow(
                      color: colors.shadow.withOpacity(0.11),
                      blurRadius: 4,
                      offset: Offset(0, -2)
                    ),
                     BoxShadow(
                      color: colors.shadow.withOpacity(0.11),
                      blurRadius: 4,
                      offset: Offset(2, 0)
                    ),
                    BoxShadow(
                      color: colors.shadow.withOpacity(0.11),
                      blurRadius: 4,
                      offset: Offset(-2, 0)
                    )
                  ]
                         
                  ),
                  child: Column(
                  
                    children: [
                      SizedBox(height: Dimensitions.height10,),
                    Stack(
                      children: [
                          Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
                          "Sous categorie",
                          style: GoogleFonts.openSans(
                            fontSize: Dimensitions.width15,
                            fontWeight: FontWeight.w500,
                            color: colors.text
                          ),
                          
                          ),
                     
                         
                  ],
                ),
             
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding:  EdgeInsets.only(left: Dimensitions.width130),
                            child: Transform.rotate(
                              angle: -pi,
                              child: SvgPicture.asset("assets/icons/down-arrow.svg",height: Dimensitions.height23,color: colors.text3,)),
                          ),
                        )
                     ,
                      ],
                    ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: Dimensitions.height10,horizontal: Dimensitions.width40),
                  color: colors.text3,
                  height: Dimensitions.height0_5,
                     ),
                    Expanded(
                      child: ListView(
                        children: myPs[indx].sCategory!.map((e) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: Dimensitions.width40),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _sCate=e;
                                  showScte=false;
                                });
                              },
                              child: SizedBox(
                                height: Dimensitions.height30,
                                child: Text(
                                                      textAlign: TextAlign.center,
                                                      e,
                                                      style:  GoogleFonts.openSans(
                                    fontSize: Dimensitions.width15,
                                    fontWeight: FontWeight.w500,
                                    color: colors.text
                                  ),
                                                      ),
                              ),
                            ),
                          ) ;
                        },)
                        .toList().cast<Widget>(),
                      ),
                    ),
                     
                         
                    ],
                  ),
                ).animate(delay: Duration(milliseconds: 130)).fade()
              :Container(),
              ],
             ),
        
          ],
         ):Container(),
          
          // lien de boutique 
        
            MyProfileTextField(
               onTap: () async {
                // Manually trigger paste if available
                ClipboardData? data = await Clipboard.getData('text/plain');
                if (data != null && data.text != null) {
                  _controller.text = data.text!;
                  String p0= _controller.text;
                   if (p0.contains("instagram")) {  
                    bool isHere=false;
                    for (var e in liens) {
                      if (p0==e[0] && e[1]=="instagram") { 
                        isHere=true;
                      }
                    }   
                    if (!isHere) {
                      setState(() {
                      liens.add([p0,"instagram",p0.split("/")[3].split("?")[0],false]);
                    });
                    }      
                   }else if(p0.contains("facebook")){
                     bool isHere=false;
                    for (var e in liens) {
                      if (p0==e[0] && e[1]=="facebook") { 
                        isHere=true;
                      }
                    }  
                    if (!isHere) {
                       setState(() {
                      liens.add([p0,"facebook","facebook",false]);
                      
                    });
                    }
                    

                   }else if(p0.contains("tiktok")){
                      //tiktok.svg
                       bool isHere=false;
                    for (var e in liens) {
                      if (p0==e[0] && e[1]=="tiktok") { 
                        isHere=true;
                      }
                    } 
                    if (!isHere) {
                            setState(() {
                      liens.add([p0,"tiktok",p0.split("/")[3].split("?")[0],false]);
                    });
                    }
                   }else{
                    {  
                    bool isHere=false;
                    for (var e in liens) {
                      if (p0==e[0] && e[1]=="site") { 
                        isHere=true;
                      }
                    }   
                    if (!isHere) {
                      setState(() {
                      liens.add([p0,"site","site",false]);
                    });
                    }      
                   }
                   }
                   setState(() {
                      _showClearButton = true;
                    });
                }
              },
              readOnly: true,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'.')),
              ],
              suffixIcon:  _showClearButton
                  ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed:_clearText,
                    )
                  : null,
              controller: _controller,
                  label: "Liens du boutique",
                  hintText: "votre Lien ici...",
                  fillColor: colors.bg,
                  textInputAction: TextInputAction.done,
              
                 ),
              
               liens.length==0?
               Container()
               : 
                Column(
                  children: [
                    Column(
                      children: liens.map((e) {
                        return Padding(
                          padding:  EdgeInsets.symmetric(vertical: Dimensitions.height5),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: Dimensitions.width10,),
                                padding: EdgeInsets.all(Dimensitions.height7),
                                height: Dimensitions.height30,
                                width: Dimensitions.width30,
                                decoration: BoxDecoration(
                                  color: colors.rose7,
                                  shape: BoxShape.circle
                                ),
                                child: SvgPicture.asset("assets/icons/${e[1]}.svg",color: Colors.white,),
                              ),
                              Expanded(
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  e[2],
                                  
                                  style: GoogleFonts.openSans(
                                                        color: colors.text,
                                                        fontSize: Dimensitions.width13,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                  ),
                              ),
                              SizedBox(
                                width: Dimensitions.width10,
                              ),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                  liens.remove(e);
                                  });
                                },
                                child: Icon(Icons.close,size:Dimensitions.height20,color:colors.text)),
                            ],
                          ).animate().fade(),
                        );
                      },)
                      .toList().cast<Widget>(),
                    ),
                  ],
                 ),
            // mode de vent
            SizedBox(height: Dimensitions.height5,),
            Text(
                      "Mode de vente",
                      style: GoogleFonts.openSans(
                        color: colors.text,
                        fontSize: Dimensitions.width13,
                        fontWeight: FontWeight.w600,
                      ),
                      ),
              
             Stack(
              children: [
                 GestureDetector(
                  onTap: () => setState(() {
                    showMode=true;
                  }),
                   child: Container(
                                 margin: EdgeInsets.only(top: Dimensitions.height15,bottom: Dimensitions.height20),
                                 width: double.maxFinite,
                                 height: Dimensitions.height50,
                                 decoration: BoxDecoration(
                    border: Border.all(color: colors.text3),
                    borderRadius: BorderRadius.circular(Dimensitions.height10),
                    
                                 ),
                                 child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(_mode==""?
                            "Mode":_mode,
                            style: GoogleFonts.openSans(
                              fontSize: Dimensitions.width15,
                              fontWeight: FontWeight.w500,
                              color: colors.text
                            ),
                            
                            ),
                            SizedBox(width: Dimensitions.width3,),
                          SvgPicture.asset("assets/icons/down-arrow.svg",height: Dimensitions.height23,color: colors.text3,)
                       
                   
                    ],
                                 ),
                               ),
                 ),
                     showMode?  
             AnimatedContainer(
                margin: EdgeInsets.only(top: Dimensitions.height15,bottom: Dimensitions.height20),
                  duration: Duration(milliseconds: 130),
                  height: Dimensitions.height120,
                  decoration: BoxDecoration(
                  color: colors.bg,
                  borderRadius: BorderRadius.circular(Dimensitions.height10),
                  border: Border.all(color: colors.text3),
                  boxShadow: [
                    BoxShadow(
                      color: colors.shadow.withOpacity(0.11),
                      blurRadius: 4,
                      offset: Offset(0, 2)
                    ),
                    BoxShadow(
                      color: colors.shadow.withOpacity(0.11),
                      blurRadius: 4,
                      offset: Offset(0, -2)
                    ),
                     BoxShadow(
                      color: colors.shadow.withOpacity(0.11),
                      blurRadius: 4,
                      offset: Offset(2, 0)
                    ),
                    BoxShadow(
                      color: colors.shadow.withOpacity(0.11),
                      blurRadius: 4,
                      offset: Offset(-2, 0)
                    )
                  ]
                         
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: Dimensitions.height10,),
                    Stack(
                      children: [
                          Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
                          "Mode",
                          style: GoogleFonts.openSans(
                            fontSize: Dimensitions.width15,
                            fontWeight: FontWeight.w500,
                            color: colors.text
                          ),
                          
                          ),
                     
                         
                  ],
                ),
             
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding:  EdgeInsets.only(left: Dimensitions.width60),
                            child: Transform.rotate(
                              angle: -pi,
                              child: SvgPicture.asset("assets/icons/down-arrow.svg",height: Dimensitions.height23,color: colors.text3,)),
                          ),
                        )
                     ,
                      ],
                    ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: Dimensitions.height10,horizontal: Dimensitions.width40),
                  color: colors.text3,
                  height: Dimensitions.height0_5,
                     ),
                    Expanded(
                      child: ListView(
                        children: myMode.map((e) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: Dimensitions.width40),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _mode=e;
                                  showMode=false;
                                });
                              },
                              child: SizedBox(
                                height: Dimensitions.height30,
                                child: Text(
                                                      textAlign: TextAlign.center,
                                                      e,
                                                      style:  GoogleFonts.openSans(
                                    fontSize: Dimensitions.width15,
                                    fontWeight: FontWeight.w500,
                                    color: colors.text
                                  ),
                                                      ),
                              ),
                            ),
                          ) ;
                        },)
                        .toList().cast<Widget>(),
                      ),
                    ),
                     
                         
                    ],
                  ),
                ).animate(delay: Duration(milliseconds: 130)).fade()
              :Container(),
              ],
             ),
            SizedBox(height: Dimensitions.height50,)
            ],
          ),
        ),
      )
    ;
      },),
       
    );
  }
}