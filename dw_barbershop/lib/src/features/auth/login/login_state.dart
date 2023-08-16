import 'package:flutter/material.dart';

enum LoginStateStatus {
  initial,
  error,
  admLogin,
  employeeLogin,
}

class LoginState {
  final LoginStateStatus status;
  final String? errorMessage;

  LoginState.initial() : this(status: LoginStateStatus.initial);

  LoginState({
    required this.status,
    this.errorMessage,
  });

  LoginState copyWith({
    LoginStateStatus? status,
    // o padrão é manter a string,
    // mas mudando ele, podemos voltar esse estado para nulo
    ValueGetter<String>? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage:
              // se for nulo, mantem, se nao recebe novo valor
        errorMessage != null ? errorMessage() : this.errorMessage);
  }
}
