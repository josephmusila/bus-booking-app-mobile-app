import 'package:bus/config/colors.dart';
import 'package:bus/models/vehiclesModel.dart';
import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
import 'package:flutter/material.dart';

class VehicleScreen extends StatefulWidget {
  VehicleModel vehicleModel;

  VehicleScreen({required this.vehicleModel});

  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  @override
  void initState() {
    // print(widget.vehicleModel.routes.length);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      appBar: AppBar(
        title: MediumTextWidget(
          data: widget.vehicleModel.registration,
          color: AppColors.appPrimaryColor,
        ),
      ),
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: ListView(
          children: [
            Container(
              height: 300,
              width: double.maxFinite,
              color: AppColors.appMainColor,
            ),
            SizedBox(
              height: 50,
              child: Center(
                child: MediumTextWidget(data: "Routes",color: AppColors.appTextColor1),
              ),
            ),

            // widget.vehicleModel.routes.isEmpty?Card(
            //   color: AppColors.whiteColor1,
            //   elevation: 5,
            //   child: ListTile(
            //     title: SmallTextWidget(data: "No routes for this vehicle",color: AppColors.appTextColor1),
            //     trailing: OutlinedButtonWidget(
            //       buttonText: "Add",
            //       onpressed: (){},
            //     ),
            //   ),
            // ):
            // Wrap(
            //   direction: Axis.vertical,
            //   children: List.generate(
            //     widget.vehicleModel.routes.length,
            //     (index) {
            //
            //       if(widget.vehicleModel.routes.isEmpty){
            //         return Card(
            //           color: AppColors.appMainColor,
            //           elevation: 5,
            //           child: ListTile(
            //             title: MediumTextWidget(data: "No routes for this vehicle",color: AppColors.appTextColor1),
            //           ),
            //         );
            //       }else{
            //         return Container(
            //           height: 50,
            //           margin: const EdgeInsets.all(5),
            //           width: double.maxFinite,
            //           color: AppColors.appPrimaryColor,
            //           child: ListTile(
            //             leading: SmallTextWidget(
            //               data: "${index + 1}", color: AppColors.appTextColor1,),
            //             title: SmallTextWidget(
            //               data: widget.vehicleModel.routes[index].routes,
            //               color: AppColors.appTextColor1,),
            //             trailing: SmallTextWidget(
            //                 data: widget.vehicleModel.routes[index].fare,
            //                 color: AppColors.appTextColor1),
            //           ),
            //         );
            //       }
            //
            //
            //     }
            //
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
