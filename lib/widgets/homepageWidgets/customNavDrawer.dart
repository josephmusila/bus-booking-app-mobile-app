import 'package:bus/config/colors.dart';
import 'package:bus/screens/authScreens/saccoAdminLogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/sacco/saccoCubits.dart';
import '../../screens/authScreens/systemAdminLoginScreen.dart';
import '../../services/saccoServices.dart';
import 'navBarWidgets.dart';

class CustomNavDrawer extends StatelessWidget {
  const CustomNavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: SafeArea(
          child: ListView(
            children: [
              Container(
                width: double.maxFinite,
                color: AppColors.whiteColor,
                height: 100,

              ),
              NavItem(
                onPressed: (){},
                icon: Icons.home,
                title: "home",
              ),

              const SizedBox(
                height: 5,
              ),
              NavItem(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return BlocProvider(
                      create: (context) =>
                          SaccoCubits(saccoServices: SaccoServices()),
                      child:  SaccoAdminLoginScreen(),
                    );
                  },),);
                },
                icon: Icons.admin_panel_settings_outlined,
                title: "Sacco Admin",
              ),

              const SizedBox(
                height: 5,
              ),
              NavItem(
                onPressed: (){
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return SystemAdminLoginScreen();
                  }));
                },
                icon: Icons.admin_panel_settings,
                title: "System Admin",
              ),
              const SizedBox(
                height: 5,
              ),
              NavItem(
                onPressed: (){},
                icon: Icons.settings,
                title: "Settings",
              ),

              const SizedBox(
                height: 5,
              ),
              NavItem(
                onPressed: (){},
                icon: Icons.apps_outlined,
                title: "About",
              ),

              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
