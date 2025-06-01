import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diva/class/users.dart';
import 'package:diva/compoents/home/app_bar.dart';
import 'package:diva/compoents/profile/phone_class.dart';
import 'package:diva/compoents/profile/text_from_field.dart';
import 'package:diva/provider/account/user_provider.dart';
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

class informationPersonelle extends StatefulWidget {
  final EUsers us;
  const informationPersonelle({super.key,required this.us,});

  @override
  State<informationPersonelle> createState() => _informationPersonelleState();
}

class _informationPersonelleState extends State<informationPersonelle> {
   final TextEditingController _textController = TextEditingController();
   final TextEditingController _userNameController = TextEditingController();
   final TextEditingController _userbioController = TextEditingController();

   final String _userPostfix = "+213";
   String _date ="";
   String _ville ="";

   bool scroll=false;
    bool showVille= false;
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

   void _showDatePicker(){
    showDatePicker(
      builder: (context, child) {
         return Theme(
          
          data: Theme.of(context).copyWith(
        
            colorScheme: ColorScheme.light(
             primary: colors.rose1, // header background color
              onPrimary: Colors.black, // header text color
              onSurface: colors.text2,  // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: colors.rose5, // button text color
              ),
            ),
          ),
          child: child!,
        );
     
    
      },
      context: context, 
      firstDate: DateTime(1930), 
      lastDate: DateTime(2010),
      cancelText: "Annuler",
      helpText: "Sélectionner une date"

      ).then((value) {
          if(value != null){
            setState(() {
              _date="${value.day}?${value.month}?${value.year}";
            });
          }
      },);
   }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _date=widget.us.date;
      _ville=widget.us.ville;
      if(widget.us.phone.isNotEmpty){
      _textController.text="+${widget.us.phone}";
      }
    _userNameController.text=  widget.us.name;
    _userbioController.text=  widget.us.bio;

    });
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
         appBar:MyAppBar(
        tit: "Information personnelle",
        fn:true,
        ),
        floatingActionButton:  Padding(
          padding: EdgeInsets.only(left: Dimensitions.width25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async{
                 // print(_textController.text);
                 
                  Provider.of<userProvider>(context,listen: false).updateUser(
                    EUsers(
                      email: widget.us.email, 
                      password: "",
                      bio: _userbioController.text,
                      name: _userNameController.text,
                      date: _date,
                      ville: _ville,
                      phone: _textController.text.trim(),
                      image: widget.us.image,
                      docId:widget.us.docId,
                      type: widget.us.type, 
                      )
                    );
                      await FirebaseFirestore.
                      instance.
                      collection("users").
                      doc(widget.us.docId).
                      update(
                        {
                          "name": _userNameController.text,
                          "bio":_userbioController.text,
                          "date":_date,
                          "ville":_ville,
                          "phone":_textController.text,
                      }
                      );
                       QuerySnapshot commentSnap =  
                  await FirebaseFirestore
                  .instance
                  .collection("comments")
                  .where("uid",isEqualTo:FirebaseAuth.instance.currentUser!.uid )
                  .get();

                  for (var c in commentSnap.docs) {
                  await FirebaseFirestore.instance.collection("comments").doc(c.id).update({
                    'nameProfile': _userNameController.text,
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
                    'nameU': _userNameController.text,
                  });  
                  }
                  QuerySnapshot notif = await FirebaseFirestore.instance.collection("usersNotifications").where("senderID",isEqualTo:FirebaseAuth.instance.currentUser!.uid ).get();
                 for (var n in notif.docs) {
                   await FirebaseFirestore.instance.collection("usersNotifications").doc(n.id).update({
                    "nameSender":_userNameController.text,
                   });
                 }
                    Get.back(id: 4);
                    Get.snackbar(
                      "Succès", 
                      "vos informations ont été mises à jour avec succès",
                      backgroundColor: colors.sp,
                      snackPosition: SnackPosition.BOTTOM,
                      colorText: Colors.white,
                      );
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

      backgroundColor: colors.bg,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensitions.width25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
           SizedBox(height: Dimensitions.height20,),
           // user name
             MyProfileTextField(
              label: "Nom d'utilisateur",
              fillColor: colors.bg,
              maxLength: 25,
              textInputAction: TextInputAction.done,
              controller: _userNameController,
             ),
             // user bio
             MyProfileTextField(
              label: "Bio",
              fillColor: colors.bg,
              maxLength: 115,
              textInputAction: TextInputAction.done,
              //initialValue: widget.us.bio ??"",
              controller: _userbioController,
             ),
             // user email
             MyProfileTextField(
              label: "Email",
              fillColor: colors.bg,
             inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'\s'))
             ],
              textInputAction: TextInputAction.done,
              initialValue: widget.us.email,
              readOnly: true,
             ),
           SizedBox(height: Dimensitions.height10,),
          
            Text(
                    "Date de naissance",
                    style: GoogleFonts.openSans(
                      color: colors.text,
                      fontSize: Dimensitions.width13,
                      fontWeight: FontWeight.w600,
                    ),
                    ),
           SizedBox(height: Dimensitions.height10,),
          
           Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: _showDatePicker,
                  child: Container(
                                 
                  
                   
                    height: Dimensitions.height50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensitions.height10),
                      border: Border.all(color: colors.text3)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                  
                      children: [
                          SizedBox(width: Dimensitions.width5,),
                  
                        Text(
                          _date !=""?
                          _date.split("?")[0]:
                          "Date",
                          style: GoogleFonts.openSans(
                            fontSize: Dimensitions.width15,
                            fontWeight: FontWeight.w500,
                            color: colors.text
                          ),
                          
                          ),
                          SizedBox(width: Dimensitions.width7,),
                        SvgPicture.asset("assets/icons/down-arrow.svg",height: Dimensitions.height23,color: colors.text3,)
                      ],
                    ),
                  ),
                )
                ),
                 SizedBox(width: Dimensitions.width20,),
                 Expanded(
                child: GestureDetector(
                  onTap: _showDatePicker,
                  child: Container(
                   
                    
                    height: Dimensitions.height50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensitions.height10),
                      border: Border.all(color: colors.text3)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                  
                      children: [
                          SizedBox(width: Dimensitions.width5,),
                  
                        Text(
                          _date !=""?
                            _date.split("?")[1]:
                          "Mois",
                          style: GoogleFonts.openSans(
                            fontSize: Dimensitions.width15,
                            fontWeight: FontWeight.w500,
                            color: colors.text
                          ),
                          
                          ),
                          SizedBox(width: Dimensitions.width7,),
                        SvgPicture.asset("assets/icons/down-arrow.svg",height: Dimensitions.height23,color: colors.text3,)
                      ],
                    ),
                  ),
                )
                ),
                 SizedBox(width: Dimensitions.width20,),
                 Expanded(
                child: GestureDetector(
                  onTap: _showDatePicker,
                  child: Container(
                  
                   
                    height: Dimensitions.height50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensitions.height10),
                      border: Border.all(color: colors.text3)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          SizedBox(width: Dimensitions.width5,),
                        Text(
                          _date !=""?
                          _date.split("?")[2]:
                          "Année",
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
                )
                ),
            ],
           ),
          
             SizedBox(height: Dimensitions.height20,),
          
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
           
            margin: EdgeInsets.only(bottom: Dimensitions.height50),
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
          
          
            ],
          ),
        ),
      ),
    );
  
  }
}