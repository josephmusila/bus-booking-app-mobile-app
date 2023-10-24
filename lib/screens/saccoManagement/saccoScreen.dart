import 'package:bus/config/colors.dart';
import 'package:bus/cubits/sacco/saccoCubits.dart';
import 'package:bus/screens/saccoManagement/vehicleLogicScreen.dart';
import 'package:bus/screens/saccoManagement/addTrip.dart';
import 'package:bus/screens/saccoManagement/allSaccoRoutes.dart';
import 'package:bus/screens/saccoManagement/allSaccoVehicles.dart';
import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/saccoModel.dart';
import '../../models/vehiclesModel.dart';
import '../../services/saccoServices.dart';
import 'saccoVehiclesCard.dart';
import '../appAdmin/addSaccoRoutes.dart';


class SaccoScreen extends StatefulWidget {
  SaccoModel sacco;

  SaccoScreen({required this.sacco});

  @override
  State<SaccoScreen> createState() => _SaccoScreenState();
}

class _SaccoScreenState extends State<SaccoScreen> {
  List<VehicleModel> saccoVehicles = [];
  // List<Routes> saccoRoutes = [];

  @override
  void initState() {
     BlocProvider.of<SaccoCubits>(context)
        .getSaccoVehicles(widget.sacco.id.toString());
     // saccoRoutes=BlocProvider.of<SaccoCubits>(context).getSingleSaccoRoutes(widget.sacco.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      appBar: AppBar(
        title: MediumTextWidget(
            data: widget.sacco.name, color: AppColors.appPrimaryColor),

      ),
      body: SafeArea(
        child: SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: ListView(
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(20)),
                margin: const EdgeInsets.only(
                    top: 0, left: 0, right: 0, bottom: 10),
                child: Stack(
                  children: [
                    const SizedBox(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      // child: Image.network(
                      //   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_JCTzHccHrqYgasezcbS__wfraAuaAT8wBA&usqp=CAU",
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Colors.black38,
                        height: 70,
                        child: Center(
                          child: SmallTextWidget(
                            color: AppColors.appTextColor2,
                            data: widget.sacco.description,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // const Divider(color: AppColors.appMainColor,),

              Card(
                elevation: 2,
                color: AppColors.whiteColor1,
                child: SizedBox(
                  height: 200,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 5,
                        left: 10,
                        child: MediumTextWidget(
                            data: "Sacco Trips",
                            color: AppColors.appTextColor1),
                      ),
                      Positioned(
                        top: 40,
                        left: 10,
                        right: 10,
                        bottom: 5,
                        child: Row(children: [
                          SaccoVehiclesCard(
                            title: "New Trip",
                            icon: Icons.add,
                            buttonText: "Set Up",
                            onpressed: () {
                              List<VehicleModel> vehicles =
                                  BlocProvider.of<SaccoCubits>(context)
                                      .saccoVehicles;
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                // return AddtripScreen(vehicles:vehicles ,sacco: widget.sacco,);
                                return BlocProvider(
                                  create: (context) => SaccoCubits(
                                      saccoServices: SaccoServices()),
                                  // child: AddVehicleScreen(saccoModel: widget.sacco,),

                                  child:AddtripScreen(vehicles:vehicles ,sacco: widget.sacco,),
                                );
                              }));
                            },
                          ),
                          SaccoVehiclesCard(
                            title: "All Trip",
                            icon: Icons.list_alt,
                            buttonText: "All trips",
                            onpressed: () {},
                          ),
                          // SaccoVehiclesCard(title: "Sacco",icon: Icons.add,buttonText: "Add",onpressed: (){},),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                elevation: 5,
                color: AppColors.whiteColor1,
                child: SizedBox(
                  height: 200,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 5,
                        left: 10,
                        child: MediumTextWidget(
                            data: "Sacco Routes",
                            color: AppColors.appTextColor1),
                      ),
                      Positioned(
                        top: 40,
                        left: 10,
                        right: 10,
                        bottom: 5,
                        child: Row(children: [
                          SaccoVehiclesCard(
                            title: "All Routes",
                            icon: Icons.list,
                            buttonText: "See All",
                            onpressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return SaccoRoutesScreen(
                                  saccoRoutes: widget.sacco.routes,
                                );
                              }));
                            },
                          ),
                          SaccoVehiclesCard(
                            title: "Add Route",
                            icon: Icons.library_add_outlined,
                            buttonText: "Add a Route",
                            onpressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return AddSaccoRoutes(
                                  saccoModel: widget.sacco,
                                );
                              }));
                            },
                          ),
                          // SaccoVehiclesCard(title: "Sacco",icon: Icons.add,buttonText: "Add",onpressed: (){},),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                  elevation: 5,
                  color: AppColors.whiteColor1,
                  child: SizedBox(
                    height: 200,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 5,
                          left: 10,
                          child: MediumTextWidget(
                            data: "Sacco Vehicles",
                            color: AppColors.appTextColor1,
                          ),
                        ),
                        Positioned(
                          top: 40,
                          left: 10,
                          right: 10,
                          bottom: 5,
                          child: Row(children: [
                            SaccoVehiclesCard(
                              title: "All Vehicles",
                              icon: Icons.list,
                              buttonText: "See All",
                              onpressed: () {

                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return BlocProvider(
                                        create: (context) => SaccoCubits(
                                            saccoServices: SaccoServices()),
                                        // child: AddVehicleScreen(saccoModel: widget.sacco,),

                                        child:AllSaccoVehicles(sacco: widget.sacco),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                            SaccoVehiclesCard(
                              title: "Add Vehicle",
                              icon: Icons.library_add_outlined,
                              buttonText: "Add Vehicle",
                              onpressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return BlocProvider(
                                        create: (context) => SaccoCubits(
                                            saccoServices: SaccoServices()),
                                        // child: AddVehicleScreen(saccoModel: widget.sacco,),

                                        child:VehicleLogicScreen(
                                          routes: widget.sacco.routes,
                                            saccoModel: widget.sacco),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                            // SaccoVehiclesCard(title: "Sacco",icon: Icons.add,buttonText: "Add",onpressed: (){},),
                          ]),
                        ),
                      ],
                    ),
                  )),

              Card(
                child: ListTile(
                  title: SmallTextWidget(
                      data: "See all Reviews", color: AppColors.appTextColor1),
                  trailing: const Icon(
                    Icons.arrow_downward_outlined,
                    color: AppColors.appAccentColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
