import 'package:chat/common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../account/register/register_page.dart';
import '../common/chat_service.dart';
import 'chat_bubble.dart';
import 'chat_cubit.dart';
import 'chat_state.dart';
import 'message_bar.dart';

/// Page to chat with someone.
///
/// Displays chat bubbles as a ListView and TextField to enter new chat.
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const ChatPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatCubit(context.read<ChatService>())..listenForMessage(),
      child: Scaffold(
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
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
                listener: (context, state) {
                  if (state.error != null) {
                    context.showErrorSnackBar(message: state.error!);
                  }
                },
                builder: (context, state) {
                  if (state.messages.isEmpty) {
                    return const Center(
                      child: Text('Start your conversation now :)'),
                    );
                  }
                  return ListView.builder(
                    reverse: true,
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message = state.messages[index];
                      return ChatBubble(
                        message: message,
                        profile: state.profileFor(message),
                      );
                    },
                  );
                },
              ),
            ),
            const MessageBar(),
          ],
        ),
      ),
    );
  }
}
