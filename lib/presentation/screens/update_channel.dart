import 'package:bday_reminder_bloc/cubit/settings/channel_cubit.dart';
import 'package:bday_reminder_bloc/cubit/settings/settings_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TelegramChannelScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TelegramChannelState();
  }

  String channelId;
  TelegramChannelScreen({this.channelId = ""});
}

class _TelegramChannelState extends State<TelegramChannelScreen> {
  bool _showVer = false;
  late String channelId;
  TextEditingController channelIdController = TextEditingController();
  TextEditingController verCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChannelCubit>(
      create: (context) => ChannelCubit(),
      child: getChannelUi(),
    );
  }

  Widget getChannelUi() {
    return BlocListener<ChannelCubit, ChannelState>(
      listener: (context, state) {
        debugPrint(state.toString());
        if(state is ChannelUpdateSuccess){
          Navigator.pop(context,true);
        }
      },
      child: ScaffoldMessenger(
          child: Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Telegram Channel",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                leading: GestureDetector(
                  child: Icon(
                    Icons.arrow_left,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                backgroundColor: const Color(0xfffafafa),
                elevation: 0,
              ),
              body: BlocBuilder<ChannelCubit, ChannelState>(
                buildWhen: ((prev, current) {
                  if (current is ChannelWorkingState ||
                      current is ChannelUpdateError) {
                    return true;
                  }
                  return false;
                }),
                builder: (context, state) {
                  if (state is ChannelWorkingState) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  child: Text(
                                    "1",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Flexible(
                                    child: Column(
                                  children: [
                                    Text(
                                        "Add the bot @thebday_bot in your channel as administrator"),
                                  ],
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            getStep2(context),
                            SizedBox(
                              height: 24,
                            ),
                            getStep3(
                                context,
                                state.isVerificationSent,
                                state.verCode,
                                state.isVerificationSent ? channelId : "")
                          ],
                        ),
                      ),
                    );
                  }

                  if (state is ChannelUpdateError) {
                    return Text(state.error);
                  }
                  return Container();
                },
              ))),
    );
  }

  Widget getStep2(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          child: Text(
            "2",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        SizedBox(
          width: 12,
        ),
        Flexible(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Enter your telegram channel id"),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: channelIdController,
              decoration:
                  InputDecoration(labelText: "Channel ID", filled: true),
            ),
            OutlinedButton(
              onPressed: () {
                if (channelIdController.text.trim().isNotEmpty) {
                  channelId = channelIdController.text.trim();
                  channelId = channelId.replaceFirst("t.me/", "");
                  channelId = channelId.replaceFirst("@", "");
                  debugPrint(channelId);
                  BlocProvider.of<ChannelCubit>(context)
                      .sendVerification(channelIdController.text.trim());
                }
              },
              child: Text("Send Verification"),
            )
          ],
        )),
      ],
    );
  }

  Widget getStep3(
      BuildContext context, bool shouldShow, String token, String channelId) {
    return AnimatedOpacity(
      opacity: shouldShow ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            child: Text(
              "3",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          SizedBox(
            width: 12,
          ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("We have sent a 4 digit code to your telegram channel"),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: verCodeController,
                decoration:
                    InputDecoration(labelText: "4 digit code", filled: true),
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                  onPressed: () {
                    debugPrint("Enter code: ${verCodeController.text.trim()}");
                    debugPrint("Actual code: $token");
                    debugPrint("Is same: ${verCodeController.text.trim() == token}");
                    if (verCodeController.text.trim() == token) {
                      BlocProvider.of<ChannelCubit>(context)
                          .verifyChannel(channelId);
                    }
                  },
                  child: Text("Verify"))
            ],
          )),
        ],
      ),
    );
  }
}
