


import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/tripModel.dart';
import '../../services/bookingServices.dart';
import '../sacco/saccoStates.dart';
import 'bookingStates.dart';

class BookingCubits extends Cubit<BookingState>{
  BookingServices bookingServices;

  BookingCubits({required this.bookingServices}):super(BookingInitialState());

  void bookSeat({required String tripId,required List<Seat> listOfSeats}) async {
    emit(BookingDataLoadingState());
    var res = await bookingServices.bookSeat(seats: listOfSeats);
    if (res.isNotEmpty) {
      // print(state);
      emit(BookingSuccessState(seats: res));
      // reloadTripData(tripId: tripId);
    } else {
      emit(BookingErrorState(message: "Some error"));
    }
  }

  void initiateMpesaPayments({required String phoneNumber,required String amount}) async{
    emit(PaymentLoadingState(message: "Waiting for M-Pesa"));
    var response = await bookingServices.initiatePayments(phoneNumber, amount);
    if(response["code"] == 200){
      print(response["code"]);
      print(response["data"]);
      emit(PaymentInitiatedState(sdkConfirmModel: response["data"]));
    }else{
      print(response["code"]);
      print(response["data"]);
      emit(PaymentErrorState(errorMessage: response["data"]));
    }


  }

  // void reloadTripData({required String tripId}) async {
  //   emit(BookingDataLoadingState());
  //   TripModel tripModel = await saccoServices.getSelectedTrip(tripId: tripId);
  //   if (tripModel != null) {
  //     seatStreamController.sink.add([]);
  //     emit(BookingDataLoadedState(trip: tripModel));
  //   } else {
  //     emit(BookingErrorState(message: "Some error from reload Trip"));
  //   }
  // }


}