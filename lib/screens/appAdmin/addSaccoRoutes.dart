import 'package:bus/config/colors.dart';
import 'package:bus/models/saccoModel.dart';
import 'package:bus/services/saccoServices.dart';
import 'package:bus/widgets/appCustomWidgets/ElevatedButtonWidget.dart';
import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
import 'package:flutter/material.dart';
import '../../widgets/appCustomWidgets/inputFieldWidget.dart';
import '../../widgets/homepageWidgets/loadingPage.dart';


class AddSaccoRoutes extends StatefulWidget {
  SaccoModel saccoModel;

  AddSaccoRoutes({required this.saccoModel});

  @override
  State<AddSaccoRoutes> createState() => _AddSaccoRoutesState();
}

class _AddSaccoRoutesState extends State<AddSaccoRoutes> {
  SaccoServices saccoServices = SaccoServices();

  var routeDescriptionController = TextEditingController();
  var routeFare = TextEditingController();
  var startPointController = TextEditingController();
  var destinationController = TextEditingController();
  // var routeFare = TextEditingController();
  var isLoading = false;
  bool routeIsAdded = false;

  List<String> suggestons = [
    "USA",
    "UK",
    "Uganda",
    "Uruguay",
    "United Arab Emirates"
  ];
  List<SaccoModel> saccos = [];
  int selectedSacco = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MediumTextWidget(
            data: "New ${widget.saccoModel.name} Route",
            color: AppColors.appPrimaryColor),
      ),
      body: Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            padding: const EdgeInsets.all(10),
            child: ListView(
              padding: const EdgeInsets.only(top: 10),
              children: [
                Form(
                    key: _formKey,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ListView(
                        children: [
                          // InputDecorator(
                          //   decoration: const InputDecoration(
                          //
                          //     contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 4),
                          //     border: OutlineInputBorder(gapPadding: 0),
                          //     hintText: "Search..",
                          //     labelText: "Sacco Name"
                          //   ),
                          //   child: Autocomplete<SaccoModel>(
                          //
                          //     optionsBuilder: (TextEditingValue textEditingValue) {
                          //       if (textEditingValue.text == '') {
                          //         return const Iterable<SaccoModel>.empty();
                          //       }else{
                          //         List<SaccoModel> matches = <SaccoModel>[];
                          //         matches.addAll(saccos);
                          //
                          //         matches.retainWhere((s){
                          //           return s.name.toLowerCase().contains(textEditingValue.text.toLowerCase());
                          //         });
                          //         return matches;
                          //       }
                          //     },
                          //     onSelected: (SaccoModel selection) {
                          //       saccoName.text = selection.name;
                          //       selectedSacco = selection.id;
                          //       print('You just selected ${selection.name}');
                          //     },
                          //   ),
                          // ),

                          // const SizedBox(height: 20,),
                          const SizedBox(
                            height: 20,
                          ),
                          InputFieldWidget(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "please fill in the  field";
                              }
                              return null;
                            },
                            controller: startPointController,
                            labelText: "Enter a Start Point",
                            hint: "Nairobi",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InputFieldWidget(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "please fill in the  field";
                              }
                              return null;
                            },
                            controller: destinationController,
                            labelText: "Enter a Destination",
                            hint: "Thika",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InputFieldWidget(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "please fill in the  field";
                              }
                              return null;
                            },
                            controller: routeDescriptionController,
                            labelText: "Additional Information",
                            hint: "Any additional info about the route",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InputFieldWidget(
                            textInputType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "please fill in the  field";
                              }
                              return null;
                            },
                            controller: routeFare,
                            labelText: "Route fare",
                            hint: "14",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // InputFieldWidget(
                          //   controller: vehicleImage,
                          //   labelText: "Vehicle Image",
                          //   hint: "Vehicle Image",
                          // ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButtonWidget(
                              title: "Add Route",
                              callBack: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  var res = await saccoServices.addSaccoRoute(
                                    destination: destinationController.text,
                                      routeDescription:routeDescriptionController.text ,
                                      fare: routeFare.text,
                                      startingPoint: startPointController.text,
                                      saccoId: widget.saccoModel.id.toString());

                                  if (res == 200 || res == 201) {
                                    setState(() {
                                      isLoading = false;
                                      routeIsAdded = true;
                                    });
                                  } else {

                                  }
                                }
                              },
                              color: AppColors.appPrimaryColor),
                          const SizedBox(
                            height: 30,
                          ),
                          // ElevatedButtonWidget(title: "Add Route to Sacco0", callBack: (){
                          //   saccoServices.addRouteToSacco(
                          //       routeId: "19",
                          //       saccoId: widget.saccoModel.id.toString()
                          //   );
                          // }, color: AppColors.appPrimaryColor)
                        ],
                      ),
                    ))
              ],
            ),
          ),
          isLoading
              ? HomePageLoadingScreen(
                  title: "Loading",
                )
              : Container(),
          routeIsAdded
              ? Card(
                  elevation: 5,
                  child: Center(
                    child: SizedBox(
                      width: double.maxFinite,
                      height: 400,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 200,
                            width: double.maxFinite,
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                MediumTextWidget(data: "From: ${startPointController.text}", color: AppColors.appTextColor1),
                                MediumTextWidget(data: "To: ${destinationController.text}", color: AppColors.appTextColor1),
                                MediumTextWidget(data: "Fare: Ksh ${routeFare.text}", color: AppColors.appTextColor1),

                              ],
                            ),
                          ),
                          const Icon(
                            Icons.check,
                            size: 50,
                            color: Colors.green,
                          ),
                          MediumTextWidget(
                              data: "Route Added Successfully",
                              color: AppColors.appMainColor),

                          ElevatedButtonWidget(title: "Okay", callBack: (){
                            setState(() {
                              routeFare.text = "";
                              routeDescriptionController.text = "";
                              startPointController.text = "";
                              destinationController.text = "";
                              routeIsAdded =false;
                            });
                          }, color: AppColors.appPrimaryColor)
                        ],
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
