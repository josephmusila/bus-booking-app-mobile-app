import 'package:bus/widgets/appCustomWidgets/inputFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/colors.dart';
import '../../cubits/sacco/saccoCubits.dart';
import '../../models/routeModel.dart';
import '../../models/saccoModel.dart';
import '../../models/tripModel.dart';
import '../saccoManagement/saccoScreen.dart';
import '../../services/saccoServices.dart';
import '../../widgets/appCustomWidgets/textWidget.dart';
import '../saccoManagement/userViewSaccoData.dart';

class SaccoListScreen extends StatefulWidget {
  List<SaccoModel> saccoList;
  List<RouteModel> allSaccoRoutes;
  List<TripModel> alltrips;

  SaccoListScreen(
      {required this.saccoList,
      required this.allSaccoRoutes,
      required this.alltrips});

  @override
  State<SaccoListScreen> createState() => _SaccoListScreenState();
}

class _SaccoListScreenState extends State<SaccoListScreen> {
  TextEditingController searchController = TextEditingController();
  List<SaccoModel> searchedList = [];
  List<RouteModel> saccoRoutes = [];
  List<TripModel> saccoTrips = [];

  @override
  void initState() {
    // TODO: implement initState
    searchedList = widget.saccoList;
    super.initState();
  }

  void setTripsForSelectedSacco(int id) {
    // print(id);
    widget.alltrips.forEach((element) {
      if (element.sacco.id == id) {
        saccoTrips.add(element);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.maxFinite,
      width: double.maxFinite,
      child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            height: 50,
            width: double.maxFinite,
            child: InputFieldWidget(
              controller: searchController,
              hint: "Type Sacco Name",
              labelText: "Search For Sacco Here",
              validator: (value) {},
              textInputType: TextInputType.name,
              onChanged: (value) {
                searchSacco(value);
              },
            ),
          ),
          const Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(
              searchedList.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                height: 70,
                decoration: BoxDecoration(
                    color: AppColors.whiteColor1,
                    border: Border.all(color: AppColors.appBgColor, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  onTap: () {
                    setTripsForSelectedSacco(searchedList[index].id);
                    // print(searchedList[index].id);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return BlocProvider(
                            create: (context) =>
                                SaccoCubits(saccoServices: SaccoServices()),
                            child: UserViewSaccoData(
                                saccoTrips: saccoTrips,
                                saccoData: searchedList[index]),
                            // child: SaccoScreen(
                            //   sacco: searchedList[index],
                            // ),
                          );
                        },
                      ),
                    );
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    //   return SaccoScreen(saccoName: state.saccoList[index].name,);
                    // }));
                  },
                  leading: SmallTextWidget(
                    data: "${index + 1}.",
                    color: AppColors.appTextColor1,
                  ),
                  title: MediumTextWidget(
                      data: searchedList[index].name,
                      color: AppColors.appTextColor1),
                  subtitle: SmallTextWidget(
                      data:
                          "${searchedList[index].routes.length} ${searchedList[index].routes.length > 2 || searchedList[index].routes.isEmpty ? "Routes" : "Route"}",
                      color: AppColors.appTextColor1),
                  trailing: const Icon(
                    Icons.arrow_forward,
                    color: AppColors.appTextColor1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void searchSacco(String query) {
    final input = query.toLowerCase();
    setState(() {
      searchedList = widget.saccoList.where((element) {
        return (element.name.toString().toLowerCase()).contains(input) ||
            (element.description.toString().toLowerCase()).contains(input) ||
            (element.routes.toString()).contains(input);
      }).toList();
    });
  }
}
