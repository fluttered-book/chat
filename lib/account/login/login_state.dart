import 'package:flutter/foundation.dart';

@immutable
abstract class LoginState {}

class LoginReady extends LoginState {}

class LoginLoading extends LoginState {}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}

class LoggedIn extends LoginState {}
