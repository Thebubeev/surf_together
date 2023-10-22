import 'package:surf_together/data/models/firestore_user_model.dart';

abstract class SharedPreferencesRepository {
  Future<void> setUserDocId(String email);
  Future<void> setTempData(String email);
  Future<String?> getUserDocId();
  Future<FirestoreUserModel> getTempData();
  Future<bool> deleteUserDocId();
  Future<bool> deleteTempData();
}
