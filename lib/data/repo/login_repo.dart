
import 'dart:convert';

import 'package:bday_reminder_bloc/data/helpers/login_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
class LoginRepo{
  Future<LoginResponse> loginAsync(String token) async {
    debugPrint("*********************Google ID token : $token ");
    final response = await http.post(
        Uri.parse(
            'https://bday-reminder-api.herokuapp.com/auth/login?apiKey=${dotenv.env['API_KEY']}'),
        headers: {
          "Content-Type": "application/json",
         },
        body: jsonEncode(<String, String>{'authtoken': token}));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //debugPrint(response.body);

      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      debugPrint(response.body);
      throw Exception('Failed to fetch');
    }
  }
}