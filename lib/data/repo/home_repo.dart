import 'dart:convert';
import 'dart:io';

import 'package:bday_reminder_bloc/data/helpers/born_today_response.dart';
import 'package:bday_reminder_bloc/data/helpers/people_list_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
class HomeRepo{
  Future<PeopleList> getUpcomingList(String jwtToken) async {
    final response = await http.get(
        Uri.parse(
            'https://bday-reminder-api.herokuapp.com/api/topUpcoming?apiKey=${dotenv.env['API_KEY']}'),
        headers: {
          HttpHeaders.authorizationHeader:
          'Bearer $jwtToken',
        });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //debugPrint(response.body);

      return PeopleList.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to fetch');
    }
  }


  Future<BornToday> getBornToday(String jwtToken) async {
    final response = await http.get(
        Uri.parse(
            'https://bday-reminder-api.herokuapp.com/api/bornToday?apiKey=${dotenv.env['API_KEY']}'),
        headers: {
          HttpHeaders.authorizationHeader:
          'Bearer $jwtToken',
        });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //debugPrint(response.body);

      return BornToday.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      debugPrint(response.body);
      throw Exception('Failed to fetch');
    }
  }
}