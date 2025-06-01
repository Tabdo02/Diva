import 'package:diva/compoents/category_list.dart';
import 'package:diva/compoents/home/app_bar.dart';
import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Category extends StatefulWidget {
  final String? title;
  final List<dynamic>? sCate;
  const Category({super.key, this.title, this.sCate});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  @override
  Widget build(BuildContext context) {
    // print(widget.sCate![1]);
    return Scaffold(
      appBar:MyAppBar(
        tit: widget.title!,
        fn:true,
        ),
      backgroundColor: colors.bg,
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: Dimensitions.width25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "description du categorie",
            style: GoogleFonts.openSans(
              color: colors.text2,
              fontSize: Dimensitions.width16,
              fontWeight: FontWeight.w300
            ),
            ),
          SizedBox(height: Dimensitions.height20,),
        widget.sCate!.length !=0  ?
        Column(
            children: widget.sCate!.map((sc){
              return  MyCategoryList(
                sc: sc,
                title: widget.title!,
                );
            }).toList().cast<Widget>(),
          ):Container(),
        
        ],
            ),
      ),
    );
  }
}