import 'package:bus/cubits/authentication/authCubits.dart';
import 'package:bus/models/userModel.dart';
import 'package:bus/screens/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/colors.dart';
import '../cubits/sacco/saccoCubits.dart';
import '../cubits/sacco/saccoStates.dart';
import '../widgets/appCustomWidgets/textWidget.dart';
import '../widgets/homepageWidgets/landingPage.dart';
import '../widgets/homepageWidgets/loadingPage.dart';
import 'bottomNavScreens/mainHomePage.dart';


class MainLogicScreen extends StatefulWidget {
  UserModel? user;

  MainLogicScreen({this.user});

  @override
  State<MainLogicScreen> createState() => _MainLogicScreenState();
}

class _MainLogicScreenState extends State<MainLogicScreen> {
  @override
  void initState() {
    BlocProvider.of<SaccoCubits>(context).loadMainPageData();
    BlocProvider.of<AuthCubits>(context).isAuthenticated();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      color: AppColors.appPrimaryColor,
      child: BlocBuilder<SaccoCubits,SaccoState>(
        builder: (context,state){
          if(state is SaccoLoadingState){
            return HomePageLoadingScreen(title: "Loading Data");
          }else if(state is SaccoLoadedState){
            return MainScreen(
              allRoutes: state.allSaccoRoutes,
              allSaccos: state.saccoList,
              allTrips: state.alltrips,
              userModel: widget.user,
            );

          }else if (state is SaccoLoadingErrorState){
            return Center(
              child: Container(
                height:300,
                width: double.maxFinite,
                child: MediumTextWidget(color: AppColors.appTextColor3,data: "Error occured",),
              ),
            );
          }else{
            return  Center(
              child: Container(
                height:300,
                width: double.maxFinite,
                child: MediumTextWidget(color: AppColors.appTextColor3,data: "Other Error occured",),
              ),
            );
          }
        },
      ),
    );
  }
}
