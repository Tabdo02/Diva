import 'package:diva/compoents/home/app_bar.dart';
import 'package:diva/provider/account/user_provider.dart';
import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyNotification extends StatelessWidget {
  const MyNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:MyAppBar(
      onTap: () {
        
      },
      fn: true,
      tit: "Notification",
    ),
      backgroundColor: colors.bg,
      body: Padding(
      padding:  EdgeInsets.symmetric(horizontal: Dimensitions.width25),
      child: Consumer<userProvider>(
        builder: (context, myNotif, child) {
          return    SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Dimensitions.height20,),
            _notfiUpdateText("Nouveaux"),
            SizedBox(height: Dimensitions.height10,),
            Column(
              children: myNotif.myNotification.map(
                (notif){
                  // Parse the date string into a DateTime object
                    DateTime parsedDate = DateTime.parse(notif.timestamp);

                    // Get the current date and time
                    DateTime now = DateTime.now();

                    // Get today's date at 00:00
                    DateTime todayStart = DateTime(now.year, now.month, now.day);

                 

                    
                    return  parsedDate.isAfter(todayStart)?
                    Padding(
                  padding: EdgeInsets.only(bottom: Dimensitions.height10),
                  child: 
                  Row(
                              
                               crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                  Container(
                          
                          alignment: Alignment.topLeft,    
                       margin: EdgeInsets.only(bottom: Dimensitions.height10,right: Dimensitions.width8),
                      width: Dimensitions.height30,
                      height: Dimensitions.height30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: notif.imageSender==""?
                        DecorationImage(image: AssetImage("assets/images/img.png"),fit: BoxFit.cover)

                        :DecorationImage(image: NetworkImage(notif.imageSender),fit: BoxFit.cover),
                        color: Colors.white,
                         boxShadow: [
                        
                  BoxShadow(
                            
                            color: colors.sp.withOpacity(0.3),
                            blurRadius: 6,
                            offset: Offset(0, 0)
                          ),
                  ]
                      ),
                     
                    ),
                      Expanded(
                        child: Column(
                          children: [
                            Text.rich(
                          TextSpan(
                            text: notif.nameSender,
                             style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w500,
                                      fontSize: Dimensitions.width15,
                                    ),
                            children: [
                              TextSpan(
                                text:" ${notif.content}" ,
                                 style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w400,
                                      fontSize: Dimensitions.width13,
                                      color: colors.text2
                                    ),
                              ),
                            ]
                          ),
                        ),
                     
                          ],
                        ),
                      ),
                                ],
                              ),
                
                ):Container();
            
                } 
               
              ).toList().cast<Widget>(),
            ),
           
            _notfiUpdateText("Hier"),
          SizedBox(height: Dimensitions.height10,),
            Column(
              children: myNotif.myNotification.map(
                (notif){
                  // Parse the date string into a DateTime object
                    DateTime parsedDate = DateTime.parse(notif.timestamp);

                    // Get the current date and time
                    DateTime now = DateTime.now();

                    // Get today's date at 00:00
                    DateTime todayStart = DateTime(now.year, now.month, now.day);

                    // Get yesterday's date at 00:00
                    DateTime yesterdayStart = todayStart.subtract(Duration(days: 1));

                    return  parsedDate.isAfter(yesterdayStart) && parsedDate.isBefore(todayStart)?
                    Padding(
                  padding: EdgeInsets.only(bottom: Dimensitions.height10),
                  child: 
                  Row(
                              
                               crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                  Container(
                          
                          alignment: Alignment.topLeft,    
                       margin: EdgeInsets.only(bottom: Dimensitions.height10,right: Dimensitions.width8),
                      width: Dimensitions.height30,
                      height: Dimensitions.height30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,

                        image:notif.imageSender==""?
                        DecorationImage(image: AssetImage("assets/images/img.png"),fit: BoxFit.cover)

                        : DecorationImage(image: NetworkImage(notif.imageSender),fit: BoxFit.cover),
                        color: Colors.white,
                         boxShadow: [
                        
                  BoxShadow(
                            
                            color: colors.sp.withOpacity(0.3),
                            blurRadius: 6,
                            offset: Offset(0, 0)
                          ),
                  ]
                      ),
                     
                    ),
                      Expanded(
                        child: Column(
                          children: [
                            Text.rich(
                          TextSpan(
                            text: notif.nameSender,
                             style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w500,
                                      fontSize: Dimensitions.width15,
                                    ),
                            children: [
                              TextSpan(
                                text:" ${notif.content}" ,
                                 style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w400,
                                      fontSize: Dimensitions.width13,
                                      color: colors.text2
                                    ),
                              ),
                            ]
                          ),
                        ),
                     
                          ],
                        ),
                      ),
                                ],
                              ),
                
                ):Container();
            
                } 
               
              ).toList().cast<Widget>(),
            ),
           
           
            _notfiUpdateText("Ancien"),
            SizedBox(height: Dimensitions.height10,),
        
           Column(
              children: myNotif.myNotification.map(
                (notif){
                  // Parse the date string into a DateTime object
                    DateTime parsedDate = DateTime.parse(notif.timestamp);

                    // Get the current date and time
                    DateTime now = DateTime.now();

                    // Get today's date at 00:00
                    DateTime todayStart = DateTime(now.year, now.month, now.day);

                    // Get yesterday's date at 00:00
                    DateTime yesterdayStart = todayStart.subtract(Duration(days: 1));

                    return  !parsedDate.isAfter(todayStart) && !(parsedDate.isAfter(yesterdayStart) && parsedDate.isBefore(todayStart))?
                    Padding(
                  padding: EdgeInsets.only(bottom: Dimensitions.height10),
                  child: 
                  Row(
                              
                               crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                  Container(
                          
                          alignment: Alignment.topLeft,    
                       margin: EdgeInsets.only(bottom: Dimensitions.height10,right: Dimensitions.width8),
                      width: Dimensitions.height30,
                      height: Dimensitions.height30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: notif.imageSender==""?
                        DecorationImage(image: AssetImage("assets/images/img.png"),fit: BoxFit.cover)

                        :
                        DecorationImage(image: NetworkImage(notif.imageSender),fit: BoxFit.cover),
                        color: Colors.white,
                         boxShadow: [
                        
                  BoxShadow(
                            
                            color: colors.sp.withOpacity(0.3),
                            blurRadius: 6,
                            offset: Offset(0, 0)
                          ),
                  ]
                      ),
                     
                    ),
                      Expanded(
                        child: Column(
                          children: [
                            Text.rich(
                          TextSpan(
                            text: notif.nameSender,
                             style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w500,
                                      fontSize: Dimensitions.width15,
                                    ),
                            children: [
                              TextSpan(
                                text:" ${notif.content}" ,
                                 style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w400,
                                      fontSize: Dimensitions.width13,
                                      color: colors.text2
                                    ),
                              ),
                            ]
                          ),
                        ),
                     
                          ],
                        ),
                      ),
                                ],
                              ),
                
                ):Container();
            
                } 
               
              ).toList().cast<Widget>(),
            ),
           
            
            SizedBox(height: Dimensitions.height10,),
           
            
          ],
        ),
      );
   
        },
      ),
   
    ),
    );
   
  }
  Widget _notfiUpdateText(String wup){
    return Text(
            wup,
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.w500,
              fontSize: Dimensitions.width15,
            ),
            );
  }
}