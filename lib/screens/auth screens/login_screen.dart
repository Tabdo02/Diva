import 'package:diva/auth_Firestor/users.dart';
import 'package:diva/class/users.dart';
import 'package:diva/compoents/auth/button_auth.dart';
import 'package:diva/compoents/auth/customTextField.dart';
import 'package:diva/provider/account/user_provider.dart';
import 'package:diva/provider/home/category_provider.dart';
import 'package:diva/routes/route_helper.dart';
import 'package:diva/services/sigin_signup_google.dart';
import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {
   SignIn({super.key});
  final formKey =GlobalKey<FormState>();
  final _emailController =TextEditingController();
  final _passwordController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.bg,
      body: SingleChildScrollView(
        child: Form(
          key:formKey,
          child: Column(
                 
            children: [
             Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensitions.width26),
               child: Column(
                children: [
                   SizedBox(height: Dimensitions.height55,),
               
             // logo
                 Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensitions.width60),
              child: SvgPicture.asset("assets/Logo/logo_pink.svg",height: Dimensitions.height100,)),
                SizedBox(height: Dimensitions.height5,),
                Container(
                
                  height: Dimensitions.height40,
                  margin: EdgeInsets.symmetric(horizontal: Dimensitions.width80),
                  decoration:const BoxDecoration(
                    image: DecorationImage(image:AssetImage("assets/Logo/LOG.png") ,fit: BoxFit.contain
                    )
                  ),
                ),
                    
                    
                // my custom text field 
                SizedBox(height: Dimensitions.height15,),
          
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
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  onSubmitted: () {
                    FocusScope.of(context).nextFocus();
                  },
                  ),
                  SizedBox(height: Dimensitions.height5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                    GestureDetector(
                      onTap: () { 
                        if(_emailController.text=="") return;
                          AuthFirestore().resetPassword(_emailController.text, context,true);
                           
                            Get.toNamed(RouteHelper.getPassword(_emailController.text)
                              );
                              //()=> ResetPassword(email:_emailController.text,)
                        },
                      child: Text("Mot de passe oublié?",
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
                  
                  SizedBox(height: Dimensitions.height25,),
              // btn Inscrire
              ButtonWelcome(name: "Connecté",
              onTap: () {
                 final isVallid=formKey.currentState!.validate();
                 if (!isVallid) return;
                 Provider.of<userProvider>(context,listen: false).clearEverything();
                 Provider.of<CategoryProvider>(context,listen: false).clearSwitch();
                 AuthFirestore().signIn(
                  EUsers(email: _emailController.text, password: _passwordController.text,), 
                context
                );
                },
              isBold: false,
              ),
                  
              SizedBox(height: Dimensitions.height15,),
                  
              // text vous avez deja un compte
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text("vous n'avez pas de compte? ",
               style: GoogleFonts.openSans(
                textStyle:TextStyle(
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w600,
                  fontSize: Dimensitions.width15,
                ),
               ),
              ),
               GestureDetector(
                onTap: ()=>Get.offNamed(RouteHelper.getsignUp()),

                 child: Text("Créez ici",
                 style: GoogleFonts.openSans(
                  textStyle:TextStyle(
                    color: colors.rose4,
                    fontWeight: FontWeight.w600,
                    fontSize: Dimensitions.width15,
                  ),
                 ),
                             ),
               ),
          
                  
              ],),
              SizedBox(height: Dimensitions.height20,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal:Dimensitions.width42 ),
                  child: Container(height: Dimensitions.height1_5,color: colors.rose4,),
                ),
              SizedBox(height: Dimensitions.height25,),
              _myButton(
                name: "Connecté",
                onTap: () {
                 Provider.of<userProvider>(context,listen: false).clearEverything();
                 Provider.of<CategoryProvider>(context,listen: false).clearSwitch();
                  AuthServices().signInWithGoogle();
                  },
              ),
              
            ],
          ),
        ),
      ),
    );
  }
  Widget _myButton({required void Function()? onTap,required String name}){
     return Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensitions.width100),
            child: GestureDetector(
              onTap: onTap,
              child: Container(
               
                decoration: BoxDecoration(
                color: colors.google,
                borderRadius: BorderRadius.circular(Dimensitions.width10)
              
                ),
                height: Dimensitions.height40,
               
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: Dimensitions.width11,
                      backgroundImage: const AssetImage("assets/icons/google.png"),

                    ),
                    SizedBox(
                      width: Dimensitions.width10,
                    ),
                    Text(
                      name,
                      style: GoogleFonts.openSans(
                        textStyle:TextStyle(
                          color: Colors.white,
                          fontWeight:FontWeight.w500,
                          fontSize: Dimensitions.width16
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