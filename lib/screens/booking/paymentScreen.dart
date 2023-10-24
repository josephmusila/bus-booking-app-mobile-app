import 'package:bus/config/colors.dart';
import 'package:bus/cubits/authentication/authCubits.dart';
import 'package:bus/cubits/authentication/authStattes.dart';
import 'package:bus/cubits/booking/bookingCubits.dart';
import 'package:bus/models/tripModel.dart';
import 'package:bus/models/userModel.dart';
import 'package:bus/screens/authScreens/authScreen.dart';
import 'package:bus/widgets/appCustomWidgets/ElevatedButtonWidget.dart';
import 'package:bus/widgets/appCustomWidgets/outlinedButtonWidget.dart';
import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
import 'package:bus/widgets/homepageWidgets/loadingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/booking/bookingStates.dart';
import '../../widgets/appCustomWidgets/inputFieldWidget.dart';
import '../../widgets/bookingWidgets/bookingDataScreen.dart';

class BookingPaymentScreen extends StatefulWidget {
  TripModel tripData;
  List<Seat> seats;
  UserModel user;

  BookingPaymentScreen({
    required this.tripData,
    required this.seats,
    required this.user
  });

  @override
  State<BookingPaymentScreen> createState() => _BookingPaymentScreenState();
}

class _BookingPaymentScreenState extends State<BookingPaymentScreen> {
  var phoneNumberController = TextEditingController();
  UserModel? user;

  @override
  void initState() {
    // TODO: implement initState
    phoneNumberController.text = widget.user.phone;
    BlocProvider.of<AuthCubits>(context).isAuthenticated();
    checkForUser();
    super.initState();
  }

  void checkForUser(){
    if(widget.user == null){
      print("Un Authenticated");
    }else{
      print("Auhtnticated");
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<BookingCubits>(context);
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      appBar: AppBar(
        title:
            MediumTextWidget(data: "Payments", color: AppColors.appMainColor),
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        color: AppColors.appBgColor,
        child: ListView(
          children: [
            // BlocBuilder<AuthCubits, AuthState>(builder: (context, state) {
            //   if (state is LoginSuccessfulState) {

                BlocBuilder<BookingCubits, BookingState>(
                    builder: (context, state) {
                  if (state is BookingInitialState) {
                    return BookingDataScreen(
                      tripModel: widget.tripData,
                      seats: widget.seats,
                      user: widget.user,
                    );
                  } else if (state is BookingDataLoadingState) {
                    return HomePageLoadingScreen(title: "Booking");
                  } else if (state is BookingDataLoadedState) {
                    return Container();
                  } else if(state is PaymentLoadingState){
                    return Center(
                      child: Card(
                        child: Container(
                          height: double.maxFinite,
                          width: double.maxFinite,
                          child: Column(
                            children: [
                              MediumTextWidget(data: state.message, color: AppColors.appMainColor),
                              const CircularProgressIndicator(),
                            ],
                          ),
                        ),
                      ),
                    );
                  }else if(state is PaymentInitiatedState){
                    return Container(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      child: Card(
                        color: AppColors.whiteColor1,
                        child: Column(
                          children: [
                            MediumTextWidget(data: "Enter your Mpesa Pin", color: AppColors.appPrimaryColor),
                            const CircularProgressIndicator(),
                          ],
                        ),
                      ),
                    );
                  }

                  else {
                    return BookingDataScreen(
                      tripModel: widget.tripData,
                      seats: widget.seats,
                      user: widget.user,
                    );
                  }
                }),
              // } else {
              //   return const AuthScreen();
                // return ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(
                //     content: Text(message),
                //     padding: const EdgeInsets.all(8),
                //     margin: const EdgeInsets.only(bottom: 100, left: 30, right: 30),
                //     backgroundColor: Colors.red,
                //     dismissDirection: DismissDirection.horizontal,
                //     behavior: SnackBarBehavior.floating,
                //   ),
                // );
              // }
            // }),
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              height: 150,
              decoration: BoxDecoration(
                  color: AppColors.whiteColor1,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.black26, width: 2)),
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 60,
                    width: double.maxFinite,
                    // color: AppColors.appMainColor,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: SmallTextWidget(
                              data:
                                  "Mpesa Number: ${phoneNumberController.text}",
                              color: AppColors.appTextColor3,
                            )),
                        Expanded(
                          flex: 2,
                          child: OutlinedButtonWidget(
                            buttonText: "Change",
                            onpressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: AppColors.whiteColor,
                                  title: MediumTextWidget(
                                    data: "Change Phone Number",
                                    color: AppColors.appTextColor3,
                                  ),
                                  content: InputFieldWidget(
                                    controller: phoneNumberController,
                                    validator: (value) {},
                                    labelText: "Enter New Mpesa Number",
                                    hint: "Mpesa Number",
                                    textInputType: TextInputType.phone,
                                  ),
                                  actions: [
                                    SizedBox(
                                      width: double.maxFinite,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 40,
                                            child: ElevatedButtonWidget(
                                              color: AppColors.appMainColor,
                                              title: "Change",
                                              callBack: () {
                                                setState(() {});
                                                Navigator.of(context).pop(true);
                                              },
                                            ),
                                          ),
                                          OutlinedButtonWidget(
                                            onpressed: () {
                                              setState(() {});
                                              Navigator.of(context).pop(true);
                                            },
                                            buttonText: "Cancel",
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Container(
                    height: 40,
                    width: double.maxFinite,
                    child: ElevatedButtonWidget(
                      color: AppColors.appMainColor,
                      callBack: () {
                        double amount=widget.seats.length * double.parse(widget.tripData.routes.fare);
                        bloc.initiateMpesaPayments(phoneNumber: widget.user.phone, amount: amount.toString());
                      },
                      title: "Pay",
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
