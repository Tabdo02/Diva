import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfileTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final Color? fillColor;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final Color colorBorder;
  final String? initialValue;
  final bool readOnly;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;
  final TextAlign textAlign ;
  final TextInputType keyboardType;
  final void Function()? onTap;
  const MyProfileTextField({
    super.key,
    this.onTap,
    this.readOnly=false,
    required this.label,
    this.hintText="",
    this.fillColor,
    this.maxLength,
    this.textInputAction,
    this.inputFormatters,
    this.colorBorder=colors.text3,
    this.initialValue,
    this.controller,
    this.onChanged,
    this.suffixIcon,
    this.textAlign = TextAlign.start,
    this.keyboardType=TextInputType.text,
    });

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 
                  Text(
                    label,
                    style: GoogleFonts.openSans(
                      color: colors.text,
                      fontSize: Dimensitions.width13,
                      fontWeight: FontWeight.w600,
                    ),
                    ),
                  SizedBox(height: Dimensitions.height10,),
                  SizedBox(
                    height: Dimensitions.height70,
                    child: TextFormField(
                      onTap:onTap,
                      textAlign: textAlign,
                      enableInteractiveSelection: true,
                      onChanged: onChanged,
                      controller: controller,
                      readOnly: readOnly,
                      initialValue: initialValue,
                      inputFormatters: inputFormatters,
                      style: GoogleFonts.openSans(
                        fontSize: Dimensitions.width14,
                        fontWeight: FontWeight.w500,
                        color: colors.text,
                      ),
                    
                      maxLength: maxLength,
                      textInputAction: textInputAction,
                      keyboardType: keyboardType,
                      decoration: InputDecoration(
                        suffixIcon: suffixIcon,
                        fillColor: fillColor,
                        filled: true,
                        hintText: hintText,
                        hintStyle: GoogleFonts.openSans(
                          fontSize: Dimensitions.width15,
                          fontWeight: FontWeight.w300,
                          color: colors.text3
                        ),
      
                        enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensitions.height10),
                        borderSide: BorderSide(color: colorBorder)
                    
                        ),
                        disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensitions.height10),
                        borderSide: BorderSide(color: colorBorder)
                    
                        ),
                        focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensitions.height10),
                        borderSide: BorderSide(color: colors.rose3)
                    
                        ),
                      ),
                    ),
                  ),
      
                ],
              ),
    )
          ;
  }
}