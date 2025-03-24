import 'package:chat/account/login/login_form.dart';
import 'package:chat/common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../chat/chat_page.dart';
import '../../common/chat_service.dart';
import 'login_cubit.dart';
import 'login_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(context.read<ChatService>()),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoggedIn) {
            Navigator.of(
              context,
            ).pushAndRemoveUntil(ChatPage.route(), (route) => false);
          } else if (state is LoginError) {
            context.showErrorSnackBar(message: state.message);
          }
        },
        builder:
            (context, state) => Scaffold(
              appBar: AppBar(title: const Text('Sign In')),
              body: LoginForm(),
            ),
      ),
    );
  }
}
