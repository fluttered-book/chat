import '../models/models.dart';

class ChatState {
  final List<Message> messages;
  final Map<String, Profile> profileCache;
  final String? error;

  ChatState({required this.messages, required this.profileCache, this.error});

  ChatState.empty() : messages = [], profileCache = {}, error = null;

  ChatState copyWith({
    List<Message>? messages,
    Map<String, Profile>? profileCache,
    String? error,
  }) => ChatState(
    messages: messages ?? this.messages,
    profileCache: profileCache ?? this.profileCache,
    error: error ?? this.error,
  );

  Profile? profileFor(Message message) => profileCache[message.profileId];
}
