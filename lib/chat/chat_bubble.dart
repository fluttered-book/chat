import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:timeago/timeago.dart';

import '../common/chat_service.dart';
import '../common/widgets.dart';
import '../models/models.dart';

class ChatBubble extends StatelessWidget {
  final Message message;
  final Profile? profile;

  const ChatBubble({super.key, required this.message, required this.profile});

  static const space = SizedBox(width: 12);
  static const sideSpace = SizedBox(width: 60);

  @override
  Widget build(BuildContext context) {
    final isMine = context.read<ChatService>().userId == message.profileId;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
      child: isMine ? _buildMine(context) : _buildOther(context),
    );
  }

  Widget _buildMine(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        sideSpace,
        timeAgo,
        space,
        text(color: Theme.of(context).primaryColor),
        space,
      ],
    );
  }

  Widget _buildOther(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        avatar,
        space,
        text(color: Colors.grey[300]!),
        space,
        timeAgo,
        sideSpace,
      ],
    );
  }

  Widget text({required Color color}) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(message.content),
      ),
    );
  }

  Widget get timeAgo => Text(format(message.createdAt, locale: 'en_short'));
  Widget get avatar => CircleAvatar(
    child:
        profile == null ? Spinner() : Text(profile!.username.substring(0, 2)),
  );
}
