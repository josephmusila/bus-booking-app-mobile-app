import 'package:bus/cubits/authentication/authCubits.dart';
import 'package:bus/screens/authScreens/authScreen.dart';
import 'package:bus/screens/mainLogicScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/authentication/authStattes.dart';

class AuthLogicScreen extends StatefulWidget {
  const AuthLogicScreen({super.key});

  @override
  State<AuthLogicScreen> createState() => _AuthLogicScreenState();
}

class _AuthLogicScreenState extends State<AuthLogicScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          child: BlocBuilder<AuthCubits,AuthState>(
            builder: (context,state){
              if(state is LoginSuccessfulState){
                return  MainLogicScreen(user: state.user);
              }else{
                return const AuthScreen();
              }
            },
          ),

      ),
    );
  }
}
