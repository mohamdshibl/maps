
abstract class LoginStates {
}

class LoginInitial extends LoginStates {}

class SignUpLoadingState extends LoginStates {}
class SignUpSuccessState extends LoginStates {}
class SignUpFailureState extends LoginStates {
   final String errMessage;
  SignUpFailureState({required this.errMessage});
}


class LoginLoadingState extends LoginStates {}
class LoginSuccessState extends LoginStates {}
class LoginFailureState extends LoginStates {
  final String errMessage;
  LoginFailureState({required this.errMessage});
}


