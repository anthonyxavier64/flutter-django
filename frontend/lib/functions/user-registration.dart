import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

const httpHeader = {'Content-Type': 'application/json; charset=UTF-8'};

void createNewUser(
    {@required email, @required password, @required context}) async {
  List<String?> paths = [dotenv.env['API_URL'], '/user/register'];
  final uri = paths.join();
  print(uri);
  try {
    final response = await http.post(Uri.parse(uri),
        headers: httpHeader,
        body:
            jsonEncode(<String, String>{'email': email, 'password': password}));
   
    User user = User.fromJson(jsonDecode(response.body));

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', response.body);

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/',
      (route) => false,
      arguments: user,
    );
  } catch (e) {
    print(e);
  }
}
