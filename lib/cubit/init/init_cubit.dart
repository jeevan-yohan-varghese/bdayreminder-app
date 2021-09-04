import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
part 'init_state.dart';

class InitCubit extends Cubit<InitState> {
  InitCubit() : super(InitLoading()) {
    _initApp();
  }

  void _initApp() async {
    try {
      await dotenv.load(fileName: ".env");
      await Firebase.initializeApp();

      FirebaseMessaging.instance.getToken().then((mFCMtoken) {
        emit(InitSuccess(fcmDeviceId: mFCMtoken ?? ""));
      });
    } catch (e) {
      emit(InitFailed(error: e.toString()));
    }
  }
}
