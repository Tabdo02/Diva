import 'dart:math';
import 'package:diva/class/product.dart';
import 'package:diva/provider/account/user_provider.dart';
import 'package:diva/routes/route_helper.dart';
import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SearchWithFilter extends StatelessWidget {
   SearchWithFilter({super.key});
  final  List<String> csc=["Ville","Catégorie","Sous catégorie"];
   List<String> wilayas = [
    ".....",
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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.bg,
      body: Consumer<userProvider>(
        builder: (context, value, child) {
          return  SingleChildScrollView(
        child: Column(
          children: [
            // filtre
            Container(
                        margin: EdgeInsets.only(left: Dimensitions.width25,bottom: Dimensitions.height10,top:Dimensitions.height10, ),
                        height: Dimensitions.height30,
                        child: Center(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: csc.length,
                            itemBuilder: (context, index) {
                              return 
                              Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      value.updatedTapedList(wilayas, csc[index], context);
                                      value.showModalSheet(
                                        csc[index],
                                       );
                                    },
                                    
                                    child: index==2 && value.sousCateList.length>0?
                                     Container(
                                      margin: EdgeInsets.only(right: Dimensitions.width10),
                                                                    padding: EdgeInsets.symmetric(horizontal: Dimensitions.width5,vertical: Dimensitions.height2),
                                                                    decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensitions.height5),
                                    border: Border.all(color: colors.purpel1,),
                                    color: value.sousCategoryValue.isNotEmpty?colors.purpel1:colors.bg,
                                                                    ),
                                                                    child: Row(
                                    
                                    children: [
                                   
                                      Text(
                                     value.sousCategoryValue.isNotEmpty?
                                     value.sousCategoryValue
                                     :
                                        csc[index],
                                        style: GoogleFonts.openSans(
                                          color:value.sousCategoryValue.isNotEmpty?Colors.white: colors.purpel1,
                                          fontWeight: FontWeight.w400,
                                          fontSize: Dimensitions.width15
                                        ),
                                        ),
                                       
                                        
                                      SizedBox(width: Dimensitions.width5,),
                                      Transform.rotate(
                                        angle: -pi/2,
                                        child: Icon(Icons.arrow_back_ios,color:value.sousCategoryValue.isNotEmpty?Colors.white: colors.purpel1,size: Dimensitions.height15,)),
                                    ],
                                                                    ),
                                                                  )

                                    :
                                    index==2?
                                    Container()
                                    :
                                    Container(
                                      margin: EdgeInsets.only(right: Dimensitions.width10),
                                                                    padding: EdgeInsets.symmetric(horizontal: Dimensitions.width5,vertical: Dimensitions.height2),
                                                                    decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensitions.height5),
                                    border: Border.all(color: colors.purpel1,),
                                    color: 
                                    index==0?
                                    value.villeValue.isNotEmpty?colors.purpel1:colors.bg
                                    :
                                    value.categoryValue.isNotEmpty?colors.purpel1:colors.bg
                                    ,
                                                                    ),
                                                                    child: Row(
                                    
                                    children: [
                                      index==0?
                                      Text(
                                       value.villeValue.isNotEmpty?
                                        value.villeValue
                                       :
                                        csc[index],
                                        style: GoogleFonts.openSans(
                                          color: value.villeValue.isNotEmpty?Colors.white:colors.purpel1,
                                          fontWeight: FontWeight.w400,
                                          fontSize: Dimensitions.width15
                                        ),
                                        ):Container(),
                                        index==1?
                                      Text(
                                       value.categoryValue.isNotEmpty?
                                        value.categoryValue
                                       :
                                        csc[index],
                                        style: GoogleFonts.openSans(
                                          color: value.categoryValue.isNotEmpty?Colors.white:colors.purpel1,
                                          fontWeight: FontWeight.w400,
                                          fontSize: Dimensitions.width15
                                        ),
                                        ):Container(),
                                      
                                      SizedBox(width: Dimensitions.width5,),
                                      Transform.rotate(
                                        angle: -pi/2,
                                        child: Icon(Icons.arrow_back_ios,
                                        color:  index==0?
                                        value.villeValue.isNotEmpty?Colors.white:colors.purpel1
                                        :
                                        value.categoryValue.isNotEmpty?Colors.white:colors.purpel1,
                                        size: Dimensitions.height15,
                                        )
                                        ),
                                    ],
                                                                    ),
                                                                  ),
                                  ),
                              
                                ],
                              );
                              
                            },
                            ),
                        ),
                      ),
           
            // second filter
             _SwithchPS(context),
             // results 

             // boutiques 
        value.searchSwitch !="Boutique"?
        Container()
        :    
        Padding(
              padding:  EdgeInsets.only(top: Dimensitions.height15,right: Dimensitions.width25,left: Dimensitions.width25),
              child: Column(
                        children: value.searchBoutique.map(
              (e) {
                return GestureDetector(
                  onTap: () {
                    value.clearOther();
                    value.changeBoutiqueId(e[0].docId);
                    value.getOtherFollowers(e[0].docId);
                    value.getOtherFollowing(e[0].usDocID);
                    Get.toNamed(RouteHelper.getBoutiqueProfile(e[0]),id: 1);
                  } ,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensitions.width10,vertical: Dimensitions.height10),
                    margin: EdgeInsets.only(bottom: Dimensitions.height15),
                    height: Dimensitions.height110,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Dimensitions.height10),
                      boxShadow: [
                         BoxShadow(
                              color: colors.shadow.withOpacity(0.1),
                              blurRadius: 5,
                              offset: Offset(0, 0)
                            ),
                      ]
                    ),
                    child: 
                  Stack(
                    children: [
                        Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: Dimensitions.width10),
                          width: Dimensitions.width90,
                          decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensitions.height10),
                            image:e[0].profilPicture !=""?
                             DecorationImage(image: NetworkImage(e[0].profilPicture),fit: BoxFit.fill):
                             DecorationImage(image: AssetImage("assets/images/img.png"),fit: BoxFit.fill),
                            color: Colors.white,
                             boxShadow: [
                      BoxShadow(
                              
                              color: colors.sp.withOpacity(0.3),
                              blurRadius: 6,
                              offset: Offset(0, 0)
                            ),
                      ]
                          ),
                         
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                overflow: TextOverflow.ellipsis,
                                e[0].name,
                                style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w600,
                                  fontSize: Dimensitions.width16,
                                ),
                                ),
                              SizedBox(height: Dimensitions.height5,),
                              Text(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                e[0].bio,
                                 style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w300,
                                  fontSize: Dimensitions.width12,
                                  color: colors.text2
                                ),
                                ),
                          
                          
                            ],
                          ),
                        ),
              
                   value.boutique!=null &&  value.boutique!.docId==e[0].docId       ?   
                   Container()
                   :
                   Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                   GestureDetector(
                                     onTap: () {
                                           int index = value.searchBoutique.indexOf(e);
                                           value.showSignaler2(index);
                                              },
                                    child:
                                    SvgPicture.asset("assets/icons/dots-3.svg",height: Dimensitions.height15,color: colors.purpel3,)),
                    GestureDetector(
                  onTap: () => value.addRemoveFavoritBoutique(e[0].docId),
                   child: SvgPicture.asset(value.favoritBoutique.contains(e[0].docId)?
                   "assets/icons/heart filled.svg"
                   :
                    "assets/icons/favorite_24dp_FILL0_wght400_GRAD0_opsz24.svg",
                   height: value.favoritBoutique.contains(e[0].docId)?Dimensitions.height15: Dimensitions.height19,
                   color: colors.purpel3,
                   ),
                 )
                                ],
                              ),
                      ],
                    ),
                   value.boutique!=null &&  value.boutique!.docId!=e[0].docId &&   e[1]?  Positioned(
                          right: Dimensitions.width8,
                          top: Dimensitions.height15,
                          child: GestureDetector(
                            onTap: () {
                              int index = value.searchBoutique.indexOf(e);
                              value.showSignaler2(index);
                            },
                            child: Container(
                              width: Dimensitions.width150,
                              height: Dimensitions.height45,
                               decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(Dimensitions.height3),
                                              boxShadow: [
                                                 BoxShadow(
                                        color: colors.shadow.withOpacity(0.1),
                                        blurRadius: 5,
                                        offset: Offset(0, 0)
                                      ),
                                              ]
                                            ),
                                            child: Row(
                                              children: [
                                                SizedBox(width: Dimensitions.width15,),
                                                Text(
                            "Signaler",
                            style: GoogleFonts.openSans(
                              color: Colors.red,
                              fontSize: Dimensitions.width13,
                              fontWeight: FontWeight.w500
                            ),
                            ),
                                              ],
                                            ),
                            ),
                          )
                          ):Container(),
                    ],
                  )
                  ),
                );
              },
                        )
                        .toList().cast<Widget>(),
                      ),
            ),
        
        value.searchSwitch !="Produits"?
        Container()
        :Padding(
          padding:  EdgeInsets.only(top: Dimensitions.height15,right: Dimensitions.width25,left: Dimensitions.width25),
          child: Column(
            children: buildRows(value.searchProducts),
          ),
        ),
         value.searchSwitch !="Services"?
        Container()
        :Padding(
          padding:  EdgeInsets.only(top: Dimensitions.height15,right: Dimensitions.width25,left: Dimensitions.width25),
          child: Column(
            children: buildRows(value.searchServices),
          ),
        ),
          ],
        ),
      );
    
        },
        ),
     
    );
  }
  List<Widget> buildRows(List<dynamic> items) {
    List<Widget> rows = [];
    for (int i = 0; i < items.length; i += 2) {
      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildItemContainer(items[i]),
            if (i + 1 < items.length) buildItemContainer(items[i+1]) else SizedBox(width: Dimensitions.width145), // Placeholder for spacing
          ],
        ),
      );
      rows.add(SizedBox(height: Dimensitions.height10)); // Space between rows
    }
    return rows;
  }

  Widget buildItemContainer(dynamic p) {
    return GestureDetector(
       onTap: () => Get.toNamed(RouteHelper.getProductDetails(
                            Products(
                              boutiqueId: p[1]["idBoutique"], 
                              descriptiont: p[1]["description"], 
                              iamges: p[1]["images"], 
                              name: p[1]["name"], 
                              price: p[1]["price"], 
                              productId: p[1].id, 
                              promotion: p[1]["promotion"], 
                              pubs: p[1]["pubs"], 
                              rating: p[1]["rating"]
                              )
                          )),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal:Dimensitions.width10),
        margin: EdgeInsets.only(bottom: Dimensitions.height10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.11),
              blurRadius: 8,
              offset: Offset(0, 0),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensitions.height10),
        ),
        height: Dimensitions.height180,
        width: Dimensitions.width150,
        child: Column(
          children: [
            SizedBox(height:Dimensitions.height5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: Dimensitions.height16,
                      width:Dimensitions.width16,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.25),
                            blurRadius: 8,
                            offset: Offset(0, 0),
                          ),
                        ],
                        shape: BoxShape.circle,
                        image:p[0]["profileImage"]==""?
                        DecorationImage(image: AssetImage("assets/images/img.png"), fit: BoxFit.fill,)
                        :
                        DecorationImage(image: NetworkImage( p[0]["profileImage"]),fit: BoxFit.fill),
                      ),
                    ),
                    SizedBox(width: Dimensitions.width5),
                    SizedBox(
                      width: Dimensitions.width100,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        p[0]["name"],
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w600,
                          fontSize: Dimensitions.width12,
                        ),
                      ),
                    ),
                  ],
                ),
               
              ],
            ),
            SizedBox(height: Dimensitions.height3),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensitions.height10),
                  image: DecorationImage(
                    scale: 2, 
                    image: NetworkImage(p[1]["images"][0].toString()), 
                    fit: BoxFit.cover,),
      
                ),
                // child: false
                //     ? Stack(
                //         children: [
                //           Positioned(
                //             left: -7.0,
                //             top: 5.0,
                //             child: Container(
                //               height: 35.0,
                //               width: 55.0,
                //               decoration: BoxDecoration(
                //                   image: DecorationImage(
                //                       image: AssetImage(
                //                           "assets/icons/promotion.png"))),
                //               child: Center(
                //                 child: Text(
                //                   "150%",
                //                   style: GoogleFonts.openSans(
                //                     color: Colors.white,
                //                     fontWeight: FontWeight.w400,
                //                     fontSize: 12.0,
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ],
                //       )
                //     : SizedBox.shrink(),
              ),
            ),
            SizedBox(height: Dimensitions.height3),
            Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              p[1]["name"].toString(),
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.w400,
                fontSize: Dimensitions.width12,
                color: Colors.grey,
              ),
            ),
            SizedBox(height:Dimensitions.height3),
          ],
        ),
      ),
    );
  }

  Widget _SwithchPS(BuildContext context){
    final us = Provider.of<userProvider>(context,listen: false);
    return Row(
          children: [
            SizedBox(width: Dimensitions.width25,height: Dimensitions.height10,),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    us.searchSwitchPSB("Produits");
                  },
                  child: Text(
                    "Produits",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color:us.searchSwitch=="Produits"? colors.rose5:colors.text3,
                        fontWeight:us.searchSwitch=="Produits"?FontWeight.w600:FontWeight.w400,
                        fontSize:us.searchSwitch=="Produits"?Dimensitions.width16:Dimensitions.width13,
                      )
                    ),
                    ),
                ),
                
            us.searchSwitch=="Produits"?    Container(
                  height: Dimensitions.height2,
                  width: Dimensitions.width60,
                  decoration: BoxDecoration(

                  color: colors.rose6,
                  borderRadius: BorderRadius.circular(Dimensitions.height2)
                  ),
                 
                ):Container(),
              ],
            ),
            SizedBox(width: Dimensitions.width17,),
            Column(
              children: [
               
                GestureDetector(
                  onTap: () {
                  us.searchSwitchPSB("Services");
                  },
                  child: Text(
                    "Services",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                            color:us.searchSwitch=="Services"? colors.rose5:colors.text3,
                        fontWeight:us.searchSwitch=="Services"?FontWeight.w600:FontWeight.w400,
                        fontSize:us.searchSwitch=="Services"?Dimensitions.width16:Dimensitions.width13,
                      )
                    ),
                    ),
                ),
             us.searchSwitch=="Services"? Container(
                  height: Dimensitions.height2,
                  width: Dimensitions.width60,
                  decoration: BoxDecoration(

                  color: colors.rose6,
                  borderRadius: BorderRadius.circular(Dimensitions.height2)
                  ),
                 
                ):Container(),
              ],
            ),
            SizedBox(width: Dimensitions.width17,),
 Column(
              children: [
               
                GestureDetector(
                  onTap: () {
                  us.searchSwitchPSB("Boutique");
                  },
                  child: Text(
                    "Boutique",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color:us.searchSwitch=="Boutique"? colors.rose5:colors.text3,
                        fontWeight:us.searchSwitch=="Boutique"?FontWeight.w600:FontWeight.w400,
                        fontSize:us.searchSwitch=="Boutique"?Dimensitions.width16:Dimensitions.width13,
                      )
                    ),
                    ),
                ),
               us.searchSwitch=="Boutique"? Container(
                  height: Dimensitions.height2,
                  width: Dimensitions.width70,
                  decoration: BoxDecoration(

                  color: colors.rose6,
                  borderRadius: BorderRadius.circular(Dimensitions.height2)
                  ),
                 
                ):Container(),
              ],
            ),

          ],
          )
        ;

  }
}