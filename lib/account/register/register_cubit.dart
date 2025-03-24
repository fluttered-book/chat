import 'package:chat/common/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../common/chat_service.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final ChatService service;
  RegisterCubit(this.service) : super(RegisterReady());

  Future<void> register({
    required String email,
    required String password,
    required String username,
  }) async {
    emit(RegisterLoading());
    try {
      await service.register(
        email: email,
        password: password,
        username: username,
      );
      emit(Registered());
    } on AuthException catch (error) {
      emit(RegisterError(error.message));
    } catch (error) {
      emit(RegisterError(unexpectedErrorMessage));
    }
  }
}
