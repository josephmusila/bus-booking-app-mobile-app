import 'package:bus/config/colors.dart';
import 'package:bus/models/saccoModel.dart';
import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/sacco/saccoCubits.dart';
import '../../models/tripModel.dart';
import '../../widgets/homepageWidgets/tripdetailWidget.dart';
import '../../widgets/saccoListWidgets/vehicleCardWidget.dart';

class UserViewSaccoData extends StatefulWidget {
  SaccoModel saccoData;
  List<TripModel> saccoTrips;

  UserViewSaccoData({required this.saccoData, required this.saccoTrips});

  @override
  State<UserViewSaccoData> createState() => _UserViewSaccoDataState();
}

class _UserViewSaccoDataState extends State<UserViewSaccoData>
    with TickerProviderStateMixin {
  List<TripModel> allTrips = [];
  Color containerColor = AppColors.appComplementaryColor1;
  Color containerTextColor = AppColors.appTextColor2;

  @override
  void initState() {
    // TODO: implement initState
    // allTrips = BlocProvider.of<SaccoCubits>(context).allTrips;
    allTrips = widget.saccoTrips;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 4, vsync: this);
    return Scaffold(
      appBar: AppBar(
        title: MediumTextWidget(
          data: widget.saccoData.name,
          color: AppColors.appTextColor3,
        ),
        elevation: 5,
      ),
      body: SafeArea(
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: double.maxFinite,
                // decoration: BoxDecoration(
                //     border: Border.all(color: AppColors.appMainColor)),
                // color: AppColors.appMainColor,
                child: Column(
                  children: [
                    MediumTextWidget(
                        data: widget.saccoData.description,
                        color: AppColors.appTextColor1),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.78,
                // color: AppColors.appPrimaryColor,
                margin: const EdgeInsets.only(top: 0),
                child: Align(
                  heightFactor: 0.5,
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      TabBar(
                        indicatorColor: AppColors.appPrimaryColor,
                        indicatorWeight: 5,
                        isScrollable: false,
                        controller: tabController,
                        labelColor: AppColors.appTextColor1,
                        unselectedLabelColor: AppColors.appTextColor3,
                        tabs: const [
                          Tab(
                            text: "Routes",
                          ),
                          Tab(
                            text: "Trips",
                          ),
                          Tab(
                            text: "Vehicles",
                          ),
                          Tab(
                            text: "About",
                          ),
                        ],
                      ),
                      Container(
                        // height: 550,
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            Container(
                              child: ListView(
                                children: List.generate(
                                  widget.saccoData.routes.length,
                                  (index) => Card(
                                    child: ListTile(
                                      leading: SmallTextWidget(
                                        data: "${index + 1}",
                                        color: AppColors.appTextColor3,
                                      ),
                                      title: SmallTextWidget(
                                        data: widget.saccoData.routes[index]
                                            .toString(),
                                        color: AppColors.appTextColor3,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Container(
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              allTrips = widget.saccoTrips;
                                            });
                                          },
                                          child: Container(
                                            height: 35,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            decoration: BoxDecoration(
                                                color: containerColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                              child: SmallTextWidget(
                                                data: "All Trips",
                                                color: containerTextColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              allTrips = widget.saccoTrips;
                                            });
                                          },
                                          child: Container(
                                            height: 35,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.3,
                                            decoration: BoxDecoration(
                                                color: containerColor,
                                                borderRadius:
                                                BorderRadius.circular(10)),
                                            child: Center(
                                              child: SmallTextWidget(
                                                data: "Active Trips",
                                                color: containerTextColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.63,
                                    // child: ListView(
                                    //   children: List.generate(
                                    //       widget.saccoTrips.length,
                                    //       (index) => Card(
                                    //             child: TripDetailWidget(
                                    //               user: widget.us,
                                    //                 tripData: widget
                                    //                     .saccoTrips[index]),
                                    //           )),
                                    // ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: ListView(
                                children: List.generate(
                                    10, (index) => VehicleCardWidget()),
                              ),
                            ),
                            Container(),
                          ],
                        ),
                      )
                    ],
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
