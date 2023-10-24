import 'package:bus/models/sdkConfirmModel.dart';
import 'package:equatable/equatable.dart';

import '../../models/tripModel.dart';

abstract class BookingState extends Equatable {}

class BookingInitialState extends BookingState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class BookingDataLoadingState extends BookingState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
// 0738749445
}

class BookingDataLoadedState extends BookingState {
  final TripModel trip;
  BookingDataLoadedState({required this.trip});
  @override
  // TODO: implement props
  List<Object?> get props => [trip];
}

class BookingSuccessState extends BookingState {
  final List<Seat> seats;
  BookingSuccessState({required this.seats});
  @override
  // TODO: implement props
  List<Object?> get props => [seats];
}

class BookingErrorState extends BookingState {
  final String message;

  BookingErrorState({
    required this.message,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class PaymentInitialState extends BookingState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class PaymentLoadingState extends BookingState{
  final String message;

  PaymentLoadingState({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];

}


class PaymentInitiatedState extends BookingState {
  final SdkConfirmModel sdkConfirmModel;

  PaymentInitiatedState({required this.sdkConfirmModel});

  @override
  List<Object?> get props => [sdkConfirmModel];
}

class PaymentSuccessfulStateState extends BookingState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class PaymentErrorState extends BookingState {
  final String errorMessage;

  PaymentErrorState({required this.errorMessage});
  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}
