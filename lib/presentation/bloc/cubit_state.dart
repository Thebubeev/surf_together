part of 'cubit_bloc.dart';

abstract class CubitState extends Equatable {
  const CubitState();

  @override
  List<Object> get props => [];
}

class CubitInitial extends CubitState {}

class CubitNavigatorState extends CubitState {
  final String route;
  const CubitNavigatorState({required this.route});
}

class CubitLoginToastState extends CubitState {}

class CubitRegisterToastState extends CubitState {}

class CubitRecoveryPasswordState extends CubitState {}

class CubitLoginErrorState extends CubitState {
  final String warning;
  const CubitLoginErrorState({required this.warning});
}

class CubitRecoveryErrorState extends CubitState {
  final String warning;
  const CubitRecoveryErrorState({required this.warning});
}

class CubitRegisterErrorState extends CubitState {
  final String warning;
  const CubitRegisterErrorState({required this.warning});
}
