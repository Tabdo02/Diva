import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diva/class/boutique.dart';
import 'package:diva/class/comments.dart';
import 'package:diva/class/notification.dart';
import 'package:diva/class/product.dart';
import 'package:diva/class/social_class.dart';
import 'package:diva/compoents/title_text.dart';
import 'package:diva/provider/account/user_provider.dart';
import 'package:diva/routes/route_helper.dart';
import 'package:diva/services/push_notification_services.dart';
import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


// ignore: must_be_immutable
class ProductDetails extends StatefulWidget {
   Products products;
   ProductDetails({super.key,required this.products});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
   bool _isCommenting = false;
   int _rating =0;
   final _commentController = TextEditingController();
  TextEditingController _reductionController =TextEditingController();
   final DraggableScrollableController _controller = DraggableScrollableController();
   final _controller2 = PageController();
    @override
  void initState() {
    super.initState();
    Provider.of<userProvider>(context,listen: false).getProductComments(widget.products.productId);
    _controller.addListener(() {
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
  
    double adjustment = _controller.isAttached?((_controller.size-0.4) / 0.48) * 3:0;
    Alignment beginAlignment = Alignment.topCenter * (1 + adjustment);
    Alignment endAlignment = Alignment.bottomCenter / (1 + adjustment);
   
    return WillPopScope(
      child:  Scaffold(
  floatingActionButton: Container(
    height: Dimensitions.height50,
    width: double.maxFinite,
    child: Provider.of<userProvider>(context,listen: false).boutique != null && Provider.of<userProvider>(context,listen: false).boutiqueDocId==widget.products.boutiqueId ?
    Container(
      margin: EdgeInsets.only(left: Dimensitions.width40),
      padding: EdgeInsets.symmetric(horizontal: Dimensitions.width20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
            GestureDetector(
               onTap: () {
              showDialog(
                context: context, 
                builder: (context) {
                  return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    content: Container(
                      margin: EdgeInsets.symmetric(horizontal: Dimensitions.width10),
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensitions.width10,
                        vertical: Dimensitions.height15,
                      ),
                    height: Dimensitions.height160,
                    decoration: BoxDecoration(
                    color: colors.bg,
                    border: Border.all(color: colors.text2,width: 2),
                    borderRadius: BorderRadius.circular(Dimensitions.height10),
                      
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: Dimensitions.height5,
                            
                          ),
                          child: Text(
                            "Montant",
                            textAlign: TextAlign.center,
                                  style: GoogleFonts.openSans(
                                    fontSize: Dimensitions.width14,
                                    color:colors.text2,
                                    fontWeight: FontWeight.w600,
                                  ),
                          ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "A reduire:",
                                style: GoogleFonts.openSans(
                                  fontSize: Dimensitions.width15,
                                  fontWeight: FontWeight.w400,
                                  color: colors.text,
                                ),
                                
                                ),
                                SizedBox(
                                  width: Dimensitions.width10,
                                ),
                                SizedBox(
                                  width: Dimensitions.width100,
                                  height: Dimensitions.height40,
                                  child: TextField(
                                    controller: _reductionController,
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.number,
                                    style: GoogleFonts.openSans(
                                  fontSize: Dimensitions.width15,
                                  fontWeight: FontWeight.w600,
                                  color: colors.text,
                                ),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(Dimensitions.height10),
                                        borderSide: BorderSide(color: colors.rose7)
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(Dimensitions.height10),
                                        borderSide: BorderSide(color: colors.text2)
                                      ),
                                      disabledBorder:  OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(Dimensitions.height10),
                                        borderSide: BorderSide(color: colors.text2)
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        Row(
                          children: [
                            Expanded(
                              child: 
                              GestureDetector(
                                 onTap: () {
                                  Get.back();
                                  _reductionController.clear();
                                 } ,
                                child: Text(
                                  "Anullé",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.openSans(
                                    fontSize: Dimensitions.width14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                
                                  ),
                                  ),
                              )
                              ),
                            Container(
                              width:Dimensitions.width0_5,
                              height: Dimensitions.height20,
                              color: colors.text3,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () async{
                                  List<String> price = widget.products.price.split(" ");
                                  if (_reductionController.text.isNotEmpty && double.parse(price[0])>double.parse(_reductionController.text)) {
                                    Provider.of<userProvider>(context,listen: false).getPromoted(
                                    oldPrice:price[0],
                                    proID: widget.products.productId,
                                    reduction: _reductionController.text,
                                  );
                                  setState(() {
                                    widget.products.price='${(double.parse(price[0])-double.parse(_reductionController.text)).toString()} DA';
                                    widget.products.promotion={
                                      "oldPrice":'${price[0]} DA',
                                      "percentage":((double.parse(_reductionController.text)*100)/double.parse(price[0])).toString(),
                                    };
                                  });
                                  _reductionController.clear();
                                  if(Provider.of<userProvider>(context,listen: false).followersList != null){
                  List<String> ids =[];
                  for (socialMedia sc in Provider.of<userProvider>(context,listen: false).followersList!) {
                    ids.add(sc.uid);
                  }
                  if(ids.length >0){
                    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                    .collection("tokens")
                    .where("uid", whereIn: ids)
                    .get();

                    for (var t in querySnapshot.docs) {
                      PushNotificationServices.sendNotificationToSelectedDriver(
                        deviceToken: t["token"], 
                        notifi: MyNotificationClass(
                          senderID: Provider.of<userProvider>(context,listen: false).boutique!.docId, 
                          reciverID: t["uid"], 
                          content: "Nous avons réduit les prix de certains de nos meilleurs produits ! Rendez-vous dans notre boutique et profitez de vos articles préférés à prix réduit. Dépêchez-vous, ces offres ne dureront pas longtemps ! 🛒✨ ${Provider.of<userProvider>(context,listen: false).boutique!.name}", 
                          imageSender: Provider.of<userProvider>(context,listen: false).boutique!.profilPicture, 
                          nameSender: Provider.of<userProvider>(context,listen: false).boutique!.name, 
                          timestamp: DateTime.now().toString(),
                          ), 
                        title: "🎉 Grande nouvelle !"
                        );
                        for (var id in ids) {
                            await FirebaseFirestore.instance.collection("usersNotifications").add({
                            "senderID": Provider.of<userProvider>(context,listen: false).boutique!.docId,
                            "reciverID":id , 
                            "content": "Nous avons réduit les prix de certains de nos meilleurs produits ! Rendez-vous dans notre boutique et profitez de vos articles préférés à prix réduit. Dépêchez-vous, ces offres ne dureront pas longtemps ! 🛒✨ ${Provider.of<userProvider>(context,listen: false).boutique!.name}", 
                            "imageSender": Provider.of<userProvider>(context,listen: false).boutique!.profilPicture, 
                            "nameSender": Provider.of<userProvider>(context,listen: false).boutique!.name, 
                            "timestamp": Timestamp.now(),
                          });
                                }
                            }
                          } 
                        }
                        Provider.of<userProvider>(context,listen: false).refreshPromotedCategory(context);
                                  Get.back();
                                  }
                                  
                                } 
                                ,
                                child: Text(
                                    "Valider",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.openSans(
                                      fontSize: Dimensitions.width14,
                                      color: colors.rose7,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    ),
                              ),
                            )
                        
                          ],
                        ),
                      ],
                    ),
      
                  ),
                  );
                },
                );
                       
                       },
              child: Container(
              width: Dimensitions.width120,
              height: Dimensitions.height30,
                 decoration: BoxDecoration(
                          color: colors.purpel1,
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
                          child: Text(
                            "Promotion",
                            style: GoogleFonts.openSans(
                              fontSize: Dimensitions.width13,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                            )
                          ),
                        ),
             ),
          
         
          GestureDetector(
                  
         
            child: Container(
              width: Dimensitions.width120,
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
                          child: Text(
                            "Booster",
                            style: GoogleFonts.openSans(
                              fontSize: Dimensitions.width13,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                            )
                          ),
            ),
          ),
          
        ],
      ),
    )
    :
    Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            Provider.of<userProvider>(context,listen: false).addRemoveFavoritProduct(widget.products.productId,context);
          },
          child: Container(
            margin: EdgeInsets.only(right: Dimensitions.width20),
                        width: Dimensitions.width50,
                        height: Dimensitions.height35,
                        decoration: BoxDecoration(
                          color: colors.purpel1,
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
                          child: Consumer<userProvider>(
                            builder: (context, value, child) {
                              return 
                              value.favoritProducts.contains(widget.products.productId)?
                              Icon(Icons.favorite,color: Colors.white,size: Dimensitions.height25,)
                              :
                              SvgPicture.asset(
                            "assets/icons/favorite_24dp_FILL0_wght400_GRAD0_opsz24.svg",
                            color: Colors.white,
                            height: Dimensitions.height23,
                            );
                            },
                          ),
                        ),
                      ),
        ),
                      GestureDetector(
                        onTap: () async{
                  
                 
                          DocumentSnapshot snap =
                           await FirebaseFirestore
                           .instance
                           .collection("boutiques")
                           .doc(widget.products.boutiqueId)
                           .get();
                           Provider.of<userProvider>(context,listen: false).getOtherFollowers(widget.products.boutiqueId);
                            Provider.of<userProvider>(context,listen: false).getOtherFollowing(snap["docId"]);
                              List<dynamic> dynamicList = snap["liens"];
          List<dynamic> sanitizedLiens = dynamicList.map((url) => url.replaceAll('&', '%26')).toList();
                          Get.toNamed(
                          RouteHelper.getBoutiqueProfile(
                            Boutique(
                              owner: false,
                              docId: snap.id, 
                              bio: snap["bio"], 
                              category: snap["category"], 
                              usDocID: snap["docId"], 
                              liens: sanitizedLiens, 
                              name: snap["name"], 
                              phone: snap["phone"], 
                              profilPicture: snap["profileImage"].toString().replaceAll('&', '%26'), 
                              sCategory: snap["sCate"], 
                              ville: snap["ville"], 
                              followers: snap["followers"], 
                              following: snap["following"]
                              )
                          ));
                        },
                        child: Container(
                        width: Dimensitions.width210,
                        height: Dimensitions.height35,
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
                          child: Text("Consulter la boutique",style: GoogleFonts.openSans(
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
   
    body: 
   Stack(
    children: [
      
      Container(
     
        height: Dimensitions.height400,
        width: double.maxFinite,
        decoration: BoxDecoration(
          
          gradient: 
          LinearGradient(
            begin: beginAlignment,
      end: endAlignment,
          
            colors: [
                colors.roseg.withOpacity(0.0),
                colors.roseg.withOpacity(0.2),
                colors.roseg.withOpacity(0.4),
                colors.roseg.withOpacity(0.8),
                colors.roseg.withOpacity(0.9),
                colors.roseg,


],
stops: [
 0.37,
 0.47,
 0.57,
 0.67,
 0.77,
  1.0
                    ],
            )
        ),
       
        child:Padding(
          padding:  EdgeInsets.only(top: Dimensitions.height30,left: Dimensitions.width25,right: Dimensitions.width25 ),
          child: Column(
            children: [
              Container(
                height: Dimensitions.height40,
                child: Stack(
                  children: [
                     Align(
                      alignment: Alignment.centerLeft,
                       child: GestureDetector(
                        onTap: () {
                           Provider.of<userProvider>(context,listen: false).clearProductComments();
                           Navigator.pop(context);
                        } ,
                        child: Container(
                                           
                          padding: EdgeInsets.all(Dimensitions.height10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                           color:colors.shadow.withOpacity(0.18),
                            blurRadius: 4,
                            offset: Offset(0, 0)
                              ),
                          ],     
                        
                          ),
                          child: Transform.rotate(
                          angle: -pi/2,
                          child: SvgPicture.asset("assets/icons/taille.svg",height:  Dimensitions.height10,color: colors.sp,)),
                        ),
                                           ),
                     ),

                            Align(
                                  alignment: Alignment.center,
                                  child: _controller.isAttached && _controller.size >= 0.8?
                                  
                                   Center(
                  child: SmoothPageIndicator(
                                    
                                    controller: _controller2,
                                    count: widget.products.iamges.length,
                                   effect: CustomizableEffect(
                                    spacing: Dimensitions.width10,
                                    dotDecoration: 
                                    DotDecoration(
                                     borderRadius: BorderRadius.circular(Dimensitions.height30),
                                     height: Dimensitions.height4,
                                     width: Dimensitions.height4,
                                     color: Colors.white,
                                    ), 
                                    activeDotDecoration: DotDecoration(
                                     borderRadius: BorderRadius.circular(Dimensitions.height30),
                      height: Dimensitions.height10,
                      width: Dimensitions.height10,
                      color: Colors.white,
                                    ), 
                                    ),
                             ),
                  
                ):

                                   MyTitleText(
                                  title: "Détails",
                                   )
                                   
                                   ,
                                  ),
                      Provider.of<userProvider>(context,listen: false).boutique != null && Provider.of<userProvider>(context,listen: false).boutiqueDocId==widget.products.boutiqueId   ?          Align(
                      alignment: Alignment.centerRight,
                       child: GestureDetector(
                        onTap: () async{
                           Provider.of<userProvider>(context,listen: false).clearProductComments();
                            QuerySnapshot commentSnapshots= await FirebaseFirestore.instance.collection("comments").where("productId",isEqualTo:widget.products.productId ).get();
                            if (commentSnapshots.docs.length>0) {
                            for (var c in commentSnapshots.docs) {
                              await FirebaseFirestore.instance.collection("comments").doc(c.id).delete();
                            }
                            }
                           await  FirebaseFirestore.instance.collection("products").doc(widget.products.productId).delete();
                           Provider.of<userProvider>(context,listen: false).deleteProduct(widget.products);
                           Provider.of<userProvider>(context,listen: false).getPublicationLenght();
                           Get.back();
                        } ,
                        child: Container(     
                          padding: EdgeInsets.all(Dimensitions.height4),
                        
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                           color:colors.shadow.withOpacity(0.18),
                            blurRadius: 4,
                            offset: Offset(0, 0)
                              ),
                          ],     
                        
                          ),
                          child: SvgPicture.asset("assets/icons/delete-svgrepo-com.svg",height:  Dimensitions.height17,color: colors.sp,),
                        ),
                                           ),
                     ):SizedBox.shrink(),
                ],),
                ),
             
              
             Container(
             margin: EdgeInsets.only(top: Dimensitions.height30,bottom: Dimensitions.height20),
             
              height: Dimensitions.height230,
              child: PageView.builder(
                controller: _controller2,
                itemCount: widget.products.iamges.length,
                itemBuilder: (context, index) {
                  List<String> imgUrl =widget.products.iamges[index].toString().split("products");
                  imgUrl[1]=imgUrl[1].substring(1);
                  String img =imgUrl[0]+"products%2F"+imgUrl[1];
                  return Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 150), // Duration of the animation
                          height: _controller.isAttached ? Dimensitions.height220 * (0.4 / _controller.size) : Dimensitions.height220,
                          width: _controller.isAttached ? Dimensitions.width220 * (0.4 / _controller.size) : Dimensitions.width220,
                          decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(image: NetworkImage(img),fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(Dimensitions.height10),
                          boxShadow: [
                            BoxShadow(
                              color:colors.shadow.withOpacity(0.1),
                                blurRadius: 4,
                                offset: Offset(0, - 2)
                                  ),
                            BoxShadow(
                                color:colors.shadow.withOpacity(0.1),
                                blurRadius: 4,
                                offset: Offset( 2, 0)
                                  ),
                            BoxShadow(
                              color:colors.shadow.withOpacity(0.1),
                              blurRadius:4,
                              offset: Offset(- 2, 0)
                                  ),
                            BoxShadow(
                              color:colors.shadow.withOpacity(0.1),
                              blurRadius: 4,
                              offset: Offset(0, 2)
                                  ),
                                          ]
                                          ),
                                        
                                        ),
                      )
                    ],
                  );
                },
                ),
             ),
                Center(
                  child: SmoothPageIndicator(
                                    
                                    controller: _controller2,
                                    count: widget.products.iamges.length,
                                   effect: CustomizableEffect(
                                    spacing: Dimensitions.width10,
                                    dotDecoration: 
                                    DotDecoration(
                                     borderRadius: BorderRadius.circular(Dimensitions.height30),
                                     height: Dimensitions.height4,
                                     width: Dimensitions.height4,
                                    
                                     color: Colors.white,

                                     
                                    ), 
                                    activeDotDecoration: DotDecoration(
                                     borderRadius: BorderRadius.circular(Dimensitions.height30),
                      height: Dimensitions.height10,
                      width: Dimensitions.height10,
                      color: Colors.white,
                                    ), 
                                    ),
                             ),
                  
                ),

            ],
          ),
        )
          
          ),
    
       DraggableScrollableSheet(
        controller: _controller,
      initialChildSize: 0.4,
      maxChildSize: 0.88,
      minChildSize: 0.4,
      builder: (BuildContext context,ScrollController scrollController) {

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensitions.height15),
              topRight: Radius.circular(Dimensitions.height15),
            )
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(top: Dimensitions.height15,bottom: widget.products.promotion is! bool ? Dimensitions.height5:Dimensitions.height15),
                    height: Dimensitions.height3,
                    width: Dimensitions.width65,
                    decoration: BoxDecoration(
                      color: colors.shadow.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(Dimensitions.height10)
                    ),
                  ),
                ),
                 Consumer<userProvider>(builder: (context, value, child) {
                   return  widget.products.promotion is! bool ? Align(
                    alignment: Alignment.topRight,
                     child: Padding(
                       padding:  EdgeInsets.only(right: Dimensitions.width25),
                       child:DiagonalLineText(text: widget.products.promotion["oldPrice"]),
                     ),
                   ):Container();
                 },),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensitions.width25),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.products.name,
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w700,
                            color: colors.text2,
                            fontSize: Dimensitions.width18
                          ),
                          ),
                      ),
                      SizedBox(width: Dimensitions.width3,),
                      Consumer<userProvider>(
                        builder: (context, value, child) {
                          return Text(
                        widget.products.price,
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w500,
                          color: colors.text2,
                          fontSize: Dimensitions.width17
                        ),
                        );
                        },
                        ),
                      
            
                    ],
                  ),
                  ),
              //  SizedBox(height: Dimensitions.height10,),
              //  Padding(
              //     padding: EdgeInsets.symmetric(horizontal: Dimensitions.width25),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           "Un titre attirant ici pour identifier",
              //           style: GoogleFonts.openSans(
              //             fontWeight: FontWeight.w500,
              //             color: colors.text2,
              //             fontSize: Dimensitions.width15
              //           ),
              //           ),
              //       ],
              //     ),
              //     ),
               SizedBox(height: Dimensitions.height10,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensitions.width25),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 
                        widget.products.descriptiont,
                        style: GoogleFonts.openSans(
                        fontWeight: FontWeight.normal,
                        color: colors.text2,
                        fontSize: Dimensitions.width13,
                                                ),
                        ),
                      ]
                    ),
                  ),
                  ),
               SizedBox(height: Dimensitions.height10,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensitions.width25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Feedback",
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w500,
                          color: colors.purpel3,
                          fontSize: Dimensitions.width14
                        ),
                        ),
                    ],
                  ),
                  ),
                Padding(
                 padding:  EdgeInsets.symmetric(horizontal: Dimensitions.width25,vertical: Dimensitions.height10),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _rating=1;
                        });
                      },
                      child: 
                      Icon(
                        _rating>0?
                       Icons.star
                       :
                      Icons.star_border
                     
                        ,color: colors.purpel3,size: Dimensitions.height25,)),
                      
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _rating=2;
                        });
                      },
                      child: 
                      Icon(
                        _rating>1?
                       Icons.star
                       :
                      Icons.star_border
                     
                        ,color: colors.purpel3,size: Dimensitions.height25,)),
                        GestureDetector(
                      onTap: () {
                        setState(() {
                          _rating=3;
                        });
                      },
                      child: 
                      Icon(
                        _rating>2?
                       Icons.star
                       :
                      Icons.star_border
                     
                        ,color: colors.purpel3,size: Dimensitions.height25,)),
                        GestureDetector(
                      onTap: () {
                        setState(() {
                          _rating=4;
                        });
                      },
                      child: 
                      Icon(
                        _rating>3?
                       Icons.star
                       :
                      Icons.star_border
                     
                        ,color: colors.purpel3,size: Dimensitions.height25,)),
                        GestureDetector(
                      onTap: () {
                        setState(() {
                          _rating=5;
                        });
                      },
                      child: 
                      Icon(
                        _rating>4?
                       Icons.star
                       :
                      Icons.star_border
                     
                        ,color: colors.purpel3,size: Dimensitions.height25,)),
                  ],
                 ),
               ),
                Padding(
                 padding:  EdgeInsets.symmetric(horizontal: Dimensitions.width25,vertical: Dimensitions.height10),
                 child: SizedBox(
                  height: Dimensitions.height40,
                   child: TextField(
                    controller: _commentController,
                    style:GoogleFonts.openSans(
                        fontSize: Dimensitions.width15,
                        fontWeight: FontWeight.w500,
                        color: colors.text2,
                      ),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      isDense: true,
                      hintStyle: GoogleFonts.openSans(
                        fontSize: Dimensitions.width14,
                        fontWeight: FontWeight.w500,
                        color: colors.purpel3
                      ),
                      hintText: "Saisir un commentaire...",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colors.purpel1.withOpacity(0.6)),
                        borderRadius: BorderRadius.circular(Dimensitions.height2)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colors.purpel1.withOpacity(0.6)),
                        borderRadius: BorderRadius.circular(Dimensitions.height2)
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colors.purpel1.withOpacity(0.6)),
                        borderRadius: BorderRadius.circular(Dimensitions.height2)
                      ),
                    ),
                   ),
                 )
               ),
                Padding(
                padding:  EdgeInsets.symmetric(horizontal: Dimensitions.width25,vertical: Dimensitions.height10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap:_isCommenting?null: () async{
                        final us = Provider.of<userProvider>(context,listen: false);
                        if (_rating==0 || _commentController.text.isEmpty) {
                          Get.snackbar(
                      "Informations manquantes", 
                      "Veuillez écrire un commentaire et noter le produit avant de soumettre.",
                      backgroundColor: colors.sp,
                      snackPosition: SnackPosition.BOTTOM,
                      colorText: Colors.white,
                      );
                        }else{
                          if (! _isCommenting) {
                            setState(() {
                              _isCommenting=true;
                            });
                            us.addComment(
                          productComment(
                            productId: widget.products.productId, 
                            content: _commentController.text, 
                            date: Timestamp.now(), 
                            image: us.euser!.image, 
                            nameProfile: us.euser!.name, 
                            raiting: _rating
                            ),
                        );
                          await FirebaseFirestore.instance.collection("comments").add({
                          "productId":widget.products.productId,
                          "content":_commentController.text,
                          "timestamp":Timestamp.now(),
                          "image":us.euser!.image ,
                          "uid":us.euser!.uid,
                          "nameProfile": us.euser!.name,
                          "raiting": _rating,
                        });
                     DocumentSnapshot dd = await FirebaseFirestore.instance.collection("boutiques").doc(widget.products.boutiqueId).get();
                     DocumentSnapshot ss = await FirebaseFirestore.instance.collection("users").doc(dd["docId"]).get();

                  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                    .collection("tokens")
                    .where("uid", isEqualTo: ss["uid"])
                    .get();

                      if (querySnapshot.docs.length>0) {
                        PushNotificationServices.sendNotificationToSelectedDriver(
                        deviceToken: querySnapshot.docs.first["token"], 
                        notifi: MyNotificationClass(
                          senderID: us.euser!.docId,
                          reciverID: widget.products.boutiqueId, 
                          content: "a commenté sur votre produit ${widget.products.name}. Consultez le commentaire et répondez pour engager avec vos clients.", 
                          imageSender:  us.euser!.image, 
                          nameSender: us.euser!.name, 
                          timestamp: DateTime.now().toString(),
                          ), 
                        title: "Nouveau Commentaire sur Votre Produit, ${us.euser!.name}"
                        );
                      }
                            await FirebaseFirestore.instance.collection("usersNotifications").add({
                            "senderID": us.euser!.docId,
                            "reciverID": ss["uid"],  
                            "content": "a commenté sur votre produit ${widget.products.name}. Consultez le commentaire et répondez pour engager avec vos clients.", 
                            "imageSender": us.euser!.image, 
                            "nameSender": us.euser!.name, 
                            "timestamp": Timestamp.now(),
                          });
                        
                        _commentController.clear();
                          }
                            setState(() {
                              _isCommenting=false;
                            });
                        } 
                        
                      },
                      child: Container(
                        width: Dimensitions.width90,
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
                          child: Text("Publier",style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: Dimensitions.width12,
                            fontWeight: FontWeight.bold
                            
                          ),),
                        ),
                      ),
                    ),
                  ],
                ),

                  )

                ,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensitions.width25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Commentaires",
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w700,
                          color: colors.text2,
                          fontSize: Dimensitions.width18
                        ),
                        ),
                    ],
                  ),
                  ),
              SizedBox(height: Dimensitions.height10,),
             Consumer <userProvider>(
              builder: (context, comment, child) {
                return  Column(
                children: List.generate(
                  comment.comment.length,
                   (index) {
                     DateTime t =comment.comment[index].date.toDate();
                     return Padding(
                  padding: EdgeInsets.only(left: Dimensitions.width25,right: Dimensitions.width25,bottom:Dimensitions.height10, ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                
                    children: [
                      Container(
                        height: Dimensitions.height15,
                        width: Dimensitions.height15,
                        decoration: BoxDecoration(
                          color: colors.bg,
                            boxShadow: [
                            BoxShadow(
                           color:colors.shadow.withOpacity(0.3),
                            blurRadius: 4,
                            offset: Offset(0, 0)
                              ),
                          ], 
                          shape: BoxShape.circle,
                          image:comment.comment[index].image==""?
                           DecorationImage(image: AssetImage("assets/images/img.png"),fit: BoxFit.cover)
                            :
                           DecorationImage(image: NetworkImage(comment.comment[index].image),fit: BoxFit.cover)
                        ),
                      ),
                      SizedBox(
                        width: Dimensitions.width8,
                      ),
                      SizedBox(
                        width: Dimensitions.width280,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          
                          comment.comment[index].nameProfile,
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w600,
                            color: colors.text,
                            fontSize: Dimensitions.width15
                          ),
                          ),
                      ),
                     
            
                    ],
                  ),
                  SizedBox(height: Dimensitions.height5,),
                  Row(
                      children: [
                        Wrap(
                           children: [
                    Icon(comment.comment[index].raiting>0?
                      Icons.star:Icons.star_border,color: colors.purpel3,size: Dimensitions.height13,),
                    Icon(comment.comment[index].raiting>1?
                      Icons.star:Icons.star_border,color: colors.purpel3,size: Dimensitions.height13,),
                    Icon(comment.comment[index].raiting>2?
                      Icons.star:Icons.star_border,color: colors.purpel3,size: Dimensitions.height13,),
                    Icon(comment.comment[index].raiting>3?
                      Icons.star:Icons.star_border,color: colors.purpel3,size: Dimensitions.height13,),
                    Icon(comment.comment[index].raiting>4?
                      Icons.star:Icons.star_border,color: colors.purpel3,size: Dimensitions.height13,),
                  ],
                        ),
                        SizedBox(width: Dimensitions.width8,),
                        Text(
                          "${t.day}/${t.month}/${t.year}",
                          style: GoogleFonts.openSans(
                       fontWeight: FontWeight.w300,
                       color: colors.text2,
                       fontSize: Dimensitions.width13
                                                ),
                          ),
                      
                      ],
                     ),
                  SizedBox(height: Dimensitions.height5,),

                     RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:comment.comment[index].content,
                       style: GoogleFonts.openSans(
                       fontWeight: FontWeight.normal,
                       color: colors.text2,
                       fontSize: Dimensitions.width13
                                                ),
                        ),
                      //   TextSpan(
                      //     text: 
                      //     "Afficher plus",
                      //  style: GoogleFonts.openSans(
                      //  fontWeight: FontWeight.w600,
                      //  color: colors.purpel3,
                      //  fontSize: Dimensitions.width13
                      //                           ),
                      //   ),
                      ]
                    ),
                  ),
                 (comment.comment.length-1)==index?
                 Container()
                 :  Container(
                    margin: EdgeInsets.symmetric(horizontal: Dimensitions.width25,vertical:Dimensitions.height20, ),
                    height: Dimensitions.height1_5,
                    color: colors.rose4,
                   ),
                    ],
                  )
                  );
              
                   },
                   ),
              );
              
               
             },),
             
              SizedBox(height: Dimensitions.height60,),
              
              ],
            ),
          )
        );
      },
      ),
 
      
    ],
   )
    
    )
, 
      onWillPop: () async{
        Provider.of<userProvider>(context,listen: false).clearProductComments();
        return true;
      },);
   
  }
}
class DiagonalLineText extends StatelessWidget {
  final String text;

  DiagonalLineText({required this.text});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DiagonalLinePainter(),
      child:  Text(
        text,
        style: GoogleFonts.openSans(
        fontWeight: FontWeight.w500,
        color: colors.text3,
        fontSize: Dimensitions.width15
                            ),
                            ),
    );
  }
}

class DiagonalLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = colors.purpel1.withOpacity(0.7)
      ..strokeWidth = 2;
    // Draw a diagonal line from bottom left to top right
    canvas.drawLine(
      Offset(0, size.height),
      Offset(size.width, 0),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}


    