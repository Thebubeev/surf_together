import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:surf_together/domain/repositories/firebase_repository_impl.dart';
import 'package:surf_together/domain/repositories/interfaces/firestore_repository.dart';
import 'package:surf_together/domain/repositories/interfaces/shared_preferences_repository.dart';
import 'package:surf_together/domain/repositories/shared_preferences_repository_impl.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileBlocEvent, ProfileBlocState> {
  FirebaseRepository firebaseRepository = FirebaseRepositoryImpl();
  SharedPreferencesRepository sharedPreferencesRepository =
      SharedPreferenceRepositoryImpl();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  dynamic userDocId;

  ProfileBloc() : super(ProfileBlocInitial()) {
    on<ProfileFetchImageEvent>((event, emit) async {
      ImagePicker imagePicker = ImagePicker();
      final XFile? xFile =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (xFile == null) {
        return null;
      } else {
        try {
          await firebaseRepository.loadImage(xFile);
          await sharedPreferencesRepository
              .setTempData(FirebaseAuth.instance.currentUser!.email!);
          final url = await firebaseRepository.getDownloadLinkUrl(xFile.name);
          userDocId = await sharedPreferencesRepository.getUserDocId();
          users.doc(userDocId).update({'imageUrl': url});
          emit(ProfileFetchedImageState(imageUrl: url));
        } catch (e) {
          print(e.toString());
        }
      }
    });
  }
}
