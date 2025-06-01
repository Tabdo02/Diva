import 'dart:math';
import 'package:diva/class/product.dart';
import 'package:diva/compoents/home/app_bar.dart';
import 'package:diva/provider/account/user_provider.dart';
import 'package:diva/routes/route_helper.dart';
import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class FavorisPage extends StatefulWidget {
  const FavorisPage({super.key});

  @override
  State<FavorisPage> createState() => _FavorisPageState();
}

class _FavorisPageState extends State<FavorisPage> {
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
     List<String> csc =["Ville","Catégorie","Sous catégorie"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final value = Provider.of<userProvider>(context,listen: false);
    if (value.favoritBoutique.length>0 && value.likedBoutique.length==0) {
            value.getLikedBoutiques();
          }
          if (value.favoritProducts.length>0 && value.likedProduct.length==0 && value.likedService.length==0 ) {
            value.getLikedProduct(context);
          }
  }
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar:MyAppBar(
        tit: "Favoris",
        fn:true,
        ),
      backgroundColor: colors.bg,
      body: Consumer<userProvider>(
        builder: (context, value, child) {
          return SingleChildScrollView(
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
                                      value.updatedFavoritTapedList(wilayas, csc[index], context);
                                      value.showModalSheet3(csc[index],);
                                    },
                                    child: index==2 && value.favoritSousCateList.length>0?
                                     Container(
                                      margin: EdgeInsets.only(right: Dimensitions.width10),
                                            padding: EdgeInsets.symmetric(horizontal: Dimensitions.width5,vertical: Dimensitions.height2),
                                            decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimensitions.height5),
                                            border: Border.all(color: colors.purpel1,),
                                            color: value.favoritSousCateValue.isNotEmpty?colors.purpel1:colors.bg,
                                                                    ),
                                        child: Row(
                                          children: [
                                              Text(
                                            value.favoritSousCateValue.isNotEmpty?
                                            value.favoritSousCateValue
                                            :
                                                csc[index],
                                                style: GoogleFonts.openSans(
                                                  color:value.favoritSousCateValue.isNotEmpty?Colors.white: colors.purpel1,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: Dimensitions.width15
                                                ),
                                                ),
                                                  SizedBox(width: Dimensitions.width5,),
                                                  Transform.rotate(
                                                    angle: -pi/2,
                                                    child: Icon(Icons.arrow_back_ios,color:value.favoritSousCateValue.isNotEmpty?Colors.white: colors.purpel1,size: Dimensitions.height15,)),
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
                                    value.favoritVilleValue.isNotEmpty?colors.purpel1:colors.bg
                                    :
                                    value.favoritCategoryValue.isNotEmpty?colors.purpel1:colors.bg,
                                          ),
                                    child: Row(
                                    children: [
                                      index==0?
                                      Text(
                                       value.favoritVilleValue.isNotEmpty?
                                        value.favoritVilleValue
                                       :
                                        csc[index],
                                        style: GoogleFonts.openSans(
                                          color: value.favoritVilleValue.isNotEmpty?Colors.white:colors.purpel1,
                                          fontWeight: FontWeight.w400,
                                          fontSize: Dimensitions.width15
                                        ),
                                        ):Container(),
                                        index==1?
                                      Text(
                                       value.favoritCategoryValue.isNotEmpty?
                                        value.favoritCategoryValue
                                       :
                                        csc[index],
                                        style: GoogleFonts.openSans(
                                          color: value.favoritCategoryValue.isNotEmpty?Colors.white:colors.purpel1,
                                          fontWeight: FontWeight.w400,
                                          fontSize: Dimensitions.width15
                                        ),
                                        ):Container(),
                                      
                                      SizedBox(width: Dimensitions.width5,),
                                      Transform.rotate(
                                        angle: -pi/2,
                                        child: Icon(Icons.arrow_back_ios,
                                        color:  index==0?
                                        value.favoritVilleValue.isNotEmpty?Colors.white:colors.purpel1
                                        :
                                        value.favoritCategoryValue.isNotEmpty?Colors.white:colors.purpel1,
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
              // swithch
             _SwithchPS(),
              SizedBox(height: Dimensitions.height10,),
              IndexedStack(
                index: value.favoritIndex,
                children: [
                  //produit
                      Padding(
                      padding:  EdgeInsets.only(top: Dimensitions.height15,right: Dimensitions.width25,left: Dimensitions.width25),
                      child: Column(
                     children: buildRows(value.likedProduct),
                      ),
                    ),
                  // service
                    Padding(
                      padding:  EdgeInsets.only(top: Dimensitions.height15,right: Dimensitions.width25,left: Dimensitions.width25),
                      child: Column(
                     children: buildRows(value.likedService),
                      ),
                    )
                  ,
                  // boutique
                   Padding(
                      padding:  EdgeInsets.only(top: Dimensitions.height15,right: Dimensitions.width25,left: Dimensitions.width25),
                      child: Column(
                                children: 
                                value.likedBoutique.map(
                      (e) {
                        
                        return GestureDetector(
                          onTap: () {
                            value.clearOther();
                            value.changeBoutiqueId(e[0].docId);
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
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          
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
                         
                            ],
                          )
                          ),
                        );
                      },
                                )
                                .toList().cast<Widget>(),
                              
                              ),
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
  Widget _SwithchPS(){
    return Row(
          children: [
            SizedBox(width: Dimensitions.width25,),
            Column(
              children: [
                GestureDetector(
                   onTap: () =>Provider.of<userProvider>(context,listen: false).updateFavoritIndex("Produits"),
                  child: Text(
                    "Produits",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color: Provider.of<userProvider>(context,listen: false).favoritIndex==0?colors.rose5:colors.text3,
                        fontWeight: Provider.of<userProvider>(context,listen: false).favoritIndex==0?FontWeight.w600:FontWeight.w400,
                        fontSize:Provider.of<userProvider>(context,listen: false).favoritIndex==0? Dimensitions.width16:Dimensitions.width13,
                      )
                    ),
                    ),
                ),
                
                 Provider.of<userProvider>(context,listen: false).favoritIndex==0?  Container(
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
                  onTap: () =>Provider.of<userProvider>(context,listen: false).updateFavoritIndex("Services"),
                  child: Text(
                    "Services",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color:  Provider.of<userProvider>(context,listen: false).favoritIndex==1?colors.rose5:colors.text3,
                        fontWeight:Provider.of<userProvider>(context,listen: false).favoritIndex==1?FontWeight.w600:FontWeight.w400,
                        fontSize: Provider.of<userProvider>(context,listen: false).favoritIndex==1? Dimensitions.width16:Dimensitions.width13,
                      )
                    ),
                    ),
                ),
               Provider.of<userProvider>(context,listen: false).favoritIndex==1?  Container(
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
                  onTap: () =>Provider.of<userProvider>(context,listen: false).updateFavoritIndex("Boutique"),
                  child: Text(
                    "Boutique",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color:  Provider.of<userProvider>(context,listen: false).favoritIndex==2?colors.rose5:colors.text3,
                        fontWeight: Provider.of<userProvider>(context,listen: false).favoritIndex==2?FontWeight.w600:FontWeight.w400,
                        fontSize: Provider.of<userProvider>(context,listen: false).favoritIndex==2? Dimensitions.width16:Dimensitions.width13,
                      )
                    ),
                    ),
                ),
                Provider.of<userProvider>(context,listen: false).favoritIndex==2?  Container(
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
        width: Dimensitions.height145,
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
                // child:Stack(
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
                //                   "${double.parse(p[1]["promotion"]["percentage"].toString()).round().toString()}%",
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
                //       ),
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

}