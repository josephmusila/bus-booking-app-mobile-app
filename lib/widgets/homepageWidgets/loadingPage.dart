import 'package:bus/config/colors.dart';
import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
import 'package:flutter/material.dart';

class HomePageLoadingScreen extends StatelessWidget {
  String title;

  HomePageLoadingScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        color: AppColors.appPrimaryColor,
        child: Center(
          child: Container(
            height: 200,
            width: double.maxFinite,
            margin: const EdgeInsets.all(20),
            // color: AppColors.appBgColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MediumTextWidget(data: title, color: AppColors.appTextColor2),
                const LinearProgressIndicator(

                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



