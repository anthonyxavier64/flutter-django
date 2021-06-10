import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

const httpHeader = {'Content-Type': 'multipart/form-data; charset=UTF-8'};

void uploadProfilePicture(String file, int userId, BuildContext context) async {
  List<String?> paths = [dotenv.env['API_URL'], '/user/uploadPicture'];
  final uri = paths.join();

  try {
    final request = http.MultipartRequest('POST', Uri.parse(uri));
    request.fields['id'] = userId.toString();
    request.files.add(await http.MultipartFile.fromPath('pic', file));
    final streamedResponse = await request.send();
    final strRep = await streamedResponse.stream.bytesToString();
    final decodedObj = jsonDecode(strRep);
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('user');
    if (user != null) {
      final decodedUser = jsonDecode(user);
      prefs.setString('user', jsonEncode({'id': decodedUser['id'], 'email': decodedUser['email'], 'password': decodedUser['password'], 'profilePicId': decodedObj['profilePicId']})); 
    }
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  } catch (e) {}
}

Future<String?> getProfilePictureUrl(String profilePicId) async {
  if (profilePicId != '') {
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref();
    print(ref);
    print(profilePicId);
    try {
      String url = await ref.child('profile/images/' + profilePicId).getDownloadURL();
      print(url);
      return url;
    } catch (e) {
      print(e);
    }
  }
  return null;
}
