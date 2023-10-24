import 'package:bus/config/colors.dart';
import 'package:bus/cubits/authentication/authCubits.dart';
import 'package:bus/models/userModel.dart';
import 'package:bus/services/authservices.dart';
import 'package:bus/widgets/appCustomWidgets/ElevatedButtonWidget.dart';
import 'package:bus/widgets/appCustomWidgets/outlinedButtonWidget.dart';
import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../authScreens/editProfileScreen.dart';

class UserAccountScreen extends StatelessWidget {
  UserModel user;

  UserAccountScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      body: SafeArea(
        child: SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: ListView(
            children: [
              Container(
                height: 200,
                width: double.maxFinite,
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: AppColors.appMainColor,
                    border:
                        Border.all(color: AppColors.appAccentColor, width: 2),
                    borderRadius: BorderRadius.circular(10)),
                child: Stack(
                  children: [
                    // Container(
                    //   height: 50,
                    //   width: 50,
                    //   decoration: BoxDecoration(
                    //       color: AppColors.whiteColor1,
                    //       borderRadius: BorderRadius.circular(10)),
                    //   child: const Icon(
                    //     Icons.account_circle_outlined,
                    //     size: 50,
                    //     color: AppColors.whiteColor,
                    //   ),
                    // ),
                    //  Positioned(
                    //   top: 0,
                    //   right: 0,
                    //   child: ElevatedButtonWidget(
                    //     color: AppColors.appPrimaryColor.withOpacity(0.2),
                    //     title: "Edit",
                    //     callBack: (){},
                    //   ),
                    // ),
                    Positioned(
                      right: 0,
                      top: 0,
                      left: 0,
                      child: SmallTextWidget(
                        data: "${user.firstName} ${user.lastName}",
                        color: AppColors.appTextColor2,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 30,
                      left: 0,
                      child: SmallTextWidget(
                        data: "ID: ${user.idNumber}",
                        color: AppColors.appTextColor2,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 60,
                      left: 0,
                      child: SmallTextWidget(
                        data: "Phone No: ${user.phone}",
                        color: AppColors.appTextColor2,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 90,
                      left: 0,
                      child: SmallTextWidget(
                        data: "Email: ${user.email}",
                        color: AppColors.appTextColor2,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 120,
                      left: 0,
                      child: SmallTextWidget(
                        data: "Male",
                        color: AppColors.appTextColor2,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 8,
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return BlocProvider(
                      create: (context) =>
                          AuthCubits(authServices: AuthServices()),
                      child: EditProfileScreen(user: user),
                    );
                  }));
                },
                leading: const Icon(Icons.edit),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
                title: SmallTextWidget(
                  data: "Edit Profile",
                  color: AppColors.appTextColor1,
                ),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.image),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
                title: SmallTextWidget(
                  data: "Update Profile Picture",
                  color: AppColors.appTextColor1,
                ),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.history),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
                title: SmallTextWidget(
                  data: "Delete History",
                  color: AppColors.appTextColor1,
                ),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.logout_outlined),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
                title: SmallTextWidget(
                  data: "Log Out",
                  color: AppColors.appTextColor1,
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.apps_outlined),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
                title: SmallTextWidget(
                  data: "About App",
                  color: AppColors.appTextColor1,
                ),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.list),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
                title: SmallTextWidget(
                  data: "Terms Of Service",
                  color: AppColors.appTextColor1,
                ),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.group),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
                title: SmallTextWidget(
                  data: "Credits",
                  color: AppColors.appTextColor1,
                ),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.info),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
                title: SmallTextWidget(
                  data: "Other Information",
                  color: AppColors.appTextColor1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
