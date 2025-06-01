import 'dart:math';
import 'package:diva/provider/account/user_provider.dart';
import 'package:diva/routes/route_helper.dart';
import 'package:diva/screens/home/search/search_with_filter.dart';
import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class MySearch extends StatefulWidget {
   MySearch({super.key});

  @override
  State<MySearch> createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  final FocusNode _focusNode = FocusNode();
  bool _isCommenting = false;
    @override
  void initState() {
    super.initState();
    // Schedule the focus request to run after the widget tree is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.bg,
      body:  Column(
        children: [
          // search bar 
         Padding(
          padding: EdgeInsets.only(
            top: Dimensitions.height45,
            left: Dimensitions.width25,
            right: Dimensitions.width25,
            bottom: Dimensitions.height5
          ),
          child: Row(
            children: [
               GestureDetector(
                      onTap: () {
                      
                        if ((Get.nestedKey(5)?.currentState?.canPop() ?? false) ) {

                          Provider.of<userProvider>(context,listen: false).removeLastItemFromSearchStack();
                          if (Provider.of<userProvider>(context,listen: false).LastsearchStack=="") {
                          Provider.of<userProvider>(context,listen: false).userType(false);
                            Provider.of<userProvider>(context,listen: false).clearContoller();
                          }else{
                        Provider.of<userProvider>(context,listen: false).previousValue(Provider.of<userProvider>(context,listen: false).LastsearchStack);
                        Provider.of<userProvider>(context,listen: false).search(Provider.of<userProvider>(context,listen: false).LastsearchStack,context);


                          }
                          Get.back(id: 5);

                        }else{
                          Navigator.pop(context);
                          Provider.of<userProvider>(context,listen: false).clearContoller();
                          Provider.of<userProvider>(context,listen: false).userType(false);
                        }
                        Provider.of<userProvider>(context,listen: false).clearFilter();
                      },
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
              
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: Dimensitions.width15,),
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
                  height: Dimensitions.height50,
                  child: Row(
                    children: [
                      Expanded(
                  child: TextField(
                    focusNode:_focusNode,
                    controller:Provider.of<userProvider>(context,listen: false).controller,
                    onEditingComplete: () async{
                      if (Provider.of<userProvider>(context,listen: false).controller.text.isNotEmpty) {
                        Provider.of<userProvider>(context,listen: false).addRs(Provider.of<userProvider>(context,listen: false).controller.text);
                        Provider.of<userProvider>(context,listen: false).addToSearchStack(Provider.of<userProvider>(context,listen: false).controller.text);
                        FocusScope.of(context).unfocus(); 
                        Provider.of<userProvider>(context,listen: false).clearFilter();
                        Get.toNamed(RouteHelper.searchWithFilter,id: 5);
                        Provider.of<userProvider>(context,listen: false).search(Provider.of<userProvider>(context,listen: false).controller.text,context);
                      }else{
                        FocusScope.of(context).unfocus(); 
                      }
                    },
                    onChanged: (value) {
                  
                    Provider.of<userProvider>(context,listen: false).userType(Provider.of<userProvider>(context,listen: false).controller.text.isNotEmpty);
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
                  onTap:_isCommenting?null: () async{

                      if (Provider.of<userProvider>(context,listen: false).controller.text.isNotEmpty && !_isCommenting) {
                        setState(() {
                              _isCommenting=true;
                            });
                        Provider.of<userProvider>(context,listen: false).addRs(Provider.of<userProvider>(context,listen: false).controller.text);
                        Provider.of<userProvider>(context,listen: false).addToSearchStack(Provider.of<userProvider>(context,listen: false).controller.text);
                        Provider.of<userProvider>(context,listen: false).clearFilter();
                        Get.toNamed(RouteHelper.searchWithFilter,id: 5);
                        Provider.of<userProvider>(context,listen: false).search(Provider.of<userProvider>(context,listen: false).controller.text,context);
                        FocusScope.of(context).unfocus();
                        Future.delayed(Duration(seconds: 2),(){
                       setState(() {
                              _isCommenting=false;
                            });
                        });
                      }else{
                        FocusScope.of(context).unfocus(); 
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
                )
                ),         
            ],
          ),
          ),
      
          Expanded(
            child: Navigator(
              key: Get.nestedKey(5),
              initialRoute: RouteHelper.search,
              onGenerateRoute: (settings) {
                if (settings.name == RouteHelper.searchWithFilter) {
                  return GetPageRoute(
                    popGesture: false,
                    page: () => SearchWithFilter(),
                    transition: Transition.rightToLeftWithFade
                    
                  );
                }if (settings.name ==RouteHelper.search) {
                 return GetPageRoute(
                    popGesture: false,
                    page: () =>  Consumer<userProvider>(
                     builder: (context, rs, child) {
                      
                     
            return SingleChildScrollView(
              child: Column(
                children: [
                       rs.isSearching     ?
                     Container()
                     :
               Padding(
                padding: EdgeInsets.only(
                  top: Dimensitions.height25,
                  bottom: Dimensitions.height20,
                  left: Dimensitions.width25,
                  right: Dimensitions.width25,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ancienne recherche",
                      style: GoogleFonts.openSans(
                        fontSize: Dimensitions.width18,
                        color: colors.text2,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    Text(
                      "Voir tout",
                        style: GoogleFonts.openSans(
                        fontSize: Dimensitions.width13,
                        color: colors.purpel3,
                        fontWeight: FontWeight.w600,
                      ),
                      ),
                     
                     
                  ],
                ),
                ),
                 rs.isSearching?
                 Container()
                     :  Column(
                children: List.generate(rs.recentSearch!.length> 5?5:rs.recentSearch!.length, (index) {
                      return   GestureDetector(
                        onTap: () {
                        Provider.of<userProvider>(context,listen: false).addRs(rs.recentSearch![index]);
                        Provider.of<userProvider>(context,listen: false).addToSearchStack(rs.recentSearch![index]);
                        FocusScope.of(context).unfocus(); 
                        Provider.of<userProvider>(context,listen: false).previousValue(rs.recentSearch![index]);
                        Get.toNamed(RouteHelper.searchWithFilter,id: 5);
                        Provider.of<userProvider>(context,listen: false).search(rs.recentSearch![index],context);
                        },
                        child: Container(
                                        height: Dimensitions.height30,
                                       
                                        margin: EdgeInsets.symmetric(horizontal: Dimensitions.width25),
                                        child: Row(
                                          
                                          children: [
                                            Expanded(
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          rs.recentSearch![index],
                            style: GoogleFonts.openSans(
                            fontSize: Dimensitions.width14,
                            color: colors.text2,
                            fontWeight: FontWeight.w500,
                          ),
                          ),
                                            ),
                                            SizedBox(
                        width: Dimensitions.width3,
                                            ),
                        GestureDetector(
                          onTap: () {
                            int index1 = rs.recentSearch!.indexOf(rs.recentSearch![index]);
                            rs.removeRs(index1,rs.recentSearch![index]);
                          },
                          child: Icon(Icons.close,size: Dimensitions.height15,color: colors.text2,)),
                                          ],
                                        ),
                                       ),
                      );
                },),
              //   rs.recentSearch!.map((e) {
              //   },)
              //   .toList()
              //   .cast<Widget>(),
              )
                       
                ],
              ),
            );
                     
                   },
                   )
                   ,
                    transition: Transition.fade
                    
                  );
                 
                }
                      // anceint recherches
                return null;
                }
            ),
          ),
            
        
        ],
      )  ,
                    
      
   
    );
  }
}