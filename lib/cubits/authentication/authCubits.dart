import 'package:bus/cubits/authentication/authStattes.dart';
import 'package:bus/models/loginErrorModel.dart';
import 'package:bus/models/userModel.dart';
import 'package:bus/services/authservices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCubits extends Cubit<AuthState> {
  AuthServices authServices;
  AuthCubits({required this.authServices}) : super(AuthInitialState());
  // final _storage = const FlutterSecureStorage();
  // final SharedPreferences prefs = await SharedPreferences.getInstance();
  String snackBarMessage = "";
  var emailController = BehaviorSubject<String>();
  Stream<String> get emailStream => emailController.stream;
  var passwordController = BehaviorSubject<String>();
  Stream<String> get passwordStream => passwordController.stream;
  Stream<bool> get buttonValid =>
      Rx.combineLatest2(emailStream, passwordStream, (a, b) => true);
  var loginErrorController = BehaviorSubject<String>();
  Stream<String> get loginErrorStream => loginErrorController.stream;

  UserModel? user;



  void validateEmail(String email) {
    if (email.isEmpty) {
      emailController.sink.addError("");
      // return "please fill in the  field";
    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(email)) {
      emailController.sink.addError("Please enter a valid email");
    } else {
      emailController.sink.add(email);
    }
  }

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 100, left: 30, right: 30),
        backgroundColor: Colors.red,
        dismissDirection: DismissDirection.horizontal,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void validatePassword(String password) {
    // static String get passwordPattern => "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,}";
    final passwordPattern = RegExp("^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,}");
    if (password.isEmpty) {
      passwordController.sink.addError("please fill in the  field");
      // return "please fill in the  field";
    } else if (password.length < 8) {
      passwordController.sink.addError('Password should contain'
          'at least 8 characters');
    } else {
      passwordController.sink.add(password);
    }
  }

  void storeLoginInformation(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("email", email);
    await prefs.setString("password", password);
    // await _storage.write(key: "email", value: email);
    // await _storage.write(key: "password", value: password);
  }

  dynamic readLoginInformation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> loginDetails = {"email": "", "password": ""};
    // String? storedEmail = await _storage.read(key: "email");
    // String? storedPassword = await _storage.read(key: "password");

    final String? storedEmail = prefs.getString("email");
    final String? storedPassword = prefs.getString("password");

    if (storedEmail == null || storedPassword == null) {
      return null;
    } else {
      loginDetails["email"] =  storedEmail;
      loginDetails["password"] = storedPassword;

      // print(loginDetails["email"]);

      return loginDetails;
    }
  }

  void deleteLoginInformation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("email");
    prefs.remove("password");

    // await _storage.delete(key: "email");
    // await _storage.delete(key: "password");
  }

  void proceedToLogin() {
    emit(LoginInitialState());
  }

  void proceedToRegister() {
    emit(RegisterInitialState());
  }

  bool isAuthenticated(){
    if(user !=null){
      emit(LoginSuccessfulState(user: user as UserModel));
      print("Authenticated");
      return true;
    }else{
     emit(AuthInitialState());
     print("Not Authenticated");
     return false;
    }

  }

  void backToSeatsSelect(){

  }

  void loginUser(BuildContext context) async {
    emit(AuthLoadingState(message: "Logging in"));
    var response = await authServices.login(
        email: emailController.value, password: passwordController.value);
    if (response["code"] == 200) {
      storeLoginInformation(emailController.value, passwordController.value);
      emit(LoginSuccessfulState(user: response["data"]));
      user=response["data"];
    } else {
      if (response["code"] == 403) {
        LoginErrorModel errorModel = response["data"];
        emit(LoginErrorState( email: emailController.value, password: passwordController.value));
        loginErrorController.sink.addError(errorModel.detail);
      } else {
        emit(AuthInitialState());
        loginErrorController.sink.addError(response["data"]);
        emit(LoginErrorState(email: emailController.value, password: passwordController.value));
      }
    }
  }

  void registerUser({
    required String firtsName,
    required String lastName,
    required String email,
    required String password,
    required String phoneNumber,
    required String idNumber,
  }) async {
    emit(AuthLoadingState(message: "Sending Data"));
    UserModel user = await authServices.registerUser(
        firtsName: firtsName,
        lastName: lastName,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        idNumber: idNumber);

    if (user != null) {
      emit(RegisterSuccessfulState(user: user));
    } else {
      // emit(AuthErrorState(message: "An error occurred"));
    }
  }

  void updateProfile({
    required String firstName,
    required String lastname,
    required String email,
    required String phone,
    required String password,
    required String id,
    required String idnumber,
  }) async {
    var response = await authServices.updateProfile(
        idNumber: idnumber,
        firstName: firstName,
        lastname: lastname,
        email: email,
        phone: phone,
        password: password,
        id: id);
    print(response);
  }
}
