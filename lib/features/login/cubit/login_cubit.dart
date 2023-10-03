import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/constant.dart';
import '../../map/google_map.dart';
import '../../map/map.dart';
import 'login_state.dart';




class LoginCubit extends Cubit<LoginStates> {


  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);


  signUPWithEmailAndPassword({required context ,required String email,required String password}) async {
    try {
      emit(SignUpLoadingState());
       await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SignUpSuccessState());
      navigateToAndStop(context, MapGoogle());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignUpFailureState(
          errMessage: 'The password provided is too weak.'
        ));
        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        emit(SignUpFailureState(
            errMessage: 'The account already exists for that email.'
        ));
       // print('The account already exists for that email.');
      }
    } catch (e) {
      emit(SignUpFailureState(
          errMessage: e.toString()
      ));
    }
  }

  signInWithEmailAndPassword(BuildContext context, {required String email,required String password}) async{
    try {
      emit(LoginLoadingState());
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      emit(LoginSuccessState());
      navigateToAndStop(context, const PolygonPage());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailureState(
            errMessage: 'No user found for that email.'
        ));
        //print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        emit(LoginFailureState(
            errMessage: 'Wrong password provided for that user.'
        ));
      }
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }



}