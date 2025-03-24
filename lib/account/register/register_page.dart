import 'package:chat/common/chat_service.dart';
import 'package:chat/common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../chat/chat_page.dart';
import 'register_cubit.dart';
import 'register_form.dart';
import 'register_state.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const RegisterPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(context.read<ChatService>()),
      child: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is Registered) {
            Navigator.of(
              context,
            ).pushAndRemoveUntil(ChatPage.route(), (route) => false);
          } else if (state is RegisterError) {
            context.showErrorSnackBar(message: state.message);
          }
        },
        child: Scaffold(
          appBar: AppBar(title: const Text('Register')),
          body: RegisterForm(),
        ),
      ),
    );
  }
}
