import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../account/register/register_page.dart';
import '../common/chat_service.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const ChatPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<ChatService>().logout();
              Navigator.of(
                context,
              ).pushAndRemoveUntil(RegisterPage.route(), (route) => false);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(child: Text("Chat placeholder")),
    );
  }
}
