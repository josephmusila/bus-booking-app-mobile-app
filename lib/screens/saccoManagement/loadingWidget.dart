// import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
// import 'package:flutter/material.dart';
//
// import '../config/colors.dart';
//
// class LoadingScreen extends StatelessWidget {
//   String message;
//
//   LoadingScreen({required this.message});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           height: double.maxFinite,
//           width: double.maxFinite,
//           color: AppColors.appBgColor.withOpacity(0.1),
//           child: Center(
//             child: Card(
//               child: Container(
//                 height: 200,
//                 width: 200,
//                 decoration: const BoxDecoration(
//                   color: AppColors.appMainColor,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     // Text(message),
//                     MediumTextWidget(data: message, color: AppColors.appTextColor2),
//                     const CircularProgressIndicator(color: AppColors.appPrimaryColor,strokeWidth: 3),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
