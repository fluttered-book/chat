import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:timeago/timeago.dart';

import '../common/chat_service.dart';
import '../common/widgets.dart';
import '../models/models.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message, required this.profile});

  final Message message;
  final Profile? profile;

  @override
  Widget build(BuildContext context) {
    final isMine = context.read<ChatService>().userId == message.profileId;
    List<Widget> chatContents = [
      if (!isMine)
        CircleAvatar(
          child:
              profile == null
                  ? Spinner()
                  : Text(profile!.username.substring(0, 2)),
        ),
      const SizedBox(width: 12),
      Flexible(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: isMine ? Theme.of(context).primaryColor : Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(message.content),
        ),
      ),
      const SizedBox(width: 12),
      Text(format(message.createdAt, locale: 'en_short')),
      const SizedBox(width: 60),
    ];
    if (isMine) {
      chatContents = chatContents.reversed.toList();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
      child: Row(
        mainAxisAlignment:
            isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: chatContents,
      ),
    );
  }
}
