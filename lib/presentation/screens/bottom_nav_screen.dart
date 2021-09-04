import 'package:bday_reminder_bloc/cubit/auth/auth_cubit.dart';
import 'package:bday_reminder_bloc/cubit/bottom_nav/bottom_nav_cubit.dart';
import 'package:bday_reminder_bloc/cubit/home/born_today_cubit.dart';
import 'package:bday_reminder_bloc/cubit/home/upcoming_cubit.dart';
import 'package:bday_reminder_bloc/cubit/people/add_person_cubit.dart';
import 'package:bday_reminder_bloc/cubit/people/people_cubit.dart';
import 'package:bday_reminder_bloc/cubit/settings/settings_cubit.dart';
import 'package:bday_reminder_bloc/presentation/screens/home_screen.dart';
import 'package:bday_reminder_bloc/presentation/screens/login_screen.dart';
import 'package:bday_reminder_bloc/presentation/screens/people_screen.dart';
import 'package:bday_reminder_bloc/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BottomNavState();
  }
}

class _BottomNavState extends State<BottomNavPage> {
  final List<Widget> _fragments = <Widget>[
    HomeScreen(),
    PeopleScreen(),
    SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<BottomNavCubit, BottomNavState>(
        builder: (context, state) {
          return Scaffold(
              body: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
                  if (authState is AlreadySignedInState) {
                    return Center(
                      child: getBottomNavChild(context,state.selectedIndex),
                    );
                  }

                  if (authState is NotLoggedInState) {
                    debugPrint("Not logged in state");
                    
                    
                  }
                  if (authState is SignInFailedState) {
                    return Text("login failed");
                  }
                  if (authState is NewlyLoggedInState) {
                    return Center(
                      child: getBottomNavChild(context,state.selectedIndex),
                    );
                  }
                  return Text("Loading");
                },
              ),
              bottomNavigationBar: BottomNavigationBar(
                elevation: 0,
                currentIndex: state.selectedIndex,
                selectedItemColor: Theme.of(context).colorScheme.primary,
                unselectedItemColor: const Color(0xff808080),
                backgroundColor: const Color(0xfff3f3f4),
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home_filled), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.people), label: "People"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: "Settings"),
                ],
                onTap:
                    BlocProvider.of<BottomNavCubit>(context).setSelectedIndex,
              ));
        },
      ),
    );
  }

  Widget getBottomNavChild(BuildContext context,int index) {
    switch (index) {
      case 0:
        return MultiBlocProvider(providers: [
          BlocProvider<UpcomingCubit>(create: (context) => UpcomingCubit()),
          BlocProvider<BornTodayCubit>(create: (context) => BornTodayCubit())
        ], child: _fragments.elementAt(index));
        
      case 1:
        return MultiBlocProvider(providers: [
          BlocProvider<PeopleCubit>(create: (context) => PeopleCubit()),
          BlocProvider<AddPersonCubit>(create: (context) => AddPersonCubit()),

        ], child: _fragments.elementAt(index));
        
      case 2:
        return MultiBlocProvider(providers: [
          BlocProvider<SettingsCubit>(create: (context) => SettingsCubit())
        ], child: _fragments.elementAt(index));
        
      default:
        return MultiBlocProvider(providers: [
          BlocProvider<UpcomingCubit>(create: (context) => UpcomingCubit())
        ], child: _fragments.elementAt(index));
    }
  }
}
