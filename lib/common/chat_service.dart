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
}
