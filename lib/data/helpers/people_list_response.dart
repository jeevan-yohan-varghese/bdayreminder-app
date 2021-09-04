 

import 'package:bday_reminder_bloc/data/models/person.dart';

class PeopleList {
  final List<Person> peopleList;

  PeopleList({
    required this.peopleList,
  });

  factory PeopleList.fromJson(Map<String, dynamic> json) {
    List<Person> pList = [];
    json['data'].forEach((v) {
      pList.add(Person.fromJson(v));
    });
    return PeopleList(
      peopleList: pList,
    );
  }
}
