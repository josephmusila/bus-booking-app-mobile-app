// import 'package:bus/config/colors.dart';
// import 'package:bus/models/saccoModel.dart';
// import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
// import 'package:flutter/material.dart';
//
// import 'booking/BookingScreen.dart';
// import '../models/routeModel.dart';
// import '../models/tripModel.dart';
//
//
// class SelectedRouteScreen extends StatelessWidget {
//   List<TripModel> selectedRouteTrips;
//   RouteModel selectedRoute;
//
//   SelectedRouteScreen({
//     required this.selectedRouteTrips,
//     required this.selectedRoute
// });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: MediumTextWidget(data: selectedRoute.destination,color: AppColors.appPrimaryColor,)
//       ),
//       body: Container(
//         height: double.maxFinite,
//         width:double.maxFinite,
//
//         child: ListView(
//           children: List.generate(selectedRouteTrips.length, (index) => Card(
//             child: ListTile(
//               leading: SmallTextWidget(color: AppColors.appTextColor1,data: "${index+1}"),
//               title: SmallTextWidget(color: AppColors.appTextColor1,data: selectedRouteTrips[index].sacco.name,),
//               subtitle: SmallTextWidget(color: AppColors.appTextColor1,data: selectedRouteTrips[index].vehicle.registration,),
//               trailing: SmallTextWidget(color: AppColors.appTextColor1,data: selectedRouteTrips[index].pickuppoint,),
//               onTap: (){
//                 Navigator.of(context).push(MaterialPageRoute(builder: (context){
//                   return TripDetails(trip: selectedRouteTrips[index],);
//                 }));
//               },
//             ),
//           )),
//         ),
//       ),
//     );
//   }
// }
