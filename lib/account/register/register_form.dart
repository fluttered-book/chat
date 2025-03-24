import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/widgets.dart';
import '../login/login_page.dart';
import 'register_cubit.dart';
import 'register_state.dart';
import 'validators.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;
    context.read<RegisterCubit>().register(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: ListView(
            padding: formPadding,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(label: Text('Email')),
                keyboardType: TextInputType.emailAddress,
                validator: emailValidator,
              ),
              const FormSpacer(),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(label: Text('Password')),
                validator: passwordValidator,
              ),
              const FormSpacer(),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(label: Text('Username')),
                validator: usernameValidator,
              ),
              const FormSpacer(),
              ElevatedButton(
                onPressed: state is RegisterLoading ? null : _signUp,
                child: const Text('Register'),
              ),
              const FormSpacer(),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(LoginPage.route());
                },
                child: const Text('I already have an account'),
              ),
            ],
          ),
        );
      },
    );
  }
}
