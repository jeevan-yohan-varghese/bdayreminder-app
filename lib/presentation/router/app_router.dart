import 'package:bday_reminder_bloc/cubit/auth/auth_cubit.dart';
import 'package:bday_reminder_bloc/cubit/init/init_cubit.dart';
import 'package:bday_reminder_bloc/presentation/screens/bottom_nav_screen.dart';
import 'package:bday_reminder_bloc/presentation/screens/login_screen.dart';
import 'package:bday_reminder_bloc/presentation/screens/people_screen.dart';
import 'package:bday_reminder_bloc/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (homeContext) {
          return BlocBuilder<InitCubit, InitState>(
            builder: (context, state) {
              if (state is InitSuccess) {
                return BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (state is AlreadySignedInState ||
                        state is NewlyLoggedInState) {
                      return BottomNavPage();
                    }
                    return LoginScreen();
                  },
                );
              }
              if (state is InitFailed) {
                debugPrint("Init failed");
                return Text("Some error occured : ${state.error}");
              }

              return Container();
            },
          );
        });

      case '/second':
        return MaterialPageRoute(builder: (_) {
          return PeopleScreen();
        });
      case '/third':
        return MaterialPageRoute(builder: (_) {
          return SettingsScreen();
        });
      case '/login':
        return MaterialPageRoute(builder: (_) {
          return LoginScreen();
        });

      default:
        return null;
    }
  }
}
