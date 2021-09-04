import 'package:bday_reminder_bloc/cubit/auth/auth_cubit.dart';
import 'package:bday_reminder_bloc/main.dart';
import 'package:bday_reminder_bloc/presentation/screens/bottom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is NewlyLoggedInState) {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, '/');
        }
      },
      child: SafeArea(
          child: Scaffold(
              body: Container(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 36,
            ),
            Text(
              "Never miss a",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            Text(
              "Birthday",
              style: TextStyle(
                  fontSize: 36, color: Theme.of(context).colorScheme.primary),
            ),
            Text(
              "again",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Image.asset("assets/bday_illus.png"),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    showProgressDialog(context, "Signing in");
                    BlocProvider.of<AuthCubit>(context).signIn();
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/google.png",
                        width: 24,
                      ),
                      Text(
                        "Sign in with google",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  )),
            ),
            Expanded(
                child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24)),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Bday Reminder",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              GestureDetector(
                                onTap: () {
                                  _launchURL(
                                      "https://github.com/jeevan-yohan-varghese");
                                },
                                child: Row(children: [
                                  Image.asset(
                                    "assets/github.png",
                                    width: 30,
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    "View project on Github",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                ]),
                              )
                            ],
                          ),
                        ]),
                  ),
                ],
              ),
            ))
          ],
        ),
      ))),
    );
  }

  void showProgressDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Color(0xfffafafa),
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CircularProgressIndicator(),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        message,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _launchURL(_url) async {
    try {
      await canLaunch(_url);
      await launch(_url);
    } catch (e) {}
  }
}
