//
// import 'package:bus/config/colors.dart';
// import 'package:bus/screens/booking/bookingSuccessScreen.dart';
// import 'package:bus/screens/booking/BookingScreen.dart';
// import 'package:bus/cubits/sacco/saccoCubits.dart';
// import 'package:bus/cubits/sacco/saccoStates.dart';
// import 'package:bus/models/tripModel.dart';
// import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class BookingLogicScreen extends StatefulWidget {
//   TripModel trip;
//
//   BookingLogicScreen({required this.trip});
//
//
//   @override
//   State<BookingLogicScreen> createState() => _BookingLogicScreenState();
// }
//
// class _BookingLogicScreenState extends State<BookingLogicScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // TODO: implement initState
//     // BlocProvider.of<SaccoCubits>(context).getAllSacco();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SaccoCubits,SaccoState>(builder: (context,state){
//       if (state is BookingSuccessState){
//         return BookingSuccessScreen();
//       }
//       else if(state is BookingDataLoadedState){
//         return TripDetails(trip: state.trip);
//       }else if(state is BookingDataLoadingState){
//         return const SizedBox(
//           height: double.maxFinite,
//           width: double.maxFinite,
//           child: Center(
//             child: CircularProgressIndicator(),
//           ),
//         );
//       }else if(state is BookingErrorState){
//         return Container(
//           height: double.maxFinite,
//           width: double.maxFinite,
//           color: AppColors.appBgColor,
//           child:  Center(
//             child: MediumTextWidget(data: state.message, color: AppColors.appTextColor1),
//           ),
//         );
//       }else if (state is BookingSuccessState){
//         return BookingSuccessScreen();
//       }
//       if(state is SaccoInitialSate){
//         return TripDetails(trip: widget.trip);
//       }
//
//       else{
//         // return TripDetails(trip: widget.trip);
//         return Container(
//           height: double.maxFinite,
//           width: double.maxFinite,
//           child: Center(
//             child: MediumTextWidget(color: AppColors.appMainColor,data: state.toString(),),
//           ),
//         );
//       }
//     });
//   }
// }
