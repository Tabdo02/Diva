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

class SubCategory extends StatefulWidget {
  final String Cate;
  final String sCate;
  const SubCategory({super.key,required this.Cate,required this.sCate});
  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  List<dynamic>? subBoutique;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:MyAppBar(
        tit: widget.Cate,
        fn:true,
        ),
      backgroundColor: colors.bg,
      body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Dimensitions.width25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
            widget.sCate,
            style: GoogleFonts.openSans(
              color: colors.text2,
              fontSize: Dimensitions.width16,
              fontWeight: FontWeight.w300
            ),
            ),
          SizedBox(height: Dimensitions.height15,),
          Consumer<userProvider>(
            builder: (context, Boutique, child) {
              if (subBoutique == null) {
                Boutique.fetchAllboutique(widget.Cate, widget.sCate);
                subBoutique=Boutique.allBoutique;
              }
              return  subBoutique == null?
               Container(
              height: Dimensitions.height70,
              child: Center(
                child: CircularProgressIndicator(
                  color: colors.rose1,
                  strokeWidth: Dimensitions.width1,
                ),
              ),
            )
              : 
              Column(
          children: subBoutique!.map(
            (e) {
              return GestureDetector(
                onTap: () {
                  Boutique.clearOther();
                  Boutique.changeBoutiqueId(e[0].docId);
                  Boutique.getOtherFollowers(e[0].docId);
                  Boutique.getOtherFollowing(e[0].usDocID);
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
                        width: Dimensitions.width100,
                        height: Dimensitions.width110,
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

                 Boutique.boutique!=null &&  Boutique.boutique!.docId==e[0].docId       ?   
                 Container()
                 :
                 Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 GestureDetector(
                                   onTap: () {
                            int index = Boutique.allBoutique.indexOf(e);
                           Boutique.showSignaler(index);
                          },
                                  child:
                                  SvgPicture.asset("assets/icons/dots-3.svg",height: Dimensitions.height15,color: colors.purpel3,)),
                 
                 GestureDetector(
                  onTap: () => Boutique.addRemoveFavoritBoutique(e[0].docId),
                   child: SvgPicture.asset(Boutique.favoritBoutique.contains(e[0].docId)?
                   "assets/icons/heart filled.svg"
                   :
                    "assets/icons/favorite_24dp_FILL0_wght400_GRAD0_opsz24.svg",
                   height: Boutique.favoritBoutique.contains(e[0].docId)?Dimensitions.height15: Dimensitions.height19,
                   color: colors.purpel3,
                   ),
                 )
              
                              ],
                            ),
                   
                    ],
                  ),
                 Boutique.boutique!=null &&  Boutique.boutique!.docId!=e[0].docId &&   e[1]?  Positioned(
                        right: Dimensitions.width8,
                        top: Dimensitions.height15,
                        child: GestureDetector(
                          onTap: () {
                            int index = Boutique.allBoutique.indexOf(e);
                       
                           Boutique.showSignaler(index);
                           
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
        );

              
            },
            )
            ],
          ),
        ),
    );
  }
}