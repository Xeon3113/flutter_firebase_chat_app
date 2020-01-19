import 'package:chat_app_v_1_0/screens/chat_home_page.dart';
import 'package:chat_app_v_1_0/screens/chat_page.dart';
import 'package:chat_app_v_1_0/screens/login_page.dart';
import 'package:chat_app_v_1_0/screens/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

final ThemeData iOSTheme = new ThemeData(
  primarySwatch: Colors.red,
  primaryColor: Colors.grey[400],
  primaryColorBrightness: Brightness.dark,
);

final ThemeData androidTheme = new ThemeData(
  primarySwatch: Colors.blue,
  accentColor: Colors.green,
);

const String defaultUserName = "John Doe";

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Chat Application",
      theme: defaultTargetPlatform == TargetPlatform.iOS
          ? iOSTheme
          /*: ThemeData.dark(),*/
          : androidTheme,
      initialRoute: ChatHomePage.id,
      routes: {
        ChatHomePage.id: (context) => ChatHomePage(),
        Registration.id: (context) => Registration(),
        Login.id: (context) => Login(),
        Chat.id: (context) => Chat(),
      },
    );
  }
}
