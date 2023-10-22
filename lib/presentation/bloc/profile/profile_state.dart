part of 'profile_bloc.dart';

abstract class ProfileBlocState extends Equatable {
  const ProfileBlocState();

  @override
  List<Object> get props => [];
}

class ProfileBlocInitial extends ProfileBlocState {}

class ProfileLoadingState extends ProfileBlocState{}


class ProfileFetchedDataState extends ProfileBlocState {
  final String? imageUrl;
  ProfileFetchedDataState({required this.imageUrl});
}

class ProfileFetchedImageState extends ProfileBlocState {
  final String imageUrl;
  ProfileFetchedImageState({required this.imageUrl});
}
