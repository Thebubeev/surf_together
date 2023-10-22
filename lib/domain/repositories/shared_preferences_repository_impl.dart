import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_together/data/models/firestore_user_model.dart';
import 'package:surf_together/domain/repositories/interfaces/shared_preferences_repository.dart';

mixin ConstantsPrefs {
  static const String userDocId = 'userDocId';
  static const String imageUrl = 'imageUrl';
  static const String name = 'userName';
  static const String email = 'email';
  static const String city = 'city';
  static const String phone = 'phone';
}

class SharedPreferenceRepositoryImpl implements SharedPreferencesRepository {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  dynamic userDocId;

  @override
  Future<void> setUserDocId(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await users
        .where('email', isEqualTo: email)
        .limit(1)
        .get()
        .then((snapshot) async {
      if (snapshot.docs.isNotEmpty) {
        await prefs.setString(
            ConstantsPrefs.userDocId, snapshot.docs.single.id);
        userDocId = snapshot.docs.single.id;
        print('added userDocId to SharedPreferences: $userDocId');
      } else {
        return null;
      }
    });
  }

  @override
  Future<void> setTempData(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await users
        .where('email', isEqualTo: email)
        .limit(1)
        .get()
        .then((snapshot) async {
      if (snapshot.docs.isNotEmpty) {
        await prefs.setString(
            ConstantsPrefs.imageUrl, snapshot.docs.single.get('imageUrl'));
        await prefs.setString(
            ConstantsPrefs.name, snapshot.docs.single.get('name'));
        await prefs.setString(
            ConstantsPrefs.email, snapshot.docs.single.get('email'));
        await prefs.setString(
            ConstantsPrefs.city, snapshot.docs.single.get('phone'));
        await prefs.setString(
            ConstantsPrefs.phone, snapshot.docs.single.get('city'));
        print('added data to SharedPreferences');
      } else {
        return null;
      }
    });
  }

  @override
  Future<FirestoreUserModel> getTempData() async {
    final prefs = await SharedPreferences.getInstance();
    final imageUrl = prefs.getString(ConstantsPrefs.imageUrl);
    final name = prefs.getString(ConstantsPrefs.name);
    final email = prefs.getString(ConstantsPrefs.email);
    final city = prefs.getString(ConstantsPrefs.city);
    final phone = prefs.getString(ConstantsPrefs.phone);
    return FirestoreUserModel(email: email, name: name, imageUrl: imageUrl);
  }

  @override
  Future<String?> getUserDocId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(ConstantsPrefs.userDocId);
  }

  @override
  Future<bool> deleteUserDocId() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(ConstantsPrefs.userDocId);
  }

  @override
  Future<bool> deleteTempData() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      await prefs.remove(ConstantsPrefs.userDocId);
      await prefs.remove(ConstantsPrefs.email);
      await prefs.remove(ConstantsPrefs.name);
      await prefs.remove(ConstantsPrefs.imageUrl);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
