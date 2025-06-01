import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:diva/class/product.dart';
import 'package:diva/compoents/advertisemnt.dart';
import 'package:diva/compoents/home/app_bar.dart';
import 'package:diva/compoents/home/ps_items.dart';
import 'package:diva/compoents/search_bar.dart';
import 'package:diva/compoents/title_text.dart';
import 'package:diva/provider/account/user_provider.dart';
import 'package:diva/provider/home/category_provider.dart';
import 'package:diva/routes/route_helper.dart';
import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Accuiel extends StatefulWidget {
  final VoidCallback? onTap;
  final ScrollController?  scroll;
   Accuiel({super.key, this.onTap,this.scroll});

  @override
  State<Accuiel> createState() => _AccuielState();
}

class _AccuielState extends State<Accuiel> {

  final _controller = PageController();
  final _controller2 = PageController();

  List<dynamic> myPs=[
[
  "Habillement",
 "assets/images/vest.png",
[
                     
                      colors.rose5.withOpacity(0.9),
                      colors.rose5.withOpacity(0.59),
                      colors.rose5.withOpacity(0.70),
                      colors.rose5.withOpacity(0.77),
                      colors.rose7,
],
[
 0.25,
   0.65,

   0.70,

   0.77,
  1.0
                    ]
],
[
  "Accessoires",
 "assets/images/prada.png",
[
                      colors.rose4.withOpacity(0.9),

                      colors.rose4.withOpacity(0.59),
                      colors.rose4.withOpacity(0.70),

                      colors.rose4.withOpacity(0.77),

                      colors.purpel6,
],
[
   0.25,
   0.65,

   0.70,

   0.77,
  1.0
                    ]
],
[
  "Sacs",
 "assets/images/Sac.png",
                     
[
   colors.rose9,
                      colors.rose9,
                      colors.rose8,
],
[
   0.65,

   0.77,
  1.0
                    ]
],
[
  "Sacs",
 "assets/images/Sac.png",
[
                      colors.rose9,

                      colors.rose9.withOpacity(0.75),
                      colors.rose8,
],
[
   0.65,

   0.77,
  1.0
                    ]
],

];

  @override
  Widget build(BuildContext context) {
    return    
    Scaffold(
      backgroundColor: colors.bg,
      appBar:MyAppBar(
      onTap: () {
        if(widget.onTap != null){
          widget.onTap!();
        }
      },
      fn:false,
      onTapNotif: ()=>Get.toNamed(RouteHelper.notification,id: 1),
      onTapfav: ()=>Get.toNamed(RouteHelper.favorit,id: 1),
            ),
      body: Consumer<CategoryProvider>(
        builder: (context, ps, child) {

          if (ps.produit.length==0) {
            ps.allProducts();
          }

          if (ps.service.length==0) {
            ps.allService();
          }

         if (Provider.of<userProvider>(context,listen: false).recentSearch==null) {
           Provider.of<userProvider>(context,listen: false).fetchRecentSearch();
         }

          if (Provider.of<userProvider>(context,listen: false).favoritProducts.length==0) {
           Provider.of<userProvider>(context,listen: false).loadFavoritProduct();
         }

          if (Provider.of<userProvider>(context,listen: false).favoritBoutique.length==0) {
           Provider.of<userProvider>(context,listen: false).loadFavoritBoutique();
         }

           if (Provider.of<userProvider>(context,listen: false).followersList==null && Provider.of<userProvider>(context,listen: false).boutique != null) {
            Provider.of<userProvider>(context,listen: false).getFollowersList(Provider.of<userProvider>(context,listen: false).boutique!.docId); 
          }

          if (Provider.of<userProvider>(context,listen: false).followingList==null) {
            Provider.of<userProvider>(context,listen: false).getFollowingList();
          }
          else{
            if (ps.abonnementProducts == null && ps.abonnementServices == null ) {
                      ps.getAllProdcutAbonnement(context);
                    }
          }
        
         if (ps.servicePubs.length==0 && ps.productPubs.length==0) {
           ps.getPubs();
         }
        
          return    SingleChildScrollView(
           controller: widget.scroll,
          child: 
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //serach bar
              GestureDetector(
                onTap: () => Get.toNamed(RouteHelper.search,id: 1),
                child: MySearchBar()
                ),
              //text
              GestureDetector(
                child: MyTitleText(
                  title: "Catégories",
                  padding: EdgeInsets.only(left: Dimensitions.width25,bottom:Dimensitions.height5, ),
                ),
              ),
             //texts
              _SwithchPS(
                isPS: ps.pOrS,
                onTap: ps.toggleSP,

              ),
              //produit and services container gridients
              ps.service.length==0 && ps.produit.length==0?
                 Container(
                  height: Dimensitions.height145,
                 )
                  :
                  IndexedStack(
                    index: ps.pOrS?0:1,
                    children: [
                      Container(
                margin: EdgeInsets.only(left: Dimensitions.width13),
                padding: EdgeInsets.symmetric(vertical: Dimensitions.height5),
         
                height:Dimensitions.height145,
                child: ListView.builder(
                   cacheExtent: 9999,
                  scrollDirection: Axis.horizontal,
                  itemCount: ps.produit.length,
                  itemBuilder: (context, index) {

                 var random = Random();
                int randomNumber = random.nextInt(4);
                    return 
                    PsItems(
                      imagePS: ps.produit[index].image,
                      mcolors:myPs[randomNumber][2] ,
                      namePS:  ps.produit[index].name,
                      stops: myPs[randomNumber][3],
                      scte: ps.produit[index].sCategory ?? [] ,
                    );
                  },
                  ),
              ),
                Container(
                margin: EdgeInsets.only(left: Dimensitions.width13),
                padding: EdgeInsets.symmetric(vertical: Dimensitions.height5),
         
                height:Dimensitions.height145,
                child: ListView.builder(
                   cacheExtent: 9999,
                  scrollDirection: Axis.horizontal,
                  itemCount:  ps.service.length,
                  itemBuilder: (context, index) {

                 var random = Random();
                int randomNumber = random.nextInt(4);
                    return 
                    PsItems(
                      imagePS:  ps.service[index].image,
                      mcolors:myPs[randomNumber][2] ,
                      namePS:   ps.service[index].name,
                      stops: myPs[randomNumber][3],
                      scte:  ps.service[index].sCategory ?? [] ,
                    );
                  },
                  ),
              ),
                    ],
                  ),
                 
            //   title sponsorise
             MyTitleText(
                title: "Sponsorisé",
                padding: EdgeInsets.only(left: Dimensitions.width25,bottom:Dimensitions.height5,top: Dimensitions.height10, ),
                
              ),
             //texts
             _SwithchPS(
              isPS: ps.adv,
              onTap: () => ps.toggleAdv(),
             ),
             
             // advertising section
          ps.productPubs.length==0 || ps.servicePubs.length==0?
          SizedBox(height: Dimensitions.height70,)
          :  IndexedStack(
              index: ps.adv?0:1,
              children: [
              Advertisemnt(pubs: ps.productPubs, controller: _controller),
              Advertisemnt(pubs: ps.servicePubs, controller: _controller2),
              ],
             ),

              // Abonemment section
             
             MyTitleText(
                title: "Abonnement",
                padding: EdgeInsets.only(left: Dimensitions.width25,bottom:Dimensitions.height5,),
              ),
             //texts
              _SwithchPS(
                isPS: ps.followingProducts,
                onTap: ps.toggleFollowing,
              ),

              ps.abonnementProducts == null && ps.abonnementServices == null?
            Container():      ps.followingProducts?    Padding(
          padding:  EdgeInsets.only(top: Dimensitions.height15,right: Dimensitions.width25,left: Dimensitions.width25),
          child: Column(
          children: buildRows(ps.abonnementProducts!),
          ),
        ):
         Padding(
          padding:  EdgeInsets.only(top: Dimensitions.height15,right: Dimensitions.width25,left: Dimensitions.width25),
          child: Column(
            children: buildRows(ps.abonnementServices!),
          ),
        ),
              SizedBox(height: Dimensitions.height30,),
              // button affichier plus
             Provider.of<userProvider>(context,listen: false).followingList !=null 
             && Provider.of<userProvider>(context,listen: false).followingList!.length>0  ?
             ps.isSearching?
              Container(
                    height: Dimensitions.height50,
                    child: Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(color: colors.rose1,strokeWidth: Dimensitions.width1,),
                    ),
                  ):
             _ButtonLoadMore(
              ()=>ps.getAllProdcutAbonnement(context),
             ):Container(),
            ],
          )
         
          );
   
        
      },)
   
    );
    
  }
  Widget _SwithchPS({required bool isPS,required void Function()? onTap}){
    return Row(
          children: [
            SizedBox(width: Dimensitions.width25,),
            Column(
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Produits",
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
                  width: Dimensitions.width60,
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
                  onTap: onTap,
                  child: Text(
                    "Services",
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
  
  Widget _ButtonLoadMore(void Function()? onTap){
    return Center(
         child: GestureDetector(
          onTap: onTap,
           child: Container(
            margin: EdgeInsets.only(bottom:Dimensitions.height20, ),
            padding: EdgeInsets.symmetric(horizontal: Dimensitions.width18,vertical: Dimensitions.height10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensitions.height10),
              color: colors.purpel3
            ),
            child: Text(
              "Afficher plus",
              style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: Dimensitions.width13,
                fontWeight: FontWeight.w600,
              ),
              ),
           ),
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

