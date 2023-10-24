import 'package:bus/config/colors.dart';
import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  String title;
  VoidCallback callBack;
  Color color;

  ElevatedButtonWidget({
    required this.title,
    required this.callBack,
    required this.color
});

  @override
  Widget build(BuildContext context) {
    return SizedBox(

      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shadowColor: Colors.black,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.0),
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
          ),
        ),
        onPressed: callBack,
        child:  Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.appTextColor2,
          ),
        ),
      ),
    );
  }
}
