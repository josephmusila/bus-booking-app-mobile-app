import 'package:flutter/material.dart';

import '../../config/colors.dart';
import '../../widgets/appCustomWidgets/textWidget.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.whiteColor1,
              borderRadius: BorderRadius.circular(10)),
          height: 400,
          width: double.maxFinite,
          child: Column(
            children: List.generate(
              5,
              (index) => Card(
                color: AppColors.whiteColor1,
                child: ListTile(
                    tileColor: AppColors.whiteColor1,
                    title: SmallTextWidget(
                        data: "Latest Trips", color: AppColors.appTextColor1),
                    subtitle: SmallTextWidget(
                        data: "Nairobi-Thika", color: AppColors.appAccentColor),
                    trailing: SmallTextWidget(
                      color: AppColors.appMainColor,
                      data: "Ksh 70",
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
