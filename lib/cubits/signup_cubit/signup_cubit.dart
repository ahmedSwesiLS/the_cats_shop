import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_cats_shop_app/cubits/signup_cubit/signup_states.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  void signup({required String email, required String password}) async {
    emit(SignupLoading());

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // TODO: to signup with phone number use:
      // await FirebaseAuth.instance
      //     .verifyPhoneNumber(phoneNumber: '091111111');

      emit(SignUpSuccess(successMessage: 'Signup done'));
    } catch (e) {
      emit(SignupFailure(errorMessage: 'Signup error'));
    }
  }
}
