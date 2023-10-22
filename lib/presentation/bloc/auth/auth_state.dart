part of 'auth_bloc.dart';

abstract class AuthBlocState extends Equatable {
  const AuthBlocState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthBlocState {}

class AuthNavigatorState extends AuthBlocState {
  final String route;
  const AuthNavigatorState({required this.route});
}

class AuthLoginToastState extends AuthBlocState {}

class AuthRegisterToastState extends AuthBlocState {}

class AuthRecoveryPasswordState extends AuthBlocState {}

class AuthLoginErrorState extends AuthBlocState {
  final String warning;
  const AuthLoginErrorState({required this.warning});
}

class AuthRecoveryErrorState extends AuthBlocState {
  final String warning;
  const AuthRecoveryErrorState({required this.warning});
}

class AuthRegisterErrorState extends AuthBlocState {
  final String warning;
  const AuthRegisterErrorState({required this.warning});
}
