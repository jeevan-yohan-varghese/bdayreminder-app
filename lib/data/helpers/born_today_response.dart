
import 'package:bday_reminder_bloc/data/models/person.dart';

class BornToday {
  List<Person> bornTodayList;

  BornToday({required this.bornTodayList});

  factory BornToday.fromJson(Map<String, dynamic> json) {
    List<Person> bornList = [];
    json['data'].forEach((v) {
      bornList.add(Person.fromJson(v));
    });
    return BornToday(
      bornTodayList: bornList,
    );
  }
}
