import 'package:bus/config/colors.dart';
import 'package:bus/cubits/authentication/authStattes.dart';
import 'package:bus/screens/authScreens/userLoginScreen.dart';
import 'package:bus/screens/bottomNavScreens/userAccountScreen.dart';
import 'package:bus/screens/mainScreen.dart';
import 'package:bus/widgets/appCustomWidgets/ElevatedButtonWidget.dart';
import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
import 'package:bus/widgets/authWidgets/loginForm.dart';
import 'package:bus/widgets/homepageWidgets/loadingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/authentication/authCubits.dart';
import '../../widgets/appCustomWidgets/inputFieldWidget.dart';
import '../../widgets/authWidgets/registerForm.dart';
import '../../widgets/authWidgets/registerSuccesfulWidget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenScreenState();
}

class _AuthScreenScreenState extends State<AuthScreen> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  bool hidePassword = true;
  String appBartitle="";
  @override
  void initState() {
   BlocProvider.of<AuthCubits>(context).readLoginInformation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            color: AppColors.appBgColor,
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<AuthCubits, AuthState>(builder: (context, state) {
              if (state is AuthLoadingState) {
                return Center(
                  child: Container(
                    color: AppColors.whiteColor1,
                    height: 100,
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        MediumTextWidget(data: state.message, color: AppColors.appTextColor3),
                        const LinearProgressIndicator(backgroundColor: AppColors.appMainColor,color: AppColors.appPrimaryColor,)
                      ],
                    ),
                  ),
                );
                // return HomePageLoadingScreen(title: state.message);
              } else if(state is RegisterInitialState){
                return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: const RegisterFormWidget());
              }
              else if (state is RegisterSuccessfulState) {
                return RegisterSuccesfulWidget(
                  user: state.user,
                );
              } else if (state is LoginInitialState) {
                return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: LoginFormWidget());
              }else if(state is LoginSuccessfulState){
                return UserAccountScreen(user: state.user,);
              }else if(state is AuthInitialState){
                return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: LoginFormWidget());
              }else if(state is LoginErrorState){
                return LoginFormWidget(email: state.email,password: state.password,);
              }else if (state is LoginSuccessfulState){
                return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: RegisterFormWidget());
              }else{
                return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: RegisterFormWidget());
              }

            }),

        ),

    );
  }
}
