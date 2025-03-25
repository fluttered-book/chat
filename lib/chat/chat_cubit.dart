import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/chat_service.dart';
import '../common/widgets.dart';
import '../models/models.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatService service;
  StreamSubscription<List<Message>>? _messageSubscription;

  ChatCubit(this.service) : super(ChatState.empty());

  void listenForMessage() {
    service.messageStream().listen((messages) {
      emit(state.copyWith(messages: messages));
      for (var message in messages) {
        _loadProfileCache(message.profileId);
      }
    }, onError: (e) => state.copyWith(error: e.toString()));
  }

  void submitMessage(String text) async {
    if (text.isEmpty) return;
    try {
      service.submitMessage(text);
    } on Exception catch (error) {
      emit(state.copyWith(error: error.toString()));
    } catch (_) {
      emit(state.copyWith(error: unexpectedErrorMessage));
    }
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    return super.close();
  }

  Future<void> _loadProfileCache(String profileId) async {
    if (state.profileCache[profileId] != null) return;
    final profile = await service.fetchProfile(profileId);
    emit(
      state.copyWith(profileCache: {...state.profileCache, profileId: profile}),
    );
  }
}
