import 'package:bus/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/colors.dart';
import '../../cubits/authentication/authCubits.dart';
import '../../widgets/appCustomWidgets/ElevatedButtonWidget.dart';
import '../../widgets/appCustomWidgets/inputFieldWidget.dart';
import '../../widgets/appCustomWidgets/textWidget.dart';

class EditProfileScreen extends StatefulWidget {
  UserModel user;

  EditProfileScreen({required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  bool hidePassword = true;

  @override
  void initState() {
    firstnameController.text = widget.user.firstName;
    lastNameController.text = widget.user.lastName;
    emailController.text = widget.user.email;
    idNumberController.text = widget.user.idNumber;
    phoneNumberController.text = widget.user.phone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<AuthCubits>(context);
    return Scaffold(
      appBar: AppBar(
        title: MediumTextWidget(data: "UpDate Profile",color: AppColors.appTextColor3),
      ),
      body: SafeArea(
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          padding: const EdgeInsets.all(16),
          child: Form(
            child: ListView(
              padding: const EdgeInsets.only(top: 16),
              children: [
                InputFieldWidget(
                  validator: (value) {},
                  controller: firstnameController,
                  labelText: "First Name",
                  hint: "john",
                ),
                const SizedBox(height: 16),
                InputFieldWidget(
                  validator: (value) {},
                  controller: lastNameController,
                  labelText: "Last Name",
                  hint: "doe",
                ),
                const SizedBox(
                  height: 16,
                ),
                InputFieldWidget(
                  validator: (value) {},
                  controller: emailController,
                  labelText: "Email",
                  hint: "john.doe02@gmail.com",
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 16,
                ),
                InputFieldWidget(
                  validator: (value) {},
                  controller: phoneNumberController,
                  labelText: "Phone Number",
                  hint: "0712346678",
                  textInputType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                InputFieldWidget(
                  validator: (value) {},
                  controller: idNumberController,
                  labelText: "Id/Passport Number",
                  hint: "22222222",
                ),
                const SizedBox(height: 16),
                InputFieldWidget(
                  validator: (value) {},
                  controller: password1Controller,
                  labelText: "Password",
                  hint: "*********",
                  hideText: hidePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      hidePassword ? Icons.visibility : Icons.visibility_off,
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
                InputFieldWidget(
                  validator: (value) {},
                  controller: password2Controller,
                  labelText: "Confirm Password",
                  hint: "*********",
                  hideText: hidePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      hidePassword ? Icons.visibility : Icons.visibility_off,
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
                    title: "Update",
                    callBack: () {
                      bloc.updateProfile(
                        id: widget.user.id.toString(),
                          firstName: firstnameController.text,
                          lastname: lastNameController.text,
                          email: emailController.text,
                          password: password2Controller.text,
                          phone: phoneNumberController.text,
                          idnumber: idNumberController.text);
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // Container(
                //   height: 42,
                //   width: double.maxFinite,
                //   child: Row(
                //     // crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       SmallTextWidget(
                //           data: "Already Registered?",
                //           color: AppColors.appTextColor1),
                //       TextButton(
                //           onPressed: () {
                //             bloc.proceedToLogin();
                //           },
                //           child: MediumTextWidget(
                //               data: "Log In Here",
                //               color: AppColors.appPrimaryColor))
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
