import 'package:chat/common/chat_service.dart';
import 'package:chat/common/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final ChatService service;

  LoginCubit(this.service) : super(LoginReady());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await service.login(email: email, password: password);
      emit(LoggedIn());
    } on AuthException catch (error) {
      emit(LoginError(error.message));
    } catch (_) {
      emit(LoginError(unexpectedErrorMessage));
    }
  }
}
