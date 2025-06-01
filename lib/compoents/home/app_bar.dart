import 'dart:math';
import 'package:diva/compoents/title_text.dart';
import 'package:diva/provider/account/user_provider.dart';
import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget{
  final bool fn;
  final String  tit;
  final void Function()? onTap;
  final void Function()? onTapNotif;
  final void Function()? onTapfav;

  const MyAppBar({super.key,this.tit="",required this.fn,this.onTap,this.onTapNotif,this.onTapfav});

  Size get preferredSize => Size.fromHeight(Dimensitions.height60);
  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Dimensitions.height28,left: Dimensitions.width25,right:Dimensitions.width25, ),
      height:widget.fn?Dimensitions.height80: Dimensitions.height70,
      decoration: BoxDecoration(
      color: widget.fn?colors.bg:Colors.white,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(Dimensitions.height8),
        bottomRight:Radius.circular(Dimensitions.height8) ),
      boxShadow: [
        BoxShadow(
        
          color: widget.fn?colors.bg:colors.shadow.withOpacity(0.1),
          blurRadius: 5,
          offset: Offset(0, 0)
        ),
        
      ]

      ),
      child: widget.fn?
      Column(
        children: [
          Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (Provider.of<userProvider>(context,listen: false).isIn) {
                  Provider.of<userProvider>(context,listen: false).updaetSocialPage(false);
                  if (Provider.of<userProvider>(context,listen: false).removedFollowingList.length>0) {
                    Provider.of<userProvider>(context,listen: false).removeItemsFromFollowingList(context);
                  }
                }
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
                    SizedBox(
                      width: Dimensitions.width275,
                      child: MyTitleText(
                        title: widget.tit,
                        padding: EdgeInsets.only(left: Dimensitions.width10,),
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
      ):
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
        SvgPicture.asset("assets/Logo/logo_pink.svg",height: Dimensitions.height30,),
                
                Container(
                 
                  width: Dimensitions.width110,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                          GestureDetector(
                            onTap: widget.onTapNotif,
                            child: SvgPicture.asset("assets/icons/notification-svgrepo.svg",
                            height: Dimensitions.height28,
                            color: colors.purpel3,)),
                          GestureDetector(
                           onTap:widget.onTapfav,
                          child: SvgPicture.asset("assets/icons/favorite_24dp_FILL0_wght400_GRAD0_opsz24.svg",height: Dimensitions.height23,color: colors.purpel3,)),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: SvgPicture.asset("assets/icons/menu-svgrepo.svg",height: Dimensitions.height23,color: colors.purpel3,)),  
                    
                    ],
                  ),
                )
              ],
      ),
   
    );
    
  }
}