import 'package:bus/config/colors.dart';
import 'package:bus/screens/saccoManagement/saccoScreen.dart';
import 'package:bus/widgets/appCustomWidgets/ElevatedButtonWidget.dart';
import 'package:bus/widgets/appCustomWidgets/outlinedButtonWidget.dart';
import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/sacco/saccoCubits.dart';
import '../../cubits/sacco/saccoStates.dart';
import '../../models/saccoModel.dart';
import '../../services/saccoServices.dart';
import '../../widgets/appCustomWidgets/inputFieldWidget.dart';


class SaccoAdminLoginScreen extends StatefulWidget {
  @override
  State<SaccoAdminLoginScreen> createState() => _SaccoAdminLoginScreenState();
}

class _SaccoAdminLoginScreenState extends State<SaccoAdminLoginScreen> {
  var controller = TextEditingController();
  // List<SaccoModel> saccos = [];
  late SaccoModel selectedSacco;

  @override
  void initState() {
    // TODO: implement initState
     BlocProvider.of<SaccoCubits>(context).getAllSacco();
    // print(saccos.length);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: MediumTextWidget(data: "Sacco Admin Login",color: AppColors.appPrimaryColor),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: (){
              Navigator.pop(context);
            },
          )
      ),
      body: BlocBuilder<SaccoCubits,SaccoState>(
        builder: (context,state) {
          if(state is SaccoLoadingState){
            return Container(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }else if (state is SaccoLoadedState) {
            return SizedBox(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  // height: 300,
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      InputFieldWidget(
                        validator: (value) {},
                        controller: controller,
                        labelText: "email",
                        hint: "john.doe@gmail.com",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InputFieldWidget(
                        validator: (value) {},
                        controller: controller,
                        labelText: "Password",
                        hint: "*******",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InputDecorator(
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 4),
                            border: OutlineInputBorder(gapPadding: 0),
                            hintText: "Search..",
                            labelStyle: TextStyle(fontSize: 20),
                            labelText: "Sacco"),
                        child: Autocomplete<SaccoModel>(
                          optionsBuilder:
                              (TextEditingValue textEditingValue) {
                            if (textEditingValue.text == '') {
                              return const Iterable<SaccoModel>.empty();
                            } else {
                              List<SaccoModel> matches = <SaccoModel>[];
                              matches.addAll(state.saccoList);
                              matches.retainWhere((s) {
                                return s.name.toLowerCase().contains(
                                    textEditingValue.text.toLowerCase());
                              });
                              return matches;
                            }
                          },
                          onSelected: (SaccoModel selection) {
                            // saccoName.text = selection.name;
                            selectedSacco = selection;
                            // selectedSacco = selection.id;

                            // setState(() {
                            //   isSaccoSelected=true;
                            // });
                            // setSaccoRoutes();
                            // setState(() {
                            //   isSaccoSelected=false;
                            // });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      SizedBox(
                        width: double.maxFinite,
                        child: ElevatedButtonWidget(
                            title: "Login",
                            callBack: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return BlocProvider(
                                    create: (context) =>
                                        SaccoCubits(
                                            saccoServices: SaccoServices()),
                                    child: SaccoScreen(sacco: selectedSacco),
                                  );
                                },),);
                            },
                            color: AppColors.appPrimaryColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          width: double.maxFinite,
                          child: OutlinedButtonWidget(
                            buttonText: "Forgot Password",
                            onpressed: () {},
                          )
                      )
                    ],
                  ),
                ),
              ),
            );
          }else{
            return Container(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Center(
                child: MediumTextWidget(color: AppColors.appMainColor,data: state.toString(),),
              ),
            );
          }
        }
      ),
    );
  }
}
