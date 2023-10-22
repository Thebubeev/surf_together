import 'package:image_picker/image_picker.dart';
import 'package:surf_together/data/models/firestore_user_model.dart';
import 'package:surf_together/data/models/place_model.dart';

abstract class FirebaseRepository {
  Stream<FirestoreUserModel> get authStateChanges;
  Stream<List<PlaceModel>> getAllPlace();
  Future<FirestoreUserModel> currentUser();
  Future<FirestoreUserModel> signInWithEmailAndPassword(
      String email, String password);
  Future<FirestoreUserModel> createUserWithEmailAndPassword(
      String email, String password, String name,);
  Future<void> resetPasswordUsingEmail(String email);
  Future<void> signOut();
  Future<void> loadImage(XFile image);
  Future<String> getDownloadLinkUrl(String imageName);
  Future<FirestoreUserModel> signInWithGoogle();
  Future<void> sendVerificationEmail();
}
