import 'package:chat/account/register/register_page.dart';
import 'package:chat/theme.dart';
import 'package:flutter/material.dart';

import 'account/login/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Chat App',
      theme: theme,
      home: RegisterPage(),
    );
  }
}
