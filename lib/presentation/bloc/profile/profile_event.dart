part of 'profile_bloc.dart';

abstract class ProfileBlocEvent extends Equatable {
  const ProfileBlocEvent();

  @override
  List<Object> get props => [];
}

class ProfileFetchDataEvent extends ProfileBlocEvent{}

class ProfileFetchImageEvent extends ProfileBlocEvent {}
