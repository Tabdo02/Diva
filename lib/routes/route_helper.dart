import 'dart:convert';
import 'package:diva/class/boutique.dart';
import 'package:diva/class/product.dart';
import 'package:diva/class/users.dart';
import 'package:diva/screens/auth%20screens/auth%20other%20page/reset_password.dart';
import 'package:diva/screens/auth%20screens/login_screen.dart';
import 'package:diva/screens/auth%20screens/signin_screen.dart';
import 'package:diva/screens/category/category.dart';
import 'package:diva/screens/category/sCategory.dart';
import 'package:diva/screens/home/home_screen.dart';
import 'package:diva/screens/home/home_toggle.dart';
import 'package:diva/screens/home/pages/app%20bar%20page/favoris_page.dart';
import 'package:diva/screens/home/pages/app%20bar%20page/notification_page.dart';
import 'package:diva/screens/home/pages/home.dart';
import 'package:diva/screens/home/pages/profile/boutique_profile.dart';
import 'package:diva/screens/home/pages/profile/centre_d_aide.dart';
import 'package:diva/screens/home/pages/profile/confi.dart';
import 'package:diva/screens/home/pages/profile/contacter_e_wom.dart';
import 'package:diva/screens/home/pages/profile/devenir/deveir_purchase.dart';
import 'package:diva/screens/home/pages/profile/devenir/formulatir.dart';
import 'package:diva/screens/home/pages/profile/inforamtion_personelle.dart';
import 'package:diva/screens/home/pages/profile/mon_reseau.dart';
import 'package:diva/screens/home/pages/profile/qr_code.dart';
import 'package:diva/screens/home/product/product_details.dart';
import 'package:diva/screens/home/search/search.dart';
import 'package:diva/screens/home/search/search_with_filter.dart';
import 'package:diva/screens/welcome%20screens/toggle_welcome_login.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial="/";
  static const String signUp="/sign-up";
  static const String signIn="/sign-in";
  static const String password="/password";
  static const String homeToggle="/homeToggle";
  static const String home="/home";
  static const String favorit="/favorit";
  static const String notification="/notification";
  static const String account="/account";
  static const String infoPerso="/info-perso";
  static const String monResau="/mon-Reseau";
  static const String contacterEwom="/contacter-Ewom";
  static const String confi="/confidentialiti";
  static const String centerAide="/centre-daide";
  static const String monQr="/mon-QR";
  static const String search="/search";
  static const String sousCate="/sous-Cate";
  static const String productDetai="/products-details";
  static const String formulaire="/formulaire";
  static const String devenir="/devenir";
  static const String boutiqueProfile="/boutique-profile";
  static const String subCategory="/sub-category";
  static const String searchWithFilter="/search-with-filter";




  // intial pagge
  static String getinitial()=>'$initial';
  // auth pages
  static String getsignUp()=>'$signUp';
  static String getsignIn()=>'$signIn';
  static String getPassword(String email)=>'$password?email=$email';
  //Home 
  static String getHomeToggle()=>homeToggle;
  static String getHome(bool isv)=>'$home?state=$isv';
  // app bar page
  static String getFavorit()=>favorit;
  // app bar page
  static String getNotification()=>notification;
  static String getAccount()=>account;
  static String getSearch()=>search;
static String getSousCate(String title, List<dynamic> sCate) {
  // Convert the list to a comma-separated string
  String sCateString = sCate.join(',');
  return '$sousCate?title=$title&sCate=$sCateString';
}

  //account
  static String getInfoPerson(EUsers us) {
  // Encode the EUsers object to a format that can be passed in the URL
  String encodedUs = jsonEncode(us.toJson()); // Using jsonEncode for simplicity
  return '$infoPerso?us=$encodedUs';
}
  static String getMonResua()=>monResau;
  static String getContacterEWom(String email,String name)=>"$contacterEwom?email=$email&name=$name";
  static String getConfiden()=>confi;
  static String getCentreDaide()=>centerAide;
  static String getMonQR(String name, String image)=>"$monQr?name=$name&image=$image";
  static String getFormulaire(String docId,String image)=>'$formulaire?docId=$docId&image=$image';
  static String getDevenir(String mode,String docId,String usdocId)=>'$devenir?mode=$mode&docId=$docId&usdocId=$usdocId';
  static String getSubCategory(String cate,String sCate)=>'$subCategory?category=$cate&sub=$sCate';
  // product details
  static String getProductDetails(Products p){
    String encodedUs = jsonEncode(p.toJson());
    return '$productDetai?product=$encodedUs';
  }
  
  // profile boutique
  //static String getBoutiqueProfile(bool owner) =>'$boutiqueProfile?owner=$owner';
    static String getBoutiqueProfile(Boutique boutique){
        String encodedUs = jsonEncode(boutique.toJson()); 
        return '$boutiqueProfile?boutique=$encodedUs';
      }
      static String getSearchWithFilter()=>searchWithFilter;
// routes
  static List<GetPage> routes =[
    // initial
    GetPage(name: initial, page:()=> ToggleWelcomeLogin(),transition:Transition.fade,transitionDuration: Duration(milliseconds: 150) ),
    //auth page
    GetPage(name:signUp, page:()=> SignUp(),transition: Transition.fade,transitionDuration: Duration(milliseconds: 150)),
    GetPage(name:signIn, page:()=> SignIn(),transition: Transition.fade,transitionDuration: Duration(milliseconds: 150)),
    GetPage(
      name:password, 
      page:(){
        var email =Get.parameters['email'];
        return  ResetPassword(email:email!.toString(),);
      },
      transition: Transition.fade
      ,transitionDuration: Duration(milliseconds: 150)
      ),
    // home
    GetPage(name: homeToggle, page:()=> HomeToggle(),transition:Transition.downToUp,transitionDuration: Duration(milliseconds: 150)),
    GetPage(name: home, page:(){
       var isvParam = Get.parameters['state'];
       bool isv = isvParam == 'true'; 
      return Home(
        isv: isv,
      );
    } ,transition: Transition.fade,transitionDuration: Duration(milliseconds: 150)
    ),
    GetPage(name: search, page:()=> MySearch(),transition: Transition.rightToLeftWithFade,transitionDuration: Duration(milliseconds: 150)),
    //app bar page
    GetPage(name: favorit, page:()=> FavorisPage(),transition: Transition.rightToLeftWithFade,transitionDuration: Duration(milliseconds: 150)),
    GetPage(name: notification, page:()=> MyNotification(),transition: Transition.rightToLeftWithFade,transitionDuration: Duration(milliseconds: 150)),
    GetPage(name: account, page:()=> Accuiel(),transition: Transition.fade,transitionDuration: Duration(milliseconds: 150)),
    GetPage(
      name: infoPerso, 
      page:(){
 EUsers us = EUsers.fromJson(jsonDecode(Get.parameters['us']!));
     
    return   informationPersonelle(us:us ,);
      } ,
      transition: Transition.rightToLeftWithFade,transitionDuration: Duration(milliseconds: 150)
      ),
    GetPage(name: monResau, page:()=> MonReseau(),transition: Transition.rightToLeftWithFade,transitionDuration: Duration(milliseconds: 150)),
    
    GetPage(name: contacterEwom, page:(){
        var email =Get.parameters['email'];
        var name =Get.parameters['name'];
      return contacterEWom(
        email: email!,
        name: name!,
      );
    } ,transition: Transition.rightToLeftWithFade,transitionDuration: Duration(milliseconds: 150)
    ),
    
    GetPage(name: confi, page:()=> confidentialite(),transition: Transition.rightToLeftWithFade,transitionDuration: Duration(milliseconds: 150)),
    GetPage(name: formulaire, page:(){
        var docId =Get.parameters['docId'];
        var image =Get.parameters['image'];

      return formulair(
        docId: docId!,
        image: image!,
      );
    } ,transition: Transition.rightToLeftWithFade,transitionDuration: Duration(milliseconds: 150)),

    GetPage(name: centerAide, page:()=> CentreDaide(),transition: Transition.rightToLeftWithFade,transitionDuration: Duration(milliseconds: 150)),
    GetPage(
      name: monQr, 
    page:(){
       var image =Get.parameters['image'];
        var name =Get.parameters['name'];
      return MyQRCode(
        image: image ??"",
        name: name!,
      );
    } ,
    transition: Transition.rightToLeftWithFade,transitionDuration: Duration(milliseconds: 150)
    ),
    // category
    GetPage(
      name: sousCate, 
      page:(){
        var title =Get.parameters['title'];
          return Category(title: title,);
      } ,
      transition: Transition.rightToLeftWithFade,transitionDuration: Duration(milliseconds: 150)
      ),
    // product
    GetPage(name: productDetai, page:(){
        Products boutique = Products.fromJson(jsonDecode(Get.parameters['product']!));
      return ProductDetails(
        products: boutique,
      );
    },transition: Transition.fade,transitionDuration: Duration(milliseconds: 150)),
    
    GetPage(
      name: devenir, 
    page:(){
       var  mode =Get.parameters['mode'];
       var  docId =Get.parameters['docId'];
       var  usdocId =Get.parameters['usdocId'];


      return DeveirPurchase(
        mode: mode!,
        docId: docId!,
        usDocId: usdocId!,
      );
    },
    transition: Transition.fade,transitionDuration: Duration(milliseconds: 150)),
    // boutique profile
    GetPage(
      name: boutiqueProfile, 
      page:(){
        Boutique boutique = Boutique.fromJson(jsonDecode(Get.parameters['boutique']!));
        return BoutiqueProfile(
          boutique: boutique,
        
        );

              },
    transition: Transition.fade,transitionDuration: Duration(milliseconds: 150)),


       
    GetPage(
      name: subCategory, 
    page:(){
       var  sub =Get.parameters['sub'];
       var  category =Get.parameters['category'];
      return SubCategory(
       Cate: category!,
       sCate: sub!,
      );
    },
    transition: Transition.fade,transitionDuration: Duration(milliseconds: 150)),

    GetPage(name: searchWithFilter, page:()=> SearchWithFilter(),transition: Transition.rightToLeftWithFade,transitionDuration: Duration(milliseconds: 150)),


  ];

}