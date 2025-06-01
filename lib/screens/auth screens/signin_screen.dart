import 'package:diva/auth_Firestor/users.dart';
import 'package:diva/class/users.dart';
import 'package:diva/compoents/auth/button_auth.dart';
import 'package:diva/compoents/auth/customTextField.dart';
import 'package:diva/provider/account/user_provider.dart';
import 'package:diva/provider/home/category_provider.dart';
import 'package:diva/routes/route_helper.dart';
import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
   SignUp({super.key});
   final formKey =GlobalKey<FormState>();

  final _nomController =TextEditingController();
  final _emailController =TextEditingController();
  final _passwordController =TextEditingController();
  final _confirmeController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.bg,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
                 
            children: [
             Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensitions.width26),
               child: Column(
                children: [
                SizedBox(height: Dimensitions.height70,),
                // text Create a new account
                Row(
                  children: [
                    Text("Créer un compte",
                     style: GoogleFonts.openSans(
                      textStyle:TextStyle(
                        color: colors.text,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensitions.width25,
                      ),
                     ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensitions.height10,),
                // my custom text field 
                // nom
                CustomTextField(
                  validator: (value)=>value =="" ?'Entrez un nom svp':null,
                  label: "Nom",
                  controller: _nomController,
                   textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  onSubmitted: () {
                    FocusScope.of(context).nextFocus();
                  },
                
                  ),
                SizedBox(height: Dimensitions.height10,),
          
                // email 
                CustomTextField(
                    validator: (email)=> email !=null &&  !EmailValidator.validate(email) ?'Entrer un email valide':null,
          
                  label: "Email",
                  controller: _emailController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [ FilteringTextInputFormatter.deny(RegExp(r"\s")),],
                  onSubmitted: () {
                    FocusScope.of(context).nextFocus();
                  },
                  ),
                SizedBox(height: Dimensitions.height10,),
                // mdps
                CustomTextField(
                  validator: (value)=>value !=null && value.length<6?'Entrez au moins 6 caractères':null,
                  label: "Mot de passe",
                  controller: _passwordController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  onSubmitted: () {
                    FocusScope.of(context).nextFocus();
                  },
                  ),
                SizedBox(height: Dimensitions.height10,),
                    
                // confirme mdps
                CustomTextField(
                  validator: (value)=>value !=null && value !=_passwordController.text?'le mot de passe ne correspond pas':null,
          
                  label: "Confirmez votre Mot de passe",
                  controller: _confirmeController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                 
                  ),
                ],
               ),
             ),
                  
                  SizedBox(height: Dimensitions.height30,),
              // btn Inscrire
              ButtonWelcome(name: "Inscrire",
             onTap: () {
              final isVallid=formKey.currentState!.validate();
               if (!isVallid) return;
               Provider.of<userProvider>(context,listen: false).clearEverything();
               Provider.of<CategoryProvider>(context,listen: false).clearSwitch();
               EUsers us =  EUsers(email: _emailController.text, password: _passwordController.text,name: _nomController.text);
               AuthFirestore().signUp(us,context);
             },
              isBold: false,
              ),
                  
              SizedBox(height: Dimensitions.height20,),
                  
              // text vous avez deja un compte
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text("Vous avez déjà un compte? ",
               style: GoogleFonts.openSans(
                textStyle:TextStyle(
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w600,
                  fontSize: Dimensitions.width15,
                ),
               ),
              ),
               GestureDetector(
                onTap: ()=>Get.offNamed(RouteHelper.signIn),
                 child: Text("Connectez ici",
                 style: GoogleFonts.openSans(
                  textStyle:TextStyle(
                    color: colors.rose4,
                    fontWeight: FontWeight.w600,
                    fontSize: Dimensitions.width15,
                  ),
                 ),
                             ),
               ),
                  
              ],)
              
            ],
          ),
        ),
      ),
    );
  }
}