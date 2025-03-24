import 'package:flutter/foundation.dart';

@immutable
abstract class RegisterState {}

class RegisterReady extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterError extends RegisterState {
  final String message;
  RegisterError(this.message);
}

class Registered extends RegisterState {}
