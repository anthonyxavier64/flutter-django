import 'package:flutter/material.dart';
import '../../functions/user-login.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';

  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'email'),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'password'),
            ),
            SizedBox(
              height: 20,
            ),
            FloatingActionButton.extended(
              onPressed: () {
                userLogin(
                  email: emailController.text,
                  password: passwordController.text,
                  context: context,
                );
              },
              label: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
