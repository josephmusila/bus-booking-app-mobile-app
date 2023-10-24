import 'package:bus/config/colors.dart';
import 'package:bus/cubits/authentication/authCubits.dart';

import 'package:bus/models/saccoModel.dart';
import 'package:bus/screens/bottomNavScreens/saccoListScreen.dart';
import 'package:bus/services/authservices.dart';

import 'package:bus/screens/bottomNavScreens/mainHomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/sacco/saccoCubits.dart';
import '../models/routeModel.dart';
import '../models/tripModel.dart';
import '../models/userModel.dart';
import '../services/saccoServices.dart';
import '../widgets/appCustomWidgets/textWidget.dart';
import '../widgets/homepageWidgets/customNavDrawer.dart';
import 'authScreens/authScreen.dart';
import 'bottomNavScreens/historyScreen.dart';

class MainScreen extends StatefulWidget {
  List<TripModel> allTrips;
  List<RouteModel> allRoutes;
  List<SaccoModel> allSaccos;
  UserModel? userModel;

  MainScreen(
      {required this.allTrips,
      required this.allRoutes,
      required this.allSaccos,
      this.userModel});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget setSelectedPage(int index) {
    var pages = [
      BlocProvider(
        create: (context) => SaccoCubits(saccoServices: SaccoServices()),
        child: MainHomePage(
            user: widget.userModel,
            trips: widget.allTrips,
            saccoData: widget.allSaccos,
            routes: widget.allRoutes),
      ),
      BlocProvider(
        create: (context) => SaccoCubits(
          saccoServices: SaccoServices(),
        ),
        child: SaccoListScreen(
          allSaccoRoutes: widget.allRoutes,
          alltrips: widget.allTrips,
          saccoList: widget.allSaccos,
        ),
      ),
      BlocProvider(
        create: (context) => AuthCubits(
          authServices: AuthServices(),
        ),
        child: const AuthScreen(),
      ),
      // const UserAccountScreen(),

      const HistoryScreen(),
    ];

    return pages[index];
  }

  int currentPage = 0;

  void onSelect(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomNavDrawer(),
      backgroundColor: AppColors.appBgColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.appPrimaryColor,
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: AppColors.appBgColor,
              ),
            );
          },
        ),
        title: MediumTextWidget(
          data: "GoSwift",
          color: AppColors.appTextColor2,
        ),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<SaccoCubits>(context).loadMainPageData();
            },
            icon: const Icon(Icons.refresh),
            color: AppColors.whiteColor1,
          )
        ],
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<SaccoCubits>(context).loadMainPageData();
          },
          child: setSelectedPage(currentPage)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.whiteColor1,
        selectedItemColor: AppColors.appPrimaryColor,
        unselectedItemColor: AppColors.appTextColor1,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        currentIndex: currentPage,
        onTap: onSelect,
        elevation: 5,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.travel_explore), label: "Sacco"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), label: "Account"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
        ],
      ),
    );
  }
}
