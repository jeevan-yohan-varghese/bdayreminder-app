import 'dart:convert';
import 'dart:io';
import 'package:bday_reminder_bloc/data/helpers/general_api_response.dart';
import 'package:bday_reminder_bloc/data/helpers/telegram_verification_response.dart';
import 'package:bday_reminder_bloc/data/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SettingsRepo {
  Future<BdayUser> getUserInfo(String jwtToken) async {
    final response = await http.get(
        Uri.parse(
            'https://bday-reminder-api.herokuapp.com/api/getUserInfo?apiKey=${dotenv.env['API_KEY']}'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $jwtToken',
        });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //debugPrint(response.body);

      return BdayUser.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      debugPrint(response.body);
      throw Exception('Failed to fetch');
    }
  }

  //Update telegram settings
  Future<ApiResponse> updateTelegramSettings(
      String jwtToken, bool isTurnedOn) async {
    final response = await http.post(
        Uri.parse(
            'https://bday-reminder-api.herokuapp.com/api/toggleTelegram?apiKey=${dotenv.env['API_KEY']}'),
        headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: 'Bearer $jwtToken',
        },
        body: jsonEncode({'turnOn': isTurnedOn}));

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

  //Update telegram settings
  Future<ApiResponse> updatePushSettings(
      String jwtToken, bool isTurnedOn) async {
    final response = await http.post(
        Uri.parse(
            'https://bday-reminder-api.herokuapp.com/api/togglePush?apiKey=${dotenv.env['API_KEY']}'),
        headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: 'Bearer $jwtToken',
        },
        body: jsonEncode(<String, bool>{'turnOn': isTurnedOn}));

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

  Future<TelegramVerificationResponse> sendVerificationCode(
      String jwtToken, String channelId) async {
    final response = await http.post(
        Uri.parse(
            'https://bday-reminder-api.herokuapp.com/api/verifyChannelID?apiKey=${dotenv.env['API_KEY']}'),
        headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: 'Bearer $jwtToken',
        },
        body: jsonEncode(<String, String>{'channelId': channelId}));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //debugPrint(response.body);

      return TelegramVerificationResponse.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      debugPrint(response.body);
      throw Exception('Failed to fetch');
    }
  }


  Future<ApiResponse> updateTelegramChannel(String jwtToken,String channelId) async {
    final response = await http.post(
        Uri.parse(
            'https://bday-reminder-api.herokuapp.com/api/updateChannelId?apiKey=${dotenv.env['API_KEY']}'),
        headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: 'Bearer $jwtToken',
        },
        body: jsonEncode(<String, String>{'channelId': channelId}));

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
