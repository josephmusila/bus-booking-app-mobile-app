import 'package:flutter/material.dart';

import '../../config/colors.dart';


class InputFieldWidget extends StatefulWidget {
  String labelText;
  String hint;
  TextEditingController controller;
  dynamic validator;
  TextInputType? textInputType;
  dynamic onChanged;
  bool? hideText;
  Widget? suffixIcon;
  Color? borderColor;


  InputFieldWidget({
    required this.hint,
    required this.labelText,
    required this.controller,
    required this.validator,
    this.textInputType,
    this.onChanged,
    this.hideText,
    this.suffixIcon,
    this.borderColor
});

  @override
  State<InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged:widget.onChanged,
      keyboardType: widget.textInputType,
      validator: widget.validator,
      controller: widget.controller,
      obscureText: widget.hideText==null?false:widget.hideText as bool,
      decoration:  InputDecoration(
        suffixIcon: widget.suffixIcon,
        contentPadding: EdgeInsets.all(8),
        border:  const OutlineInputBorder(
        // borderSide: BorderSide(color: widget.borderColor==null?Colors.black26:widget.borderColor as Color)
        ),
        // focusedBorder:  const ,
          focusedBorder:   OutlineInputBorder(
            borderSide: BorderSide(color: widget.borderColor==null?AppColors.appPrimaryColor:widget.borderColor as Color, width: 2.0),
          ),
        labelText: widget.labelText,
        hintText: widget.hint,
        hintStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        labelStyle: const TextStyle(
          fontSize: 16
        )

      ),

    );
  }
}
