import 'package:diva/compoents/home/app_bar.dart';
import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';


class MyQRCode extends StatefulWidget {
  final String image;
  final String name;
   MyQRCode({super.key,required this.name,required this.image});

  @override
  State<MyQRCode> createState() => _MyQRCodeState();
}

class _MyQRCodeState extends State<MyQRCode> {
  bool _switch=true;
 bool _isScanCompleted=false;
 String _code="Place code inside the box. Tap here to help.";
 void CloseScreen(){
  _isScanCompleted=false;
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:MyAppBar(
        tit: "Mon QR code",
        fn:true,
        ),
      backgroundColor: colors.bg,
      body: 
      Column(
        children: [
          SizedBox(height: Dimensitions.height10,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: Dimensitions.width25),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                   onTap: () {
                     setState(() {
                      // _isScanCompleted=false;
                      _switch=!_switch;
                     });
                   },
                    child: Container(
                      height: Dimensitions.height50,
                      decoration: BoxDecoration(
                        color: _switch? colors.bg:colors.sp,
                        border: Border.all(color: colors.rose7,width: Dimensitions.height0_3),
                        borderRadius: BorderRadius.circular(Dimensitions.height10)
                      
                      ),
                      child: Center(
                        child: Text(
                          "Scan",
                         style: GoogleFonts.openSans(
                          color: _switch?colors.text3:Colors.white,
                          fontSize: Dimensitions.width15,
                          fontWeight: FontWeight.w400,
                         ),
                          ),
                      ),
                    ),
                  )
                  ),
                  SizedBox(width: Dimensitions.width30,),
                  Expanded(
                  child: GestureDetector(
                    onTap: ()=>setState(() {
                      _switch=!_switch;
                    }),
                    child: Container(
                      height: Dimensitions.height50,
                      decoration: BoxDecoration(
                        color:_switch?colors.sp:colors.bg,
                          border: Border.all(color: colors.rose7,width: Dimensitions.height0_3),
                       
                        borderRadius: BorderRadius.circular(Dimensitions.height10)
                      
                      ),
                      child: Center(
                        child: Text(
                          "Mon QR",
                         style: GoogleFonts.openSans(
                          color:_switch?Colors.white:colors.text3,
                          fontSize: Dimensitions.width15,
                          fontWeight: FontWeight.w400,
                         ),
                          ),
                      ),
                    ),
                  )
                  ),
              ],
            ),
          ),
          SizedBox(
            height: Dimensitions.height30,
          ),
        _switch?
        Container()
        :  Expanded(
           child:
           Stack(
            children: [
               Container(
                height: double.maxFinite,
                width: double.maxFinite,
                 child: MobileScanner(
                 
                             onDetect: (BarcodeCapture barcodeCapture) {
                               for (var barcode in barcodeCapture.barcodes) {
                  final String? code = barcode.rawValue;
                   if (code != null) {
                  setState(() {
                  _isScanCompleted = true;
                  });
               
                  print("QR Code: $code");
                 
                  // Perform additional actions here, e.g., navigate to another screen or show a dialog
                 
                  break; // Stop further processing as scan is completed
                               }
                  
                               }
                               
                             },
                            ),
               ),
            QRScannerOverlay(
             //
             overlayColor: Colors.transparent,
              borderColor:Colors.white,
              borderRadius: Dimensitions.height10,
              borderStrokeWidth:4,
              scanAreaWidth: Dimensitions.width250,
              scanAreaHeight: Dimensitions.height250,
            ),
         _isScanCompleted?   
         Container()
         :
         Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: Dimensitions.height10),
                padding: EdgeInsets.all(Dimensitions.height8),
                decoration: BoxDecoration(
                  color: colors.text.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(Dimensitions.height7)
                ),
                child: Text(
                  _code,
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: Dimensitions.width13,
                    fontWeight: FontWeight.w500
                  ),
                  ),
              ),
            ),
            ],
           )
            ),
           
          //mon codebar
    _switch? 
     Column(
        children: [    Container(
                margin: EdgeInsets.only(top: Dimensitions.height2,bottom: Dimensitions.height5),
              height: Dimensitions.height120,
              width: Dimensitions.height120,
              decoration: BoxDecoration(
                color: colors.rose1,
                shape: BoxShape.circle,
                image: widget.image==""?
                DecorationImage(
                  image: AssetImage("assets/images/img.png"),
                  fit: BoxFit.contain
                  ):DecorationImage(
                  image: NetworkImage(widget.image),
                  fit: BoxFit.contain
                  )
                ),
                        ),
                        Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       
          Text(
          widget.name,
          style: GoogleFonts.openSans(
          textStyle: TextStyle(
            color: colors.text2,
            fontWeight: FontWeight.bold,
            fontSize: Dimensitions.width18,
      
          )
        ),
        ),
         
      ],
             ),
      
      SizedBox(
            height: Dimensitions.height25,
          ),
      // for the qr code
          Container(
            padding: EdgeInsets.all(Dimensitions.height7),
            height: Dimensitions.height240,
            width: Dimensitions.width200,
            decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(Dimensitions.height10)
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensitions.height10),
                  ),
                  child: QrImageView(
        data: FirebaseAuth.instance.currentUser!.uid,
        version: QrVersions.auto,
        size: Dimensitions.height300,
       // embeddedImage: AssetImage('assets/Logo/logo_g1614.png'),
        embeddedImageStyle: QrEmbeddedImageStyle(
      
          size: Size(Dimensitions.width50, Dimensitions.height50),
        ),
      ),
                ),
              ),
              SizedBox(height: Dimensitions.height5,),
              Text(
                "SCAN ME",
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: Dimensitions.width26,
                  fontWeight: FontWeight.w400,
                ),
                )
            ],
          ),
          ),
   ],
      )
     :
     Container(),
        ],
      ),
    
    );
  }


}