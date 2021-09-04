import 'package:bday_reminder_bloc/cubit/auth/auth_cubit.dart';
import 'package:bday_reminder_bloc/cubit/settings/settings_cubit.dart';
import 'package:bday_reminder_bloc/data/models/user_model.dart';
import 'package:bday_reminder_bloc/presentation/custom/list_divider.dart';
import 'package:bday_reminder_bloc/presentation/screens/login_screen.dart';
import 'package:bday_reminder_bloc/presentation/screens/update_channel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingsState();
  }
}

class _SettingsState extends State<SettingsScreen> {
  TextStyle itemTitleStyle =
      const TextStyle(color: Colors.black, fontWeight: FontWeight.w500);
  TextStyle groupTitleStyle =
      const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500);
  TextStyle itemDescStyle =
      const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SettingsCubit>(context).loadSettings();

    return MultiBlocListener(
      listeners: [
        BlocListener<SettingsCubit, SettingsState>(
          listener: (context, state) {
            if (state is SettingsActionSuccess) {
              BlocProvider.of<SettingsCubit>(context).loadSettings();
              Navigator.pop(context);
            }
          },
        ),
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is SignOutState) {
                Navigator.pushReplacementNamed(context, '/login');
            }
          },
        ),

      ],
      child: getSettingsUi(),
    );
  }

  Widget getSettingsUi() {
    return ScaffoldMessenger(
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Settings",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: const Color(0xfffafafa),
            elevation: 0,
          ),
          body: BlocBuilder<SettingsCubit, SettingsState>(
            buildWhen: (previous, current) {
              if (current is SettingsSuccess || current is SettingsError) {
                return true;
              }
              return false;
            },
            builder: (context, state) {
              if (state is SettingsSuccess) {
                debugPrint("Settings success");
                BdayUser _currUser = state.currentUser;
                return Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(_currUser.profilePic),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _currUser.name,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              Text(_currUser.email,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey))
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TelegramChannelScreen()),
                                ).then((value) {
                                  if (value) {
                                    BlocProvider.of<SettingsCubit>(context)
                                        .loadSettings();
                                  }
                                });
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Telegram Channel ID",
                                    style: itemTitleStyle,
                                  ),
                                  Text(_currUser.telegram,
                                      style: itemDescStyle),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      ListDivider(),
                      Text("Notifications", style: groupTitleStyle),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Telegram",
                            style: itemTitleStyle,
                          )),
                          Switch(
                              activeColor:
                                  Theme.of(context).colorScheme.secondary,
                              value: _currUser.isTelegram,
                              onChanged: (newVal) {
                                showProgressDialog(
                                    context, "Updating settings");
                                BlocProvider.of<SettingsCubit>(context)
                                    .toggleTelegram(newVal);
                              })
                        ],
                      ),
                      Text(
                        "Turn on telegram notification",
                        style: itemDescStyle,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Push Notification",
                            style: itemTitleStyle,
                          )),
                          Switch(
                              activeColor:
                                  Theme.of(context).colorScheme.secondary,
                              value: _currUser.isPush,
                              onChanged: (newVal) {
                                showProgressDialog(
                                    context, "Updating settings");
                                BlocProvider.of<SettingsCubit>(context)
                                    .togglePush(newVal);
                              })
                        ],
                      ),
                      Text(
                        "Turn on push notification",
                        style: itemDescStyle,
                      ),
                      ListDivider(),
                      Text("Account", style: groupTitleStyle),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Clear list",
                                    style: itemTitleStyle,
                                  ),
                                  Text(
                                    "Delete all people you have added",
                                    style: itemDescStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                BlocProvider.of<AuthCubit>(context).signOut();
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Sign out",
                                    style: itemTitleStyle,
                                  ),
                                  Text(
                                    "Sign out of your account on this device",
                                    style: itemDescStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }

              if (state is SettingsError) {
                debugPrint("Settings Error: ${state.error}");
                return Text("Error : ${state.error}");
              }

              return Text("Loading settings ...");
            },
          )),
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
}
