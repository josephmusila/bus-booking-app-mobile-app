import 'package:bus/config/colors.dart';
import 'package:bus/widgets/appCustomWidgets/ElevatedButtonWidget.dart';
import 'package:bus/widgets/appCustomWidgets/outlinedButtonWidget.dart';
import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/sacco/saccoCubits.dart';
import '../../services/saccoServices.dart';
import '../../widgets/appCustomWidgets/inputFieldWidget.dart';
import '../appAdmin/adminLandingPage.dart';

class SystemAdminLoginScreen extends StatelessWidget {
  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MediumTextWidget(data: "System Admin Login",color: AppColors.appPrimaryColor),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        )
      ),
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 300,
            width: double.maxFinite,
            child: Column(
              children: [
                InputFieldWidget(
                  validator: (value) {},
                  controller: controller,
                  labelText: "email",
                  hint: "john.doe@gmail.com",
                ),
                const SizedBox(
                  height: 10,
                ),
                InputFieldWidget(
                  validator: (value) {},
                  controller: controller,
                  labelText: "Password",
                  hint: "*******",
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButtonWidget(
                      title: "Login",
                      callBack: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return BlocProvider(
                            create: (context) =>
                                SaccoCubits(saccoServices: SaccoServices()),
                            child: const AdminLandingPage(),
                          );
                        }));
                      },
                      color: AppColors.appPrimaryColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: OutlinedButtonWidget(
                    buttonText: "Forgot Password",
                    onpressed: (){},
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
