import 'package:diva/class/boutique.dart';
import 'package:diva/compoents/home/app_bar.dart';
import 'package:diva/provider/account/user_provider.dart';
import 'package:diva/routes/route_helper.dart';
import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';


class BoutiqueProfile extends StatefulWidget {
   final Boutique boutique;
   const BoutiqueProfile({super.key,required this.boutique});

  @override
  State<BoutiqueProfile> createState() => _BoutiqueProfileState();
}


class _BoutiqueProfileState extends State<BoutiqueProfile> {
 @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final us = Provider.of<userProvider>(context, listen: false);
      if (us.boutique !=null && us.boutique!.docId==widget.boutique.docId) {
      us.fetchProducts(us.boutique!.docId);
      // if (  
      //       us.scrollController.hasClients &&
      //       us.scrollController.position.pixels ==
      // us.scrollController.position.maxScrollExtent) {
      //  Future.delayed(Duration(milliseconds: 900),()=>us.loadMoreProducts(us.boutique!.docId));
      //    }
      }else{
        us.fetchOtherProducts(widget.boutique.docId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:MyAppBar(
        tit: "Profile",
        fn:true,
        ),
      backgroundColor: colors.bg,
      body: 
      Consumer<userProvider>(
        builder: (context, us, child) {

          return LiquidPullToRefresh(
            backgroundColor: colors.rose1,
            color: colors.rose2,
            height: Dimensitions.height70,
            showChildOpacityTransition: false,
            child: SingleChildScrollView(
            controller:widget.boutique.owner? us.scrollController:us.scrollController2,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensitions.width25),
              child: Column(
                children: [
                  SizedBox(height: Dimensitions.height8,),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: Dimensitions.width25),
                        height: Dimensitions.height70,
                        width: Dimensitions.height70,
                        decoration: BoxDecoration(
                          color: colors.rose1,
                          shape: BoxShape.circle,
                          image:widget.boutique.profilPicture==""?
                           DecorationImage(image: AssetImage("assets/images/img.png"),fit: BoxFit.cover)
              
                          :
                           DecorationImage(image: NetworkImage(widget.boutique.profilPicture),fit: BoxFit.cover)
                        ),
                      ),
                     Expanded(
      child: Container(
// Add some padding if needed
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align text to start
          children: [
            Text(
              widget.boutique.name,
              style: GoogleFonts.openSans(
                fontSize: Dimensitions.width16,
                fontWeight: FontWeight.w600,
                color: colors.text2,
              ),
              ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text:widget.boutique.bio,
                    style: GoogleFonts.openSans(
                fontSize: Dimensitions.width12,
                fontWeight: FontWeight.w400,
                color: colors.text3,
              ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
            
                    ],
                  ),

                  SizedBox(height: Dimensitions.height10,),
                  Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              
              Container(
                margin: EdgeInsets.only(right: Dimensitions.width25),
                              padding: EdgeInsets.symmetric(vertical: Dimensitions.height3,horizontal: Dimensitions.width17),
                              decoration: BoxDecoration(
                                color: colors.bg,
                                borderRadius: BorderRadius.circular(Dimensitions.height5),
                                border: Border.all(color: colors.rose1,),
                                boxShadow: [
                                  BoxShadow(
                                    color: colors.shadow.withOpacity(0.05),
                                    blurRadius: 2,
                                    offset: Offset(0,2),
                                  ),
                                   BoxShadow(
                                    color: colors.shadow.withOpacity(0.05),
                                    blurRadius: 2,
                                    offset: Offset(2,0),
                                  ),
                                   BoxShadow(
                                    color: colors.shadow.withOpacity(0.05),
                                    blurRadius: 2,
                                    offset: Offset(0,-2),
                                  ),
                                  BoxShadow(
                                    color: colors.shadow.withOpacity(0.05),
                                    blurRadius: 2,
                                    offset: Offset(-2,0),
                                  ),

                                ]
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(widget.boutique.owner?
                                  "Modifier":
                                    "Message",
                                    style: GoogleFonts.openSans(
                                      color: colors.text3,
                                      fontWeight: FontWeight.w300,
                                      fontSize: Dimensitions.width15
                                    ),
                                    ),
                                  SizedBox(width: Dimensitions.width3,),
                                  
                                ],
                              ),
                            ),
                     GestureDetector(
                      onTap: () {
                        if (!widget.boutique.owner) {
                            us.addRemoveFollowingList(
                              bid: widget.boutique.docId, 
                              imageB: widget.boutique.profilPicture, 
                              nameB: widget.boutique.name,
                              context: context
                              );
                              
                        }
                      },
                       child: Container(
                                padding: EdgeInsets.symmetric(vertical: Dimensitions.height3,horizontal: Dimensitions.width17),
                                decoration: BoxDecoration(
                                  color: us.isInFolowingList(widget.boutique.docId) != -1?Colors.white:colors.sp,
                                  borderRadius: BorderRadius.circular(Dimensitions.height5),
                                  border: Border.all(color: colors.sp,),
                                  boxShadow: [
                                    BoxShadow(
                                      color: colors.shadow.withOpacity(0.09),
                                      blurRadius: 2,
                                      offset: Offset(0,2),
                                    ),
                                     BoxShadow(
                                      color: colors.shadow.withOpacity(0.09),
                                      blurRadius: 2,
                                      offset: Offset(2,0),
                                    ),
                                     BoxShadow(
                                      color: colors.shadow.withOpacity(0.09),
                                      blurRadius: 2,
                                      offset: Offset(0,-2),
                                    ),
                                    BoxShadow(
                                      color: colors.shadow.withOpacity(0.09),
                                      blurRadius: 2,
                                      offset: Offset(-2,0),
                                    ),
                       
                                  ]
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.boutique.owner?
                                    "partagé":
                                      "Abonné",
                                      style: GoogleFonts.openSans(
                                        color:us.isInFolowingList(widget.boutique.docId) != -1 ?colors.sp : Colors.white,
                                        fontWeight: FontWeight.w300,
                                        fontSize: Dimensitions.width15
                                      ),
                                      ),
                                    SizedBox(width: Dimensitions.width3,),
                                    
                                  ],
                                ),
                              ),
                     ),
            ],
          ),
                  SizedBox(height: Dimensitions.height20,),
                  // fllower following products
                  Row(
            children: [
              SizedBox(
                width:  Dimensitions.listWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      Text(
                        widget.boutique.owner
                        ?
                        us.PublicationNumber
                        :
                        us.otherPublicationNumber,
                      style: GoogleFonts.openSans(
                        fontSize: Dimensitions.width19,
                        fontWeight: FontWeight.w600,
                        color: colors.text2
                      ),
                      ),
                    Text(
                      "Articles",
                      style: GoogleFonts.openSans(
                        fontSize: Dimensitions.width13,
                        fontWeight: FontWeight.w500,
                        color: colors.text3
                      ),
                      ),          
                  ],
                ),
              ), 
           Container(
            width: Dimensitions.width1,
            color: colors.sp,
            height: Dimensitions.height30,
           ),
             Container(
              width:  Dimensitions.listWidth,
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                       Text(
                        widget.boutique.owner?
                        us.followersList!.length.toString():
                        us.otherFollowers.toString(),
                     style: GoogleFonts.openSans(
                       fontSize: Dimensitions.width19,
                       fontWeight: FontWeight.w600,
                       color: colors.text2
                     ),),
                   Text(
                     "Abonnées",
                     style: GoogleFonts.openSans(
                       fontSize: Dimensitions.width13,
                       fontWeight: FontWeight.w500,
                       color: colors.text3
                     ),
                     ),
                 ],
               ),
             )
           ,
            Container(
            width: Dimensitions.width1,
            color: colors.sp,
            height: Dimensitions.height30,
           ),
             Container(
              width:  Dimensitions.listWidth,
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                     Text(
                      widget.boutique.owner?
                      us.followingList!.length.toString():
                      us.otherFollowing.toString(),
                     style: GoogleFonts.openSans(
                       fontSize: Dimensitions.width19,
                       fontWeight: FontWeight.w600,
                       color: colors.text2
                     ),),
                   Text(
                     "Abonnement",
                     style: GoogleFonts.openSans(
                       fontSize: Dimensitions.width13,
                       fontWeight: FontWeight.w500,
                       color: colors.text3
                     ),
                     ),
               
               
                 ],
               ),
             )
           ,
           
            ],
          ),
                  // horizantal separator
                  Container(
                  margin: EdgeInsets.symmetric(vertical: Dimensitions.height10,),
                  color: colors.sp,
                  height: Dimensitions.height1_5,
                ),
                  //liens 
                  widget.boutique.liens.length < 3
                  ?
                  _buildRow()
                  :
                  _buildListView(), 
                  SizedBox(height: Dimensitions.height13,),
                  _SwithchPS(true),
                  SizedBox(height: Dimensitions.height10,),
   us.boutique!=null &&   us.boutique!.docId==widget.boutique.docId?
                  us.products.length>0 ? 
                   Column(
                  children: List.generate((us.products.length / 3).ceil(), (rowIndex) {
                  int startIndex = rowIndex * 3;
                  int endIndex = startIndex + 3;
                  if (endIndex > us.products.length) endIndex = us.products.length;
                  return Padding(
                      padding: EdgeInsets.only(bottom: Dimensitions.height7),
                    child: Row(
                      children: List.generate(endIndex - startIndex, (index) {
                        return GestureDetector(
                          onTap:()
                          =>Get.toNamed(RouteHelper.getProductDetails(
                            us.products[startIndex + index]
                          )),
                          child: Container(
                            height: Dimensitions.width96,
                            width: Dimensitions.width96, // Fixed width for each image container
                            margin: EdgeInsets.only(right: index < (endIndex - startIndex - 1) ? Dimensitions.width10 : 0),
                            decoration: BoxDecoration(
                              color: colors.rose1,
                              borderRadius: BorderRadius.circular(Dimensitions.height10),
                              image: DecorationImage(
                                image: NetworkImage(us.products[startIndex + index].iamges[0]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                }),
              ):Container():us.otherpproducts.length>0 ? 
                   Column(
                  children: List.generate((us.otherpproducts.length / 3).ceil(), (rowIndex) {
                  int startIndex = rowIndex * 3;
                  int endIndex = startIndex + 3;
                  if (endIndex > us.otherpproducts.length) endIndex = us.otherpproducts.length;
                  return Padding(
                      padding: EdgeInsets.only(bottom: Dimensitions.height7),
                    child: Row(
                      children: List.generate(endIndex - startIndex, (index) {
                        return GestureDetector(
                           onTap:()
                          =>Get.toNamed(RouteHelper.getProductDetails(
                            us.otherpproducts[startIndex + index]
                          )),
                          child: Container(
                            height: Dimensitions.width96,
                            width: Dimensitions.width96, // Fixed width for each image container
                            margin: EdgeInsets.only(right: index < (endIndex - startIndex - 1) ? Dimensitions.width10 : 0),
                            decoration: BoxDecoration(
                              color: colors.rose1,
                              borderRadius: BorderRadius.circular(Dimensitions.height10),
                              image: DecorationImage(
                                image: NetworkImage(us.otherpproducts[startIndex + index].iamges[0]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                }),
              ):Container(),               
                  SizedBox(height: Dimensitions.height10,),
                 !widget.boutique.owner && us.otherpproducts.length<=3? SizedBox(
                    height:Dimensitions.height160,
                  ):SizedBox(height: Dimensitions.height10,),
          !widget.boutique.owner && us.otherpproducts.length<=6 && us.otherpproducts.length>3? Container(
                    height:Dimensitions.height50,
                  ):SizedBox(height: Dimensitions.height10,),
                   widget.boutique.owner && us.products.length<=3? SizedBox(
                    height:Dimensitions.height160,
                  ):SizedBox(height: Dimensitions.height10,),
          !widget.boutique.owner && us.products.length<=6 && us.products.length>3? Container(
                    height:Dimensitions.height50,
                  ):SizedBox(height: Dimensitions.height10,),
              us.isLoading?   Container(
                 
                  height: Dimensitions.height50,
                  child: Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(color: colors.rose1,strokeWidth: Dimensitions.width1,),
                  ),
                ):Container(height: Dimensitions.height20,),
                ],
              ),
            ),
          ), 
            onRefresh: () async{
              us.getFollowingList();
              us.getFollowersList(us.boutique!.docId);
              us.getOtherFollowers(widget.boutique.docId);
              us.getOtherFollowing(widget.boutique.usDocID);
            },
            );
          
        },
        ),
   
    );
  }

   Widget _SwithchPS(bool isPS){
    return Row(
          children: [
           
            Column(
              children: [
                GestureDetector(
                  child: Text(
                    "Photos",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color:!isPS?colors.text3: colors.rose5,
                        fontWeight:!isPS?FontWeight.w400: FontWeight.w600,
                        fontSize:!isPS?Dimensitions.width13: Dimensitions.width16,
                      )
                    ),
                    ),
                ),
              !isPS?
              Container()
              :  Container(
                  height: Dimensitions.height2,
                  width: Dimensitions.width55,
                  decoration: BoxDecoration(

                  color: colors.rose6,
                  borderRadius: BorderRadius.circular(Dimensitions.height2)
                  ),
                ),
              ],
            ),
            SizedBox(width: Dimensitions.width17,),
            Column(
              children: [
               
                GestureDetector(
                
                  child: Text(
                    "Videos",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color: isPS?colors.text3: colors.rose5,
                        fontWeight: isPS?FontWeight.w400: FontWeight.w600,
                        fontSize: isPS?Dimensitions.width13: Dimensitions.width16,
                      )
                    ),
                    ),
                ),
                isPS?
              Container()
              :  Container(
                  height: Dimensitions.height2,
                  width: Dimensitions.width60,
                  decoration: BoxDecoration(

                  color: colors.rose6,
                  borderRadius: BorderRadius.circular(Dimensitions.height2)
                  ),
                ),


              
              ],
            ),

          ],
          )
        ;

  }

   Widget _buildRow() {
   int realIndex=0; 
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.boutique.liens.length==1?widget.boutique.liens.length:widget.boutique.liens.length+1, (index) {
        if (index.isEven) {
          int oldIndex=realIndex;
          String image="";
          String usname="";
          if (widget.boutique.liens[realIndex].contains("instagram")) { 
            image="instagram"; 
            usname=widget.boutique.liens[realIndex].split("/")[3].split("?")[0].toString().length>12?
            widget.boutique.liens[realIndex].split("/")[3].split("?")[0].toString().substring(0,12):widget.boutique.liens[realIndex].split("/")[3].split("?")[0];     
          }else if (widget.boutique.liens[realIndex].contains("facebook")){
            image="facebook"; 
            usname="facebook";
          }else if (widget.boutique.liens[realIndex].contains("tiktok")){
            image="tiktok"; 
            usname=widget.boutique.liens[realIndex].split("/")[3].split("?")[0].toString().length>12?
            widget.boutique.liens[realIndex].split("/")[3].split("?")[0].toString().substring(0,12):widget.boutique.liens[realIndex].split("/")[3].split("?")[0];
          }else{
            image="site"; 
            usname=widget.boutique.liens[realIndex].toString().length>12
            ?
            widget.boutique.liens[realIndex].toString().substring(0,12)
            :
            widget.boutique.liens[realIndex];
          }
          realIndex++;
          return Expanded(
            flex: 1,
            child: GestureDetector(
                onTap:() async{   
                  final url =widget.boutique.liens[oldIndex];
                  if( await canLaunchUrlString(url)){
                    await launchUrlString(url);
                  }else{
                    print("nothing");
                  }
                },
              child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                       Container(
                        margin: EdgeInsets.only(bottom: Dimensitions.height2),
                   padding: EdgeInsets.all(Dimensitions.height5),
                   height: Dimensitions.height25,
                   width: Dimensitions.height25,
                   decoration: BoxDecoration(
                   color: colors.sp,
                   shape: BoxShape.circle,
                   ),
                   child: SvgPicture.asset("assets/icons/${image}.svg",color: Colors.white,),
                 ),
                     Text(
                       usname,
                       style: GoogleFonts.openSans(
                         fontSize: Dimensitions.width13,
                         fontWeight: FontWeight.w500,
                         color: colors.text3
                       ),
                       ),
                   ],
                 ),
            ),
          );
        } else {
          return  Container(
            width: Dimensitions.width1,
            color: colors.sp,
            height: Dimensitions.height30,
           );
        }
      }).toList(),
    );
  }

   Widget _buildListView() {
    return 
    SizedBox(

      height: Dimensitions.height50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.boutique.liens.length,
        itemBuilder: (context, index) {
          String image="";
          String usname="";
          if (widget.boutique.liens[index].contains("instagram")) { 
            image="instagram"; 
            usname=widget.boutique.liens[index].split("/")[3].split("?")[0].toString().length>12?
            widget.boutique.liens[index].split("/")[3].split("?")[0].toString().substring(0,12):widget.boutique.liens[index].split("/")[3].split("?")[0];
            
                    
          }else if (widget.boutique.liens[index].contains("facebook")){
            image="facebook"; 
            usname="facebook";
          }else if (widget.boutique.liens[index].contains("tiktok")){
            image="tiktok"; 
            usname=widget.boutique.liens[index].split("/")[3].split("?")[0].toString().length>12?
            widget.boutique.liens[index].split("/")[3].split("?")[0].toString().substring(0,12):widget.boutique.liens[index].split("/")[3].split("?")[0];
          }else{
            image="site"; 
            usname=widget.boutique.liens[index].toString().length>12
            ?
            widget.boutique.liens[index].toString().substring(0,12)
            :
            widget.boutique.liens[index];
          }
          return  SizedBox(
              width:  Dimensitions.listWidth,
               child: GestureDetector(
                   onTap:() async{
                          
                  final url =widget.boutique.liens[index];
                  if( await canLaunchUrlString(url)){
                    await launchUrlString(url);
                  }else{
                    print("nothing");
                  }
              
                },
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                       Container(
                   padding: EdgeInsets.all(Dimensitions.height5),
                   height: Dimensitions.height25,
                   width: Dimensitions.height25,
                   decoration: BoxDecoration(
                   color: colors.sp,
                   shape: BoxShape.circle,
                   ),
                   child: SvgPicture.asset("assets/icons/${image}.svg",color: Colors.white,),
                 ),
                     Text(
                       usname,
                       style: GoogleFonts.openSans(
                         fontSize: Dimensitions.width13,
                         fontWeight: FontWeight.w500,
                         color: colors.text3
                       ),
                       ),
                 
                 
                   ],
                 ),
               ),
             )
           ;
        },
        separatorBuilder: (context, index) {
          return  Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: Dimensitions.height5),
            width: Dimensitions.width1,
            color: colors.sp,
            height: Dimensitions.height30,
           )
            ],
          );
        },
      ),
    );
 
  }
}