import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class MyBottomBar extends StatefulWidget {
  final bool isV;
  final  Function(int) onPageUpdated;
  const MyBottomBar({super.key,required this.isV,required this.onPageUpdated});

  @override
  State<MyBottomBar> createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  int index =0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimensitions.width25),
      height: Dimensitions.height55,
      
      decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(Dimensitions.height8),
        topRight:Radius.circular(Dimensitions.height8) ),
      boxShadow: [
       BoxShadow(
          
          color: colors.shadow.withOpacity(0.11),
          blurRadius: 8,
          offset: Offset(0, 0)
        ),
      ]

      ),
      child:  widget.isV?
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () =>setState(() {
              index=0;
              widget.onPageUpdated(0);
            }),
            child: Container(
              
              padding: EdgeInsets.all(Dimensitions.height10),
              decoration: BoxDecoration(
               color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  
                    BoxShadow(
            color:ss(0),
            blurRadius: 4,
            offset: Offset(0, 0)
                    ),
                    
                  ]
              ),
              child: index==0?
                 SvgPicture.asset("assets/icons/home_2.svg",height: Dimensitions.height20,color: cc(0),)

              :
                 SvgPicture.asset("assets/icons/home.svg",height: Dimensitions.height23),
              
            ),
          ),
          
          GestureDetector(
             onTap: () =>setState(() {
              index=1;
              widget.onPageUpdated(1);
            }),
            child: Container(
              
              padding: EdgeInsets.all(Dimensitions.height10),
              decoration: BoxDecoration(
               color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  
                    BoxShadow(
            color:ss(1),
            blurRadius: 4,
            offset: Offset(0, 0)
                    ),
                    
                  ]
              ),
              child: 
                index==1?
                 SvgPicture.asset("assets/icons/promo filled.svg",height: Dimensitions.height23,)

              :
                 SvgPicture.asset("assets/icons/promo outline.svg",height: Dimensitions.height23,),
              
            ),
          ),
         GestureDetector(
             onTap: () =>setState(() {
              index=2;
              widget.onPageUpdated(2);
            }),
            child: Container(
              
              padding: EdgeInsets.all(Dimensitions.height10),
              decoration: BoxDecoration(
               color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  
                    BoxShadow(
            color:ss(2),
            blurRadius: 4,
            offset: Offset(0, 0)
                    ),
                    
                  ]
              ),
              child: 
                 SvgPicture.asset("assets/icons/add-plus.svg",height: Dimensitions.height20,color: cc(2),),
              
            ),
          ),
          
          GestureDetector(
             onTap: () =>setState(() {
              index=3;
              widget.onPageUpdated(3);
            }),
            child: Container(
              
              padding: EdgeInsets.all(Dimensitions.height10),
              decoration: BoxDecoration(
               color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  
                    BoxShadow(
            color:ss(3),
            blurRadius: 4,
            offset: Offset(0, 0)
                    ),
                    
                  ]
              ),
              child: index==3?
                 SvgPicture.asset("assets/icons/profile filled.svg",height: Dimensitions.height17,color: cc(3),)

              :
                 SvgPicture.asset("assets/icons/profile.svg",height: Dimensitions.height17),
              
            ),
          ),
              
        ],
      ):
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () =>setState(() {
              index=0;
              widget.onPageUpdated(0);
            }),
            child: Container(
              
              padding: EdgeInsets.all(Dimensitions.height10),
              decoration: BoxDecoration(
               color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  
                    BoxShadow(
            color:ss(0),
            blurRadius: 4,
            offset: Offset(0, 0)
                    ),
                    
                  ]
              ),
              child: index==0?
                 SvgPicture.asset("assets/icons/home_2.svg",height: Dimensitions.height20,color: cc(0),)

              :
                 SvgPicture.asset("assets/icons/home.svg",height: Dimensitions.height23),
              
            ),
          ),
          
          GestureDetector(
             onTap: () =>setState(() {
              index=1;
              widget.onPageUpdated(1);
            }),
            child: Container(
              
              padding: EdgeInsets.all(Dimensitions.height10),
              decoration: BoxDecoration(
               color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  
                    BoxShadow(
            color:ss(1),
            blurRadius: 4,
            offset: Offset(0, 0)
                    ),
                    
                  ]
              ),
              child: index==1?
                 SvgPicture.asset("assets/icons/promo filled.svg",height: Dimensitions.height23,color: cc(1),)

              :
                 SvgPicture.asset("assets/icons/promo outline.svg",height: Dimensitions.height23,),
              
            ),
          ),
       
          
           GestureDetector(
             onTap: () =>setState(() {
              index=3;
              widget.onPageUpdated(3);
            }),
            child: Container(
              
              padding: EdgeInsets.all(Dimensitions.height10),
              decoration: BoxDecoration(
               color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  
                    BoxShadow(
            color:ss(3),
            blurRadius: 4,
            offset: Offset(0, 0)
                    ),
                    
                  ]
              ),
              child: index==3?
                 SvgPicture.asset("assets/icons/profile filled.svg",height: Dimensitions.height17,color: cc(3),)

              :
                 SvgPicture.asset("assets/icons/profile.svg",height: Dimensitions.height17),
              
            ),
          ),
              
        ],
      ),
    
      
    
    );
  }
 Color cc(int i){
  if(i==index){
    return colors.sp;
  }else{
    return colors.shadow;
  }
 }
  Color ss(int i){
  if(i!=index){
    return Colors.white;
  }else{
    return colors.shadow.withOpacity(0.18);
  }
 }
}