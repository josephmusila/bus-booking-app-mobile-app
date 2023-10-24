import 'package:bus/config/colors.dart';
import 'package:bus/cubits/authentication/authCubits.dart';
import 'package:bus/screens/authLogicScreeen.dart';
import 'package:bus/screens/mainLogicScreen.dart';
import 'package:bus/screens/mainScreen.dart';
import 'package:bus/services/authservices.dart';
import 'package:bus/services/saccoServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/sacco/saccoCubits.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: AppColors.appPrimaryColor));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
        BlocProvider(
          create: (context) => SaccoCubits(
            saccoServices: SaccoServices(),
          ),
        ),
          BlocProvider(
            create: (context) => AuthCubits(
              authServices: AuthServices(),
            ),
          ),
        ],
        child:  const AuthLogicScreen(),
        // child:   MainLogicScreen(),
      ),
    );
  }
}
