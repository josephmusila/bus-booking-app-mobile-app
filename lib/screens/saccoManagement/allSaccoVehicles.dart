import 'package:bus/config/colors.dart';
import 'package:bus/cubits/sacco/saccoCubits.dart';
import 'package:bus/cubits/sacco/saccoStates.dart';
import 'package:bus/screens/saccoManagement/vehicleScreen.dart';
import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/saccoModel.dart';

class AllSaccoVehicles extends StatefulWidget {

  SaccoModel sacco;
  AllSaccoVehicles({required this.sacco});
  @override
  State<AllSaccoVehicles> createState() => _AllSaccoVehiclesState();
}

class _AllSaccoVehiclesState extends State<AllSaccoVehicles> {

  @override
  void initState() {
    // TODO: implement initState
  BlocProvider.of<SaccoCubits>(context).getSaccoVehicles(widget.sacco.id.toString());
    super.initState();
  }
  // List<VehicleModel> vehicles;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      appBar: AppBar(
        title: MediumTextWidget(color: AppColors.appPrimaryColor,data: "Sacco Vehicles",),
      ),
      body: SafeArea(
        child: SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: BlocBuilder<SaccoCubits,SaccoState>(
            builder: (context,state){
              if(state is VehicleLoadingState){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }else if(state is SaccoVehicleLoadedState){
                return ListView(
                  padding: const EdgeInsets.all(10),
                  children: List.generate(
                    state.saccoVehicles.length,
                        (index) => Card(
                      child: SizedBox(
                        height: 70,
                        child: ListTile(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context){
                              return VehicleScreen(vehicleModel:  state.saccoVehicles[index]);
                            }));
                          },
                          leading: SizedBox(
                            height: 60,
                            child: Image.network(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_JCTzHccHrqYgasezcbS__wfraAuaAT8wBA&usqp=CAU",
                              fit: BoxFit.fill,

                            ),
                          ),
                          title: MediumTextWidget(data:   state.saccoVehicles[index].registration.toUpperCase(),color: AppColors.appTextColor1,),
                          // subtitle: SmallTextWidget(data:  vehicles[index].registration.toUpperCase(),color: AppColors.appMainColor,),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                      ),

                    ),
                  ),
                );
              }else{
                return MediumTextWidget(color: AppColors.appMainColor,data: "something else");
              }
            },
          )
        ),
      ),
    );
  }
}
