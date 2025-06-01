import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:diva/class/product.dart';
import 'package:diva/compoents/title_text.dart';
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


// ignore: must_be_immutable
class Promotion extends StatefulWidget {
  final VoidCallback? onTap;
  final ScrollController?  scroll;
   Promotion({super.key,required this.onTap,this.scroll});

  @override
  State<Promotion> createState() => _PromotionState();
}

class _PromotionState extends State<Promotion> {
  final List<String> csc=["Catégorie","Sous catégorie"];

  final _controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPromtionProducts();
  }
  void getPromtionProducts(){
    final value = Provider.of<userProvider>(context,listen: false);
     if (value.promotionServices.length==0 && value.promotionProducts.length==0) {
          value.getPromotedProducts(context);
        }
  }
   final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      backgroundColor: colors.bg,
//      appBar:MyAppBar(
//       onTap: () {
//         if(widget.onTap != null){
//           widget.onTap!();
//         }
//       },
//       fn:false,
//       onTapNotif: ()=>Get.toNamed(RouteHelper.notification,id: 2),
//       onTapfav: ()=>Get.toNamed(RouteHelper.favorit,id: 2),
// ),
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(Dimensitions.height60), 
        child: Padding(
          padding: EdgeInsets.only(top: Dimensitions.height28,left: Dimensitions.width25,right:Dimensitions.width25, ),
          child: Column(
          children: [
            Row(
                    children: [
                     
                      SizedBox(
                        width: Dimensitions.width280,
                        child: MyTitleText(
                          title: "Promotion",
                          
                          ),
                      ),
                    ],
                   ),
                   Container(
                margin: EdgeInsets.only(top: Dimensitions.height10 ),
                    height: Dimensitions.height2,
                    color: colors.sp,
                  ),
          ],
                ),
        )
        ),
      body: Consumer<userProvider>(builder: (context, value, child) {
        return   LiquidPullToRefresh(
          onRefresh: () async{
             await Future.delayed(const Duration(seconds: 1));
            value.refreshPromotedCategory(context);
          },
           backgroundColor: colors.rose1,
            color: colors.rose2,
            height: Dimensitions.height70,
            showChildOpacityTransition: false,
          child: SingleChildScrollView(
                  controller: widget.scroll,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
           //serach bar
            Container(
                
            height: Dimensitions.height50,
            margin: EdgeInsets.only(left: Dimensitions.width25,right: Dimensitions.width25,top: Dimensitions.height30,bottom:  Dimensitions.height20,),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimensitions.height10),
             boxShadow: [
                 BoxShadow(
          color: colors.shadow.withOpacity(0.11),
          blurRadius: 8,
          offset: Offset(0, 0)
                  ),
                ]
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    focusNode: _focusNode,
                    controller:_controller,
                    onEditingComplete: () async{
                      if (_controller.text.isNotEmpty) {
                        value.promotionSearch(_controller.text);
                        FocusScope.of(context).unfocus();
                        _focusNode.unfocus(); 
                      }else{
                        FocusScope.of(context).unfocus(); 
                        _focusNode.unfocus();
                      }
                    },
                    onChanged: (valuee) {
                  if (_controller.text.isEmpty) {
                    value.restPromotionLists();
                  }
                    },
                    cursorHeight: Dimensitions.height20,
                    
                    style: GoogleFonts.openSans(
                
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: Dimensitions.width14,
                          fontWeight: FontWeight.w300,
                        ),),
                    decoration: InputDecoration(
                      
                      isDense: true,
                      hintText: "Recherche...",
                      hintStyle: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: colors.purpel5,
                          fontSize: Dimensitions.width18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensitions.height10),
                        borderSide: BorderSide(color: Colors.white)
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensitions.height10),
                        borderSide: BorderSide(color: Colors.white)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensitions.height10),
                        borderSide: BorderSide(color: Colors.white)
                      ),
                        suffixIcon:Image.asset(
                          "assets/icons/menu.png",
                        
                          color: colors.purpel5,
                          ),
                          suffixIconConstraints: BoxConstraints(
                            maxHeight: Dimensitions.height25
                          )
                    ),
                  )
                  ,
                 
                 
                  ),
                  
                GestureDetector(
                  onTap: (){
                    if (_controller.text.isNotEmpty) {
                        value.promotionSearch(_controller.text);
                        FocusScope.of(context).unfocus(); 
                        _focusNode.unfocus();
                      }else{
                        FocusScope.of(context).unfocus(); 
                        _focusNode.unfocus();
                      }
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: Dimensitions.width8),
                    width: Dimensitions.width50,
                    decoration: BoxDecoration(
                    color: colors.purpel3,
                    borderRadius: BorderRadius.circular(Dimensitions.height10),
                    
                    ),
                    child: Center(
                        child: SvgPicture.asset(
                          "assets/icons/magnifier_search_zoom_i (1).svg",
                          height: Dimensitions.height25,
                          color: Colors.white,),
                     
                      
                    ),
                  ),
                )
              ],
            ),
          ),
               
             //text
            // MyTitleText(
            //   title: "Promotion",
            //   padding: EdgeInsets.only(left: Dimensitions.width25,bottom:Dimensitions.height5, ),
              
            // ),
           //texts
            _SwithchPS(context),
            // filtre
              Container(
                    margin: EdgeInsets.only(left: Dimensitions.width25,bottom: Dimensitions.height10,top:Dimensitions.height10, ),
                    height: Dimensitions.height30,
                    
                    child: Center(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: csc.length,
                        itemBuilder: (context, index) {
                          return value.promotionSousCateList.length==0 && index==1?
                          Container()
                          :
                          Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _focusNode.unfocus();
                                  value.updatedPromotionTapedList(csc[index],context);
                                  value.showModalSheet2(csc[index],context);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: Dimensitions.width10),
                                                            padding: EdgeInsets.symmetric(horizontal: Dimensitions.width5,vertical: Dimensitions.height2),
                                                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensitions.height5),
                                border: Border.all(color: colors.purpel1,),
                                color: index==0?
                                    value.promotionCategoryValue !=""?
                                    colors.purpel1
                                    :
                                    colors.bg
                                    :value.promotionSousCateValue !=""?
                                    colors.purpel1
                                    :
                                    colors.bg,
                                                            ),
                                                            child: Row(
                                
                                children: [
                                  Text(
                                    index==0?
                                    value.promotionCategoryValue !=""?
                                    value.promotionCategoryValue
                                    :
                                    csc[index]
                                    :value.promotionSousCateValue !=""?
                                    value.promotionSousCateValue
                                    :
                                    csc[index],
                                    style: GoogleFonts.openSans(
                                      color: 
                                       index==0?
                                    value.promotionCategoryValue !=""?
                                    Colors.white
                                    :
                                    colors.purpel1
                                    :value.promotionSousCateValue !=""?
                                    Colors.white
                                    :
                                    colors.purpel1,
                                      fontWeight: FontWeight.w400,
                                      fontSize: Dimensitions.width15
                                    ),
                                    ),
                                  SizedBox(width: Dimensitions.width5,),
                                  Transform.rotate(
                                    angle: -pi/2,
                                    child: Icon(Icons.arrow_back_ios,color: index==0?
                                    value.promotionCategoryValue !=""?
                                    colors.bg
                                    :
                                    colors.purpel1
                                    :value.promotionSousCateValue !=""?
                                    colors.bg
                                    :
                                    colors.purpel1,size: Dimensitions.height15,)),
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
          
                  value.promotionSwitch =="Produits"?   Padding(
          padding:  EdgeInsets.only(top: Dimensitions.height15,right: Dimensitions.width25,left: Dimensitions.width25),
          child: Column(
          children: buildRows(value.promotionProducts),
          ),
                  ):
                  Padding(
          padding:  EdgeInsets.only(top: Dimensitions.height15,right: Dimensitions.width25,left: Dimensitions.width25),
          child: Column(
          children: buildRows(value.promotionServices),
          ),
                  )   ,
                value.promotionSwitch =="Services" && value.promotionServices.length==0 ?
                   Container(height: Dimensitions.height300,):Container(), 
                 value.promotionSwitch =="Produits" && value.promotionProducts.length==0?
                  Container(height: Dimensitions.height300,):Container(),
                  value.promotionProducts.length<=2 && value.promotionProducts.length>0 && value.promotionSwitch =="Produits" ?Container(height: Dimensitions.height100,):Container(),
                  value.promotionServices.length<=2 && value.promotionServices.length>0 && value.promotionSwitch =="Services" ?
                  Container(height: Dimensitions.height100,):Container(),
                  ],
                ),
              ),
        );
       
      },)
    
    );
  }

    Widget _SwithchPS(BuildContext context){
      final us = Provider.of<userProvider>(context,listen: false);
    return Row(
          children: [
            SizedBox(width: Dimensitions.width25,),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    us.promotionSwitchPSB("Produits");
                  },
                  child: Text(
                    "Produits",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color: us.promotionSwitch=="Produits"?colors.rose5:colors.text3,
                        fontWeight:  us.promotionSwitch=="Produits"?FontWeight.w600:FontWeight.w400,
                        fontSize: us.promotionSwitch=="Produits"? Dimensitions.width16:Dimensitions.width13,
                      )
                    ),
                    ),
                ),
                us.promotionSwitch=="Produits"?
                Container(
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
                  onTap: (){
                    Provider.of<userProvider>(context,listen: false).promotionSwitchPSB("Services");
                  },
                  child: Text(
                    "Services",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color: us.promotionSwitch=="Services"?colors.rose5:colors.text3,
                        fontWeight:  us.promotionSwitch=="Services"?FontWeight.w600:FontWeight.w400,
                        fontSize: us.promotionSwitch=="Services"? Dimensitions.width16:Dimensitions.width13,
                      )
                    ),
                    ),
                ),
                us.promotionSwitch=="Services"?
                Container(
                  height: Dimensitions.height2,
                  width: Dimensitions.width60,
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
                        DecorationImage(image: CachedNetworkImageProvider( p[0]["profileImage"]),fit: BoxFit.fill),
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
                    image: CachedNetworkImageProvider(p[1]["images"][0].toString()), 
                    fit: BoxFit.cover,),
      
                ),
                child:Stack(
                        children: [
                          Positioned(
                            left: -7.0,
                            top: 5.0,
                            child: Container(
                              height: 35.0,
                              width: 55.0,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/icons/promotion.png"))),
                              child: Center(
                                child: Text(
                                  "${double.parse(p[1]["promotion"]["percentage"].toString()).round().toString()}%",
                                  style: GoogleFonts.openSans(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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