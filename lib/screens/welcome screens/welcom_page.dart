import 'package:diva/compoents/auth/button_auth.dart';
import 'package:diva/routes/route_helper.dart';
import 'package:diva/screens/welcome%20screens/pages/page1.dart';
import 'package:diva/screens/welcome%20screens/pages/page2.dart';
import 'package:diva/screens/welcome%20screens/pages/page4.dart';
import 'package:diva/screens/welcome%20screens/pages/page5.dart';
import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final _controller = PageController();
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_handlePageChange);
  }

  @override
  void dispose() {
    _controller.removeListener(_handlePageChange);
    _controller.dispose();
    super.dispose();
  }

  void _handlePageChange() {
    setState(() {
      _currentPageIndex = _controller.page!.toInt();
    });
  }
  // reference the code 
  final _myBox=Hive.box('FirstTime');
  void writeData(){
    _myBox.put(1, true);
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: colors.bg,
      body: Column(
        children: [
          SizedBox(
           
            height: Dimensitions.height550,
            child: PageView(
              controller: _controller,
              children:const  [
                SecondPage(),
                //TherdPage(),
                FourthPage(),
               FifthPage(),
                FirstPage(),
              ],
            ),
          ),
         
          SmoothPageIndicator(
            
            controller: _controller,
            count: 4,

            effect: ScrollingDotsEffect(

              paintStyle: PaintingStyle.stroke,
              strokeWidth: 2,
              dotHeight: Dimensitions.height5,
              dotWidth: Dimensitions.height5,
              spacing: Dimensitions.width15,
              activeDotColor: colors.sp,
            ),
          ),
          SizedBox(height: Dimensitions.height15),
        _currentPageIndex==3?  ButtonWelcome(
          name: "commencer",
          onTap: () {
           writeData();
           Get.offAllNamed(RouteHelper.getsignUp());
          },
          )
          :Container(),
        ],
      ),
    );
  }
}
