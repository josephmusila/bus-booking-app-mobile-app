import 'package:bus/config/colors.dart';
import 'package:bus/screens/appAdmin/addSaccoScreen.dart';
import 'package:bus/widgets/appCustomWidgets/ElevatedButtonWidget.dart';
import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/sacco/saccoCubits.dart';
import '../../services/saccoServices.dart';

class AdminLandingPage extends StatefulWidget {
  const AdminLandingPage({super.key});

  @override
  State<AdminLandingPage> createState() => _AdminLandingPageState();
}

class _AdminLandingPageState extends State<AdminLandingPage> {

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<SaccoCubits>(context).getAllSacco();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MediumTextWidget(data: "Admin",color: AppColors.appMainColor),
      ),
      body: SafeArea(
        child: SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: ListView(
            children: [
              ElevatedButtonWidget(
                title: "Add Sacco",
                callBack: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return BlocProvider(
                      create: (context) =>
                          SaccoCubits(saccoServices: SaccoServices()),
                      child: const AddSaccoScreen(),
                    );
                  }));
                },
                color: AppColors.appMainColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
