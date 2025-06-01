import 'dart:math';

import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountListTile extends StatefulWidget {
  final  String page;
  final  String assetSvg;
  final  String title;


  const AccountListTile({
    super.key,
    required this.page,
    required this.assetSvg,
    required this.title,
    });

  @override
  State<AccountListTile> createState() => _AccountListTileState();
}

class _AccountListTileState extends State<AccountListTile> {
  bool _changebackgroud=false;
  @override
  Widget build(BuildContext context) {
    return   GestureDetector(
      onTap: (){
        setState(() {
        _changebackgroud=true;
        });
        Future.delayed(Duration(milliseconds: 150),(){
         setState(() {
        _changebackgroud=false;
        });
        });
      
        Get.toNamed(widget.page,id: 4);

        },
      child: Container(
        color: _changebackgroud?colors.shadow.withOpacity(0.05):Colors.transparent,
              margin: EdgeInsets.symmetric(
                horizontal: Dimensitions.width25,
                ),
                height: Dimensitions.height35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
        Row(children: [
        Container(
          margin: EdgeInsets.only(right: Dimensitions.width5,),
          width: Dimensitions.width25,
          child: SvgPicture.asset(widget.assetSvg,height: Dimensitions.height20,),
        ),
        
        Text(
                    widget.title,
                     style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    color: colors.text2,
                    fontWeight: FontWeight.w600,
                    fontSize: Dimensitions.width15,
                
                  )
                ),
                    ),
        ],),
                    Transform.rotate(
                    angle: pi/2,
                    child: SvgPicture.asset(
                      "assets/icons/taille.svg",
                      height:  Dimensitions.height13,
                      color: colors.sp,
                      )
                      ),
        
                  ],
                ),
             ),
    )
           ;
  }
}