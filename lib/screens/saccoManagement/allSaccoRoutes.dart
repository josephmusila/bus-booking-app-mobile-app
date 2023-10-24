import 'package:bus/config/colors.dart';

import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
import 'package:flutter/material.dart';

import '../../models/routeModel.dart';

class SaccoRoutesScreen extends StatelessWidget {
  List<RouteModel> saccoRoutes;

  SaccoRoutesScreen({required this.saccoRoutes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MediumTextWidget(
            data: "Sacco Routes", color: AppColors.appPrimaryColor),
      ),
      body: SafeArea(
        child: SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: ListView(
            padding: const EdgeInsets.only(top: 10),
            children: List.generate(
              saccoRoutes.length,
              (index) => Card(
                child: ListTile(
                  leading: MediumTextWidget(
                      data: "${index + 1}", color: AppColors.appTextColor1),
                  title: MediumTextWidget(
                    data: saccoRoutes[index].destination,
                    color: AppColors.appTextColor1,
                  ),
                  subtitle: SmallTextWidget(
                    data: "Fare: ${saccoRoutes[index].fare}",
                    color: AppColors.appPrimaryColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
