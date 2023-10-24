import 'package:bus/config/colors.dart';
import 'package:bus/cubits/sacco/saccoCubits.dart';
import 'package:bus/models/saccoModel.dart';
import 'package:bus/services/saccoServices.dart';
import 'package:bus/widgets/appCustomWidgets/ElevatedButtonWidget.dart';
import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/appCustomWidgets/inputFieldWidget.dart';

class AddVehicleScreen extends StatefulWidget {
  SaccoModel saccoModel;
  // List<Routes> routes;

  AddVehicleScreen({required this.saccoModel});

  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  SaccoServices saccoServices = SaccoServices();

  var saccoName = TextEditingController();
  var vehicleRegistration = TextEditingController();
  var vehicleImage = TextEditingController();
  var vehicleCapacity = TextEditingController();

  List<SaccoModel> saccos = [];
  List<Routes> routes = [];
  List<String> vehicleCapacities=["14","33"];
  var selectedCapacity="14";
  int selectedSacco = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MediumTextWidget(
            data: "Add Vehicle", color: AppColors.appPrimaryColor),
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.all(10),
        child: ListView(
          padding: const EdgeInsets.only(top: 10),
          children: [
            Form(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView(
                  children: [

                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InputFieldWidget(
                      validator: (value) {},
                      controller: vehicleRegistration,
                      labelText: "Vehicle Registration",
                      hint: "KBB 221T",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InputDecorator(
                      decoration: const InputDecoration(

                        contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 4),
                        border: OutlineInputBorder(gapPadding: 0),
                        hintText: "Search..",
                        labelText: "Vehicle Capacity",
                        labelStyle: TextStyle(
                          fontSize: 20
                        )
                      ),
                      child: Autocomplete<String>(

                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text == '') {
                            return vehicleCapacities;
                          }else{
                            List<String> matches = <String>[];
                            matches.addAll(vehicleCapacities);

                            matches.retainWhere((s){
                              return s.toLowerCase().contains(textEditingValue.text.toLowerCase());
                            });
                            return matches;
                          }
                        },
                        onSelected: (String selection) {
                          selectedCapacity=selection;
                          // saccoName.text = selection.routes;
                          // selectedSacco = selection.id;
                          // print('You just selected ${selection.routes}');
                        },
                      ),
                    ),


                    const SizedBox(
                      height: 20,
                    ),
                    InputFieldWidget(
                      validator: (value) {},
                      controller: vehicleImage,
                      labelText: "Vehicle Image",
                      hint: "Vehicle Image",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButtonWidget(
                      title: "Add",
                      callBack: () {
                        // var status = saccoServices.addVehicle(
                        //   capacity: vehicleCapacity.text,
                        //   image: vehicleImage.text,
                        //   registration: vehicleRegistration.text,
                        //   sacco: widget.saccoModel.id.toString(),
                        // );

                        BlocProvider.of<SaccoCubits>(context).addVehicle(
                          sacco: widget.saccoModel.id.toString(),
                          registration: vehicleRegistration.text.toUpperCase(),
                          image: vehicleImage.text,
                          capacity: selectedCapacity,
                        );

                        // BlocProvider.of<SaccoCubits>(context)
                        //     .getAllSaccoRoutes();


                        // print(status);
                        // if(){
                        //   Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        //     return;
                        //   }));
                        // }
                      },
                      color: AppColors.appPrimaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
