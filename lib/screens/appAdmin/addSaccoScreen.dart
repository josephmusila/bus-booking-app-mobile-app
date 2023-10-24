import 'package:bus/config/colors.dart';
import 'package:bus/services/saccoServices.dart';
import 'package:bus/widgets/appCustomWidgets/ElevatedButtonWidget.dart';
import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
import 'package:flutter/material.dart';


import '../../widgets/appCustomWidgets/inputFieldWidget.dart';

class AddSaccoScreen extends StatefulWidget {
  const AddSaccoScreen({super.key});

  @override
  State<AddSaccoScreen> createState() => _AddSaccoScreenState();
}

class _AddSaccoScreenState extends State<AddSaccoScreen> {
  SaccoServices saccoServices = SaccoServices();

  var saccoName = TextEditingController();
  var saccoDescription = TextEditingController();
  var saccoImage = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    // BlocProvider.of<SaccoCubits>(context).getAllSacco();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MediumTextWidget(
            data: "Add Sacco", color: AppColors.appPrimaryColor),
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Form(
                child: Container(
              padding: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView(
                children: [
                  InputFieldWidget(
                    validator: (value) {},
                    controller: saccoName,
                    labelText: "Sacco Name",
                    hint: "ABC Sacco",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputFieldWidget(
                    validator: (value) {},
                    controller: saccoDescription,
                    labelText: "Sacco Description",
                    hint: "Some Sacco Description",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputFieldWidget(
                    validator: (value) {},
                    controller: saccoImage,
                    labelText: "Sacco Image",
                    hint: "Some Sacco Image",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  isLoading? SizedBox(
                    height: 100,
                    width: double.maxFinite,
                    child:  Column(
                      children: [
                        const CircularProgressIndicator(),
                        MediumTextWidget(data: "Adding", color: AppColors.appTextColor2)
                      ],
                    ),
                  ):ElevatedButtonWidget(
                    title: "Add",
                    callBack: () async {
                      setState(() {
                        isLoading=true;
                      });
                      var response = await saccoServices.addSacco(
                          saccoName: saccoName.text,
                          saccoDescription: saccoDescription.text,
                          saccoImage: saccoImage.text);

                      if(response == 200 || response == 201){
                        setState(() {
                          isLoading=false;
                        });
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content:
                            Text("Sacco Added Successfully"),
                            backgroundColor: Colors.green,
                            dismissDirection:
                            DismissDirection.horizontal,
                            behavior:
                            SnackBarBehavior.floating,
                          ),
                        );
                          Navigator.pop(context);
                        // List<SaccoModel> saccoList =
                        //     BlocProvider.of<SaccoCubits>(context).saccoList;
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        //   return AddVehicleScreen(saccoModel: saccoList);
                        // }));

                      }else{
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content:
                            Text("An Error occured"),
                            backgroundColor: Colors.red,
                            dismissDirection:
                            DismissDirection.horizontal,
                            behavior:
                            SnackBarBehavior.floating,
                          ),
                        );
                      }





                    },
                    color: AppColors.appPrimaryColor,
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
