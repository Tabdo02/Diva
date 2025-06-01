import 'package:diva/compoents/home/app_bar.dart';
import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';


class confidentialite extends StatefulWidget {
  const confidentialite({super.key});

  @override
  State<confidentialite> createState() => _confidentialiteState();
}

class _confidentialiteState extends State<confidentialite> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:MyAppBar(
        tit: "Confidentialité",
        fn:true,
        ),
      backgroundColor: colors.bg,
       body: Padding(
         padding:  EdgeInsets.only(left: Dimensitions.width25,right: Dimensitions.width25,top: Dimensitions.height10),
         child: PDF().fromAsset('assets/policy.pdf'),
       ),
    

    
              );
    
    
  }

}