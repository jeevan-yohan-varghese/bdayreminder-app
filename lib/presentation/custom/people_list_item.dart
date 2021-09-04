import 'package:bday_reminder_bloc/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class PeopleListItem extends StatelessWidget {
  final String name;
  final String dob;

  const PeopleListItem(
      {Key? key, required this.name, required this.dob})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(dob);
    String formattedDate = DateFormat('MMM dd').format(dateTime);
    return (ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 36.0),
      leading: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(shape: BoxShape.circle, color: COLOR_ORANGE),
        child: Text(
          name[0].toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      title: Text(
        name,
        style: TextStyle(
            fontWeight: FontWeight.w500, color: Colors.black, fontSize: 16.0),
      ),
      subtitle: Text(
        formattedDate,
        style: TextStyle(
            fontWeight: FontWeight.w400, color: Colors.grey, fontSize: 14.0),
      ),

    ));
  }
}
