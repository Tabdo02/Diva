import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomTextField extends StatefulWidget {
  final String label;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final VoidCallback? onSubmitted;
  final bool obscureText ;
  final String? Function(String?)? validator;
  CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.keyboardType, 
    required this.textInputAction,
    this.inputFormatters= const[],
    this.obscureText=false,
    this.onSubmitted,
    required this.validator,
    });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
    @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
   setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      child: Column(
        children: [
          // label
          Row(
            children: [
          SizedBox(width: Dimensitions.width3,),

              Text(widget.label,
              style: GoogleFonts.openSans(
                textStyle:TextStyle(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                  fontSize: Dimensitions.width15,
                    
                ),
              ),),
      
            ],
          ),
          SizedBox(height: Dimensitions.height10,),
          // TextFormField
          SizedBox(
            height: Dimensitions.height55,
            child: TextFormField( 
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: widget.validator,
              obscureText: widget.obscureText,
              inputFormatters: widget.inputFormatters,
              keyboardType: widget.keyboardType,  
              textInputAction: widget.textInputAction,    
              focusNode: _focusNode,
              cursorColor: colors.sp,
              controller: widget.controller,
              style:  GoogleFonts.openSans(
                textStyle:TextStyle(
                  color:colors.text,
                  fontSize: Dimensitions.width15,
                  fontWeight: FontWeight.w600
                ),
              ),
              decoration: InputDecoration(
              isDense: true,
                  errorStyle: TextStyle(height:Dimensitions.height0_1, fontSize: Dimensitions.width11),
                filled: true,
                fillColor:_isFocused ?Colors.white.withOpacity(0.3) : colors.border,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensitions.width10),
                  borderSide:const BorderSide(color: colors.text,),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensitions.width10),
                  borderSide: BorderSide(color: colors.sp,width: Dimensitions.height2), 
                ),
                errorBorder:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensitions.width10),
                  borderSide: BorderSide(color: Colors.red,width: Dimensitions.height2), 
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensitions.width10),
                  borderSide: BorderSide(color: Colors.red,width: Dimensitions.height2), 
                )
              ),
               onFieldSubmitted: (value) {
                // If onSubmitted callback is provided, invoke it
                if (widget.onSubmitted != null) {
                  widget.onSubmitted!();
                }
              },
            ),
          ),
      
        ],
      ),
    );
  }
}