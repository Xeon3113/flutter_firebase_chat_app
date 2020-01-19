import 'package:chat_app_v_1_0/screens/login_page.dart';
import 'package:chat_app_v_1_0/screens/registration_page.dart';
import 'package:chat_app_v_1_0/utils/custom_button.dart';
import 'package:flutter/material.dart';

class ChatHomePage extends StatelessWidget {
  static const String id = "HOMESCREEN";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                    tag: 'logo',
                    child: Container(
                      width: 100.0,
                      child: Image.asset('assets/images/logo.png'),
                    )),
                Text(
                  'Core Chat',
                  style: TextStyle(fontSize: 40.0),
                ),
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            CustomButton(
              text: 'Log In',
              callback: () {
                Navigator.of(context).pushNamed(Login.id);
              },
            ),
            CustomButton(
              text: 'Sign In',
              callback: () {
                Navigator.of(context).pushNamed(Registration.id);
              },
            ),
          ],
        ));
  }
}