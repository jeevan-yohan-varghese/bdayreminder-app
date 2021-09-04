import 'package:bday_reminder_bloc/data/helpers/login_response.dart';
import 'package:bday_reminder_bloc/data/repo/login_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthLoadingState()) {
    checkAlreadySignedIn();
  }
  void checkAlreadySignedIn() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      bool _isLoggedIn = sharedPreferences.getBool("isLoggedIn") ?? false;
      String _jwtToken = sharedPreferences.getString("jwtToken") ?? "";
      if (_isLoggedIn) {
        emit(AlreadySignedInState(jwtToken: _jwtToken));
      } else {
        emit(NotLoggedInState());
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(NotLoggedInState());
    }
  }

  void signIn() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    GoogleSignIn _googleSignIn = GoogleSignIn();

    // Trigger the authentication flow
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleSignInAccount!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final firebaseCredential = await auth.signInWithCredential(credential);
    String idToken = await firebaseCredential.user!.getIdToken(true);
    // Once signed in, return the UserCredential

    String recreatedToken = "";
    while (idToken.length > 0) {
      int initLength = (idToken.length >= 500 ? 500 : idToken.length);
      print(idToken.substring(0, initLength));
      int endLength = idToken.length;
      recreatedToken += idToken.substring(0, initLength);
      idToken = idToken.substring(initLength, endLength);
    }

    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      LoginResponse loginResponse =
          await LoginRepo().loginAsync(recreatedToken);
      debugPrint("Login status : ${loginResponse.success}");
      sharedPreferences.setBool("isLoggedIn", true);
      sharedPreferences.setString("jwtToken", loginResponse.authToken);
      emit(NewlyLoggedInState(jwtToken: loginResponse.authToken));
    } catch (e) {
      emit(SignInFailedState(error: e.toString()));
    }
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("isLoggedIn", false);
    sharedPreferences.setString("jwtToken", "");
    emit(SignOutState());
  }
}
