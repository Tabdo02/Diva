import 'dart:math';

import 'package:diva/routes/route_helper.dart';
import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCategoryList extends StatefulWidget {
  final String sc;
  final String title;
  const MyCategoryList({super.key,required this.sc,required this.title,});

  @override
  State<MyCategoryList> createState() => _MyCategoryListState();
}

class _MyCategoryListState extends State<MyCategoryList> {
  bool _clicked=false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          _clicked=true;
        });
        Future.delayed(Duration(milliseconds: 150),(){
          setState(() {
            _clicked=false;
          });
        });
        Get.toNamed(RouteHelper.getSubCategory(widget.title, widget.sc),id: 1);
      },
      child: Container(
        color: _clicked?colors.shadow.withOpacity(0.05):Colors.transparent,

                              width: double.maxFinite,
                              height: Dimensitions.height35,
                              child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: Dimensitions.width10),
                          height: Dimensitions.height20,
                          width: Dimensitions.width20,
                          decoration: BoxDecoration(
                            color: colors.text3,
                            borderRadius: BorderRadius.circular(Dimensitions.height3)
                          ),
                        ),
                    SizedBox(
                      width: Dimensitions.width265,
                      child: Text(
                                    widget.sc,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.openSans(
                      color: colors.text2,
                      fontSize: Dimensitions.width15,
                      fontWeight: FontWeight.w500
                                    ),
                                    ),
                    ),
                      ],
                    ),
                    Transform.rotate(
                          angle: pi/2,
                          child: SvgPicture.asset("assets/icons/taille.svg",height:  Dimensitions.height13,color: colors.sp,)),
                  ],
                              ),
                            ),
    );
  }
}