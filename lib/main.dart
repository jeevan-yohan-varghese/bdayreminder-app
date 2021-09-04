import 'package:bday_reminder_bloc/cubit/auth/auth_cubit.dart';
import 'package:bday_reminder_bloc/cubit/bottom_nav/bottom_nav_cubit.dart';
import 'package:bday_reminder_bloc/cubit/init/init_cubit.dart';
import 'package:bday_reminder_bloc/presentation/router/app_router.dart';
import 'package:bday_reminder_bloc/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeData theme = ThemeData();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BottomNavCubit>(create: (context) => BottomNavCubit()),
        BlocProvider<InitCubit>(create: (context)=>InitCubit()),
        BlocProvider<AuthCubit>(create: (context)=>AuthCubit()),
      ],
      child: MaterialApp(
        title: 'Bday Reminder',
        debugShowCheckedModeBanner: false,
        theme: theme.copyWith(
                textTheme: TEXT_THEME_DEFAULT,
                colorScheme: theme.colorScheme.copyWith(
                    secondary: const Color(0xff4CB5AE),
                    primary: const Color(0xff5438DC)),
              ),
        onGenerateRoute: AppRouter().onGenerateRoute,
      ),
    );
  }
}
