import 'package:bus/cubits/authentication/authCubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../config/colors.dart';
import '../appCustomWidgets/ElevatedButtonWidget.dart';
import '../appCustomWidgets/inputFieldWidget.dart';
import '../appCustomWidgets/outlinedButtonWidget.dart';
import '../appCustomWidgets/textWidget.dart';

class LoginFormWidget extends StatefulWidget {
  String? email;
  String? password;

  LoginFormWidget({this.email, this.password});
  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hidePassword = true;
  Color borderColor = Colors.black26;
  bool isLoading = false;
  IconData? emailIcon;
  Color? emailIconColor;
  Color? c;

  @override
  void initState() {
    emailController.text = widget.email ?? "";
    passwordController.text = widget.password ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AuthCubits>(context);
    return Form(
      child: Stack(
        children: [
          isLoading
              ? Center(
                  child: Container(
                    color: AppColors.whiteColor1,
                    height: 100,
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        MediumTextWidget(
                            data: "Logging", color: AppColors.appTextColor3),
                        const LinearProgressIndicator(
                          backgroundColor: AppColors.appMainColor,
                          color: AppColors.appPrimaryColor,
                        )
                      ],
                    ),
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: double.maxFinite,
                        child: Center(
                          child: MediumTextWidget(
                              data: "Login", color: AppColors.appMainColor),
                        ),
                      ),
                      Container(
                          height: 42,
                          width: double.maxFinite,
                          child: StreamBuilder(
                            stream: bloc.loginErrorStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return SmallTextWidget(
                                    color: Colors.red,
                                    data: snapshot.error.toString());
                              } else {
                                return Container();
                              }
                            },
                          )),
                      const SizedBox(
                        height: 16,
                      ),
                      StreamBuilder(
                          stream: bloc.emailStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              borderColor = Colors.red;
                              emailIconColor=Colors.red;
                              emailIcon=Icons.cancel_outlined;
                            } else {
                              emailIconColor=Colors.green;
                              borderColor = Colors.green;
                              emailIcon = Icons.check;
                            }
                            return Column(
                              children: [
                                // SmallTextWidget(data: "Email", color: AppColors.appTextColor1),
                                InputFieldWidget(
                                  borderColor: borderColor,
                                  validator: (value) {},
                                  controller: emailController,
                                  labelText: "Email",
                                  hint: "john.doe02@gmail.com",
                                  textInputType: TextInputType.emailAddress,
                                  suffixIcon: Icon(
                                    emailIcon ?? Icons.cancel_outlined,
                                    color: emailIconColor
                                  ),
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
                      const SizedBox(height: 16),
                      StreamBuilder(
                          stream: bloc.passwordStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              borderColor = Colors.red;
                            } else {
                              borderColor = Colors.green;
                            }
                            return Column(
                              children: [
                                InputFieldWidget(
                                  borderColor: borderColor,
                                  validator: (value) {},
                                  controller: passwordController,
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
                                snapshot.hasError
                                    ? Container(
                                        // height: 20,
                                        child: SmallTextWidget(
                                            color: Colors.red,
                                            data: snapshot.error.toString()))
                                    : Container(),
                              ],
                            );
                          }),
                      const SizedBox(height: 16),
                      Container(
                          height: 42,
                          width: double.maxFinite,
                          child: StreamBuilder(
                            stream: bloc.buttonValid,
                            builder: (context, snapshot) {
                              return ElevatedButtonWidget(
                                color: snapshot.hasData
                                    ? AppColors.appMainColor
                                    : Colors.black26,
                                title: "Login",
                                callBack: snapshot.hasData
                                    ? () {
                                        // bloc.showMessage(context);
                                        setState(() {
                                          isLoading = true;
                                        });
                                        bloc.loginUser(context);
                                      }
                                    : () {},
                              );
                            },
                          )),
                      const SizedBox(height: 16),
                      Container(
                        height: 42,
                        width: double.maxFinite,
                        child: OutlinedButtonWidget(
                          onpressed: () {},
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
                            SmallTextWidget(
                                data: "New User?",
                                color: AppColors.appTextColor1),
                            TextButton(
                                onPressed: () {
                                  bloc.proceedToRegister();
                                },
                                child: MediumTextWidget(
                                    data: "Register Here",
                                    color: AppColors.appPrimaryColor))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
