import 'package:chat_app_v_1_0/screens/chat_page.dart';
import 'package:chat_app_v_1_0/utils/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  static const String id = "REGISTRATION";

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String email;
  String password;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> registerUser() async {
    AuthResult result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final FirebaseUser user = result.user;

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Chat(user: user),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Core Chat'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Hero(
              tag: 'logo',
              child: Container(
                child: Image.asset(
                  'assets/images/logo.png',
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Enter Your Email...',
              border: const OutlineInputBorder(),
            ),
            validator: (String value) {
              if (value.isEmpty || !value.contains("@")) {
                return 'Please enter your email address';
              }
              return null;
            },
            onChanged: (value) => email = value,
          ),
          SizedBox(
            height: 40.0,
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Enter Your Password...',
              border: const OutlineInputBorder(),
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
            onChanged: (value) => password = value,
          ),
          CustomButton(
            text: 'Register',
            callback: () async {
              if (_formKey.currentState.validate()) {
                await registerUser();
              }
            },
          )
        ],
      ),
    );
  }
}