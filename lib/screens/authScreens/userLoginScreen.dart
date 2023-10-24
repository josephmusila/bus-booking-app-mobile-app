import 'package:bus/config/colors.dart';
import 'package:bus/widgets/appCustomWidgets/outlinedButtonWidget.dart';
import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
import 'package:flutter/material.dart';

import '../../widgets/appCustomWidgets/ElevatedButtonWidget.dart';
import '../../widgets/appCustomWidgets/inputFieldWidget.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {

  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  bool hidePassword=true;

  @override
  Widget build(BuildContext context) {
    return
       Form(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InputFieldWidget(
                validator: (value) {},
                controller: emailController,
                labelText: "Email",
                hint: "john.doe02@gmail.com",
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              InputFieldWidget(
                validator: (value) {},
                controller: passwordController,
                labelText: "Password",
                hint: "*********",
                hideText: hidePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    hidePassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                    // color: AppColors.appTextColor2,
                  ),
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                ),
              ),

              const SizedBox(height: 16),
              Container(
                height: 42,
                width: double.maxFinite,
                child: ElevatedButtonWidget(
                  color: AppColors.appMainColor,
                  title: "Login",
                  callBack: (){},
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 42,
                width: double.maxFinite,
                child: OutlinedButtonWidget(
                  onpressed: (){},
                  buttonText: "Forgot Password",
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 42,
                width: double.maxFinite,
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SmallTextWidget(data: "New User?", color: AppColors.appTextColor1),
                    TextButton(onPressed: (){}, child: MediumTextWidget(data: "Register Here", color: AppColors.appPrimaryColor))
                  ],
                ),
              )
            ],
          ),
        ),

    );
  }
}
