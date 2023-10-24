import 'package:bus/cubits/sacco/saccoStates.dart';
import 'package:bus/models/userModel.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable{}

class AuthInitialState extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthLoadingState extends AuthState {
  String message;

  AuthLoadingState({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
class RegisterInitialState extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class RegisterSuccessfulState extends AuthState {
  UserModel user;

  RegisterSuccessfulState({required this.user});
  @override
  // TODO: implement props
  List<Object?> get props => [user];
}

class AuthErrorState extends AuthState {
  String message;


  AuthErrorState({required this.message,});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

//login States
class LoginInitialState extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoginSuccessfulState extends AuthState {
  UserModel user;

  LoginSuccessfulState({required this.user});
  @override
  // TODO: implement props
  List<Object?> get props => [user];
}

class LoginErrorState extends AuthState{

  String email;
  String password;

  LoginErrorState({required this.email,required this.password});
  @override
  // TODO: implement props
  List<Object?> get props => [email,password];

}
