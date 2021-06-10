import 'package:flutter/material.dart';
import '../../functions/user-registration.dart';

class RegistrationPage extends StatefulWidget {
  static const routeName = '/registration';

  RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
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
                createNewUser(
                  email: emailController.text,
                  password: passwordController.text,
                  context: context
                );
              },
              label: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
