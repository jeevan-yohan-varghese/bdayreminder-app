import 'dart:convert';
import 'dart:io';

import 'package:bday_reminder_bloc/data/helpers/general_api_response.dart';
import 'package:bday_reminder_bloc/data/helpers/people_list_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
class PeopleRepo{
 Future<PeopleList> getPeopleList(String jwtToken) async {
    final response = await http.get(
        Uri.parse(
            'https://bday-reminder-api.herokuapp.com/api/listPersons?apiKey=${dotenv.env['API_KEY']}'),
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
      debugPrint(response.body);
      throw Exception('Failed to fetch');
    }
  }


   Future<ApiResponse> addNewPerson(String jwtToken,String name, String dob) async {
    final response = await http.post(
        Uri.parse(
            'https://bday-reminder-api.herokuapp.com/api/addPerson?apiKey=${dotenv.env['API_KEY']}'),
        headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader:
              'Bearer $jwtToken',
        },
        body: jsonEncode(<String, String>{'name': name, 'dob': dob}));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //debugPrint(response.body);

      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      debugPrint(response.body);
      throw Exception('Failed to fetch');
    }
  }


  Future<ApiResponse> editPerson(String jwtToken,String id, String name, String dob) async {
    final response = await http.patch(
        Uri.parse(
            'https://bday-reminder-api.herokuapp.com/api/updatePerson?apiKey=${dotenv.env['API_KEY']}'),
        headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader:
              'Bearer $jwtToken',
        },
        body: jsonEncode(
            <String, String>{'personId': id, 'name': name, 'dob': dob}));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //debugPrint(response.body);

      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      debugPrint(response.body);
      throw Exception('Failed to fetch');
    }
  }


  Future<ApiResponse> deletePerson(String jwtToken,String id) async {
    final response = await http.delete(
        Uri.parse(
            'https://bday-reminder-api.herokuapp.com/api/deletePerson?apiKey=${dotenv.env['API_KEY']}'),
        headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader:
              'Bearer $jwtToken',
        },
        body: jsonEncode(<String, String>{'personId': id}));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //debugPrint(response.body);

      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      debugPrint(response.body);
      throw Exception('Failed to fetch');
    }
  }
}