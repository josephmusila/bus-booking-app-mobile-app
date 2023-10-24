import 'package:bus/config/colors.dart';
import 'package:bus/widgets/appCustomWidgets/ElevatedButtonWidget.dart';
import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
import 'package:flutter/material.dart';

import '../../models/saccoModel.dart';

class SaccoAdmin extends StatefulWidget {
  SaccoModel sacco;

  SaccoAdmin({
    required this.sacco
});

  @override
  State<SaccoAdmin> createState() => _SaccoAdminState();
}

class _SaccoAdminState extends State<SaccoAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      appBar: AppBar(
        title: MediumTextWidget(
            data: "Sacco Admin", color: AppColors.appPrimaryColor),
      ),
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: ListView(
          children: [
            Card(
              child: Container(
                height: 300,
                // margin: const EdgeInsets.all(10),
                width: double.maxFinite,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.whiteColor1),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 70,
                      child: Container(
                        color: Colors.red,
                        child: Image.network(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_JCTzHccHrqYgasezcbS__wfraAuaAT8wBA&usqp=CAU",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      left: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SmallTextWidget(
                              data: "Naekana Sacco",
                              color: AppColors.appTextColor1),
                          SmallTextWidget(
                              data: "Naekana Sacco",
                              color: AppColors.appTextColor1),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Card(
              color: AppColors.appMainColor,
              shadowColor: AppColors.appComplementaryColor1,
              child: Container(
                padding: const EdgeInsets.all(10),
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BigTextWidget(
                        data: "Vehicles", color: AppColors.appTextColor2),
                    const Icon(
                      Icons.car_rental_rounded,
                      size: 70,
                      color: AppColors.appComplementaryColor1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButtonWidget(
                          title: "See All",
                          callBack: () {},
                          color: AppColors.appComplementaryColor1,
                        ),
                        ElevatedButtonWidget(
                          title: "Add New",
                          callBack: () {},
                          color: AppColors.appPrimaryColor,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
