import 'package:bus/config/colors.dart';
import 'package:bus/cubits/authentication/authCubits.dart';
import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/userModel.dart';
import '../appCustomWidgets/ElevatedButtonWidget.dart';
import '../appCustomWidgets/outlinedButtonWidget.dart';


class RegisterSuccesfulWidget extends StatelessWidget {
  UserModel user;
   RegisterSuccesfulWidget({required this.user});

  @override
  Widget build(BuildContext context) {
    final bloc=BlocProvider.of<AuthCubits>(context);
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      child: Column(
        children: [
          Container(
            height: 50,
            width: double.maxFinite,
            child: Center(
              child: MediumTextWidget(data: "Registration Successful",color: AppColors.appMainColor),
            ),
          ),
          Card(
            child: Container(
              // height: 300,
              width:  double.maxFinite,
              padding: const EdgeInsets.all(8),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SmallTextWidget(data: "Hello ${user.firstName}", color: AppColors.appTextColor1),
                  SmallTextWidget(data: "Registration Details", color: AppColors.appPrimaryColor),
                  const SizedBox(height: 16,),
                  SmallTextWidget(data: "Names: ${user.firstName} ${user.lastName}", color: AppColors.appTextColor1),
                  SmallTextWidget(data: "Email: ${user.email}", color: AppColors.appTextColor1),
                  SmallTextWidget(data: "Phone: ${user.phone}", color: AppColors.appTextColor1),
                  SmallTextWidget(data: "Id/Passport Number: ${user.idNumber}", color: AppColors.appTextColor1),
                ],
              ),
            ),
          ),
          Spacer(),
          const SizedBox(height: 16),
          Container(
            height: 42,
            width: double.maxFinite,
            child: ElevatedButtonWidget(
              color: AppColors.appMainColor,
              title: "Proceed To Login",
              callBack: () {
                bloc.proceedToLogin();
                // bloc.registerUser(
                //     firtsName: firstnameController.text,
                //     lastName: lastNameController.text,
                //     email: emailController.text,
                //     password: password2Controller.text,
                //     phoneNumber: phoneNumberController.text,
                //     idNumber: idNumberController.text);
              },
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 42,
            width: double.maxFinite,
            child: OutlinedButtonWidget(
              onpressed: (){},
              buttonText: "Update Details",
            ),
          ),

        ],
      ),
    );
  }
}
