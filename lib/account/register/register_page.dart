import 'package:flutter/material.dart';

import '../../common/widgets.dart';
import '../login/login_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const RegisterPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Form(
        child: ListView(
          padding: formPadding,
          children: [
            TextFormField(
              decoration: const InputDecoration(label: Text('Email')),
              keyboardType: TextInputType.emailAddress,
            ),
            const FormSpacer(),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(label: Text('Password')),
            ),
            const FormSpacer(),
            TextFormField(
              decoration: const InputDecoration(label: Text('Username')),
            ),
            const FormSpacer(),
            ElevatedButton(onPressed: () {}, child: const Text('Register')),
            const FormSpacer(),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(LoginPage.route());
              },
              child: const Text('I already have an account'),
            ),
          ],
        ),
      ),
    );
  }
}
