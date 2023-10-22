part of 'auth_bloc.dart';

abstract class AuthBlocEvent extends Equatable {
  const AuthBlocEvent();

  @override
  List<Object> get props => [];
}

class AuthLoginEvent extends AuthBlocEvent {
  final String login;
  final String password;
  const AuthLoginEvent({required this.login, required this.password});
}

class AuthRegisterEvent extends AuthBlocEvent {
  final String login;
  final String password;
  final String name;
  final String role;
  const AuthRegisterEvent(
      {required this.login, required this.password, required this.name, required this.role});
}

class AuthLoginWithGoogleEvent extends AuthBlocEvent {}

class AuthForgotPasswordEvent extends AuthBlocEvent {
  final String login;
  const AuthForgotPasswordEvent({required this.login});
}
