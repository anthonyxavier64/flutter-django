import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import '../../functions/image-management.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/profile';

  ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User user = User();

  @override
  void initState() {
    super.initState();
    getUser().then((result) {
      if (result != null) {
        setState(() {
          user = result;
        });
      }
    });
  }

  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('user');

    if (user != null) {
      User currentUser = User.fromJson(jsonDecode(user));
      return currentUser;
    }
    return null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
  }

  Future<void> pickPhoto() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      String? filePath = result.files.single.path;
      if (filePath != null) {
        uploadProfilePicture(filePath, user.userId, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Center(
          child: Column(
        children: [
          Text(user.userId.toString()),
          SizedBox(height: 10),
          Text(user.email),
          SizedBox(height: 10),
          Text(user.password),
          SizedBox(height: 10),
          Text(user.profilePicId),
          SizedBox(height: 10),
          FloatingActionButton.extended(
            heroTag: 'logoutbtn',
            onPressed: () {
              logout();
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
            label: Text('Logout'),
          ),
          SizedBox(height: 10),
          FloatingActionButton.extended(
            onPressed: () {
              pickPhoto();
            },
            label: Text('Upload Picture'),
          ),
          SizedBox(height: 50),
          FutureBuilder(
            future: getProfilePictureUrl(user.profilePicId),
            builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
              if (snapshot.hasData) {
                return CircleAvatar(
                  backgroundColor: Colors.black12,
                  maxRadius: 100,
                  backgroundImage: NetworkImage("${snapshot.data}"),
                );
              } else {
                return CircleAvatar(
                  backgroundColor: Colors.black12,
                  maxRadius: 100,
                );
              }
            },
          ),
        ],
      )),
    );
  }
}
