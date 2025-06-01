import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diva/compoents/home/app_bar.dart';
import 'package:diva/compoents/profile/text_from_field.dart';
import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';



// ignore: must_be_immutable
class contacterEWom extends StatelessWidget {
  final String email;
  final String name;
   contacterEWom({super.key,required this.email,required this.name});
  TextEditingController _controller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:MyAppBar(
        tit: "Contacter e-wom",
        fn:true,
        ),
      backgroundColor: colors.bg,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensitions.width25),
          child: Column(
            children: [
           SizedBox(height: Dimensitions.height20,),
             MyProfileTextField(
              initialValue: name,
              readOnly: true,
              label: "Nom d'utilisateur",
              fillColor: colors.bg,
              maxLength: 25,
              textInputAction: TextInputAction.next,
             ),
             MyProfileTextField(
              initialValue: email,
              readOnly: true,
              label: "Adresse Email",
              fillColor: colors.bg,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'\s')),
              ],
              textInputAction: TextInputAction.next,
             ),
             MyProfileTextField(
              colorBorder: colors.rose3,
              label: "Message",
              fillColor: Colors.white,
              hintText: "Votre feedback ici...",
              textInputAction: TextInputAction.done,
              controller: _controller,
             ),
             SizedBox(
              height: Dimensitions.height130,
             ),
             GestureDetector(
              onTap: () async{
                if (_controller.text.trim().isNotEmpty) {
                  await FirebaseFirestore.
                instance.
                collection("feedbacks").
                add({
                  "email":email,
                  "name":name,
                  "message":_controller.text,
                });
                Get.back(id: 4);
                  Get.snackbar(
                      "Succès", 
                      "Votre feedback a été reçu. Merci de nous aider à nous améliorer !",
                      backgroundColor: colors.sp,
                      snackPosition: SnackPosition.BOTTOM,
                      colorText: Colors.white,
                      );
                }

                
              },
               child: Container(
                margin: EdgeInsets.only(bottom: Dimensitions.height20),
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
                          child: Text("Envoyer",style: GoogleFonts.openSans(
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
      ),
    );
  
  }
}