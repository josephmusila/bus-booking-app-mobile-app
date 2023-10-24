import 'package:bus/cubits/authentication/authCubits.dart';
import 'package:bus/widgets/authWidgets/loginForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/colors.dart';
import '../../screens/authScreens/userLoginScreen.dart';
import '../../services/authservices.dart';
import '../appCustomWidgets/ElevatedButtonWidget.dart';
import '../appCustomWidgets/inputFieldWidget.dart';
import '../appCustomWidgets/textWidget.dart';

class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({super.key});

  @override
  State<RegisterFormWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  bool hidePassword = true;
  Color borderColor=Colors.black26;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<AuthCubits>(context);
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.only(top: 16),
        children: [
          Container(
            height: 50,
            width: double.maxFinite,
            child: Center(
              child: MediumTextWidget(data: "Register",color: AppColors.appMainColor),
            ),
          ),
          const SizedBox(height: 16,),
          InputFieldWidget(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "please fill in the  field";
              }
              return null;
            },
            controller: firstnameController,
            labelText: "First Name",
            hint: "john",
          ),
          const SizedBox(height: 16),
          InputFieldWidget(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "please fill in the  field";
              }
              return null;
            },
            controller: lastNameController,
            labelText: "Last Name",
            hint: "doe",
          ),
          const SizedBox(
            height: 16,
          ),
          StreamBuilder(
              stream: bloc.emailStream,
              builder: (context, snapshot) {
                return Column(
                  children: [
                    InputFieldWidget(
                      validator: (value) {},
                      controller: emailController,
                      labelText: "Email",
                      hint: "john.doe02@gmail.com",
                      textInputType: TextInputType.emailAddress,
                      onChanged: (value) {
                        bloc.validateEmail(value);

                        return value;
                      },
                    ),
                    snapshot.hasError
                        ? Container(
                        height: 20,
                        child: SmallTextWidget(
                            color: Colors.red,
                            data: snapshot.error.toString()))
                        : Container(),
                  ],
                );
              }),
          const SizedBox(
            height: 16,
          ),
          InputFieldWidget(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "please fill in the  field";
              }
              return null;
            },
            controller: phoneNumberController,
            labelText: "Phone Number",
            hint: "0712346678",
            textInputType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          InputFieldWidget(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "please fill in the  field";
              }
              return null;
            },
            controller: idNumberController,
            labelText: "Id/Passport Number",
            hint: "22222222",
          ),
          const SizedBox(height: 16),
          InputFieldWidget(
            validator: (value) {
              if (value != password2Controller.text) {
                return "Passwords do not match";
              }else if (value.length <8) {
                return 'Password should contain'
                    'at least 8 characters';

              }
              return null;
            },
            controller: password1Controller,
            labelText: "Password",
            hint: "*********",
            hideText: hidePassword,
            onChanged: (value) {
              bloc.validatePassword(value);
              return value;
            },
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
          InputFieldWidget(
            validator: (value) {
              if (value != password1Controller.text) {
                return "Passwords do not match";
              }else if (value.length <8) {
                return 'Password should contain'
                    'at least 8 characters';

              }
              return null;
            },
            controller: password2Controller,
            labelText: "Confirm Password",
            hint: "*********",
            hideText: hidePassword,
            onChanged: (value) {
              bloc.validatePassword(value);
              return value;
            },
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
              title: "Register",
              callBack: () {
                if(_formKey.currentState!.validate()){
                  bloc.registerUser(
                      firtsName: firstnameController.text,
                      lastName: lastNameController.text,
                      email: emailController.text,
                      password: password2Controller.text,
                      phoneNumber: phoneNumberController.text,
                      idNumber: idNumberController.text);
                }

              }
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 42,
            width: double.maxFinite,
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SmallTextWidget(
                    data: "Already Registered?",
                    color: AppColors.appTextColor1),
                TextButton(
                    onPressed: () {
                      bloc.proceedToLogin();
                    },
                    child: MediumTextWidget(
                        data: "Log In Here", color: AppColors.appPrimaryColor))
              ],
            ),
          )
        ],
      ),
    );
  }
}
