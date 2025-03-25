import 'package:chat/models/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ChatService {
  String? get userId;
  Future<void> login({required String email, required String password});
  Future<void> register({
    required String email,
    required String password,
    required String username,
  });
  Future<void> logout();
  Stream<List<Message>> messageStream();
  Future<void> submitMessage(String text);
  Future<Profile> fetchProfile(String id);
}

class SupabaseChatService extends ChatService {
  final _supabase = Supabase.instance.client;
  @override
  String? get userId => _supabase.auth.currentUser?.id;

  @override
  Future<void> login({required String email, required String password}) async {
    await _supabase.auth.signInWithPassword(email: email, password: password);
  }

  @override
  Future<void> register({
    required String email,
    required String password,
    required String username,
  }) async {
    await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {'username': username},
    );
  }

  @override
  Future<void> logout() async {
    await _supabase.auth.signOut();
  }

  @override
  Stream<List<Message>> messageStream() {
    return _supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .order('created_at')
        .map((maps) => maps.map((map) => MessageMapper.fromMap(map)).toList());
  }

  @override
  Future<void> submitMessage(String text) async {
    final myUserId = _supabase.auth.currentUser!.id;
    await _supabase.from('messages').insert({
      'profile_id': myUserId,
      'content': text,
    });
  }

  @override
  Future<Profile> fetchProfile(String id) async {
    final data =
        await _supabase.from('profiles').select().eq('id', id).single();
    return ProfileMapper.fromMap(data);
  }
}
