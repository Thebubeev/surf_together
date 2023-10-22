import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:surf_together/data/models/firestore_user_model.dart';
import 'package:surf_together/data/models/place_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:surf_together/domain/repositories/interfaces/firestore_repository.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  FirestoreUserModel _userFromFirebase(User? user) {
    if (user == null) {
      print('There is no users with uid');
      return const FirestoreUserModel();
    } else {
      return FirestoreUserModel(
          idUser: user.uid,
          name: user.displayName,
          email: user.email,
          imageUrl: user.photoURL);
    }
  }

  @override
  Future<void> sendVerificationEmail() async {
    final user = _firebaseAuth.currentUser;
    await user!.sendEmailVerification();
  }

  @override
  Stream<FirestoreUserModel> get authStateChanges {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  @override
  Future<FirestoreUserModel> currentUser() async {
    final user = _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }

  @override
  Future<FirestoreUserModel> signInWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<FirestoreUserModel> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    await _firebaseAuth.currentUser!.reload();
    final newUser = FirestoreUserModel(
        idUser: _firebaseAuth.currentUser!.uid,
        email: _firebaseAuth.currentUser!.email!,
        name: name,
        imageUrl:
            'https://t4.ftcdn.net/jpg/02/15/84/43/360_F_215844325_ttX9YiIIyeaR7Ne6EaLLjMAmy4GvPC69.jpg');
    await users.add(newUser.toMap());
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<void> resetPasswordUsingEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> loadImage(XFile image) async {
    await storage.ref('images/${image.name}').putFile(File(image.path));
  }

  @override
  Future<String> getDownloadLinkUrl(String imageName) async {
    String downloadUrl =
        await storage.ref('images/$imageName').getDownloadURL();
    return downloadUrl;
  }

  @override
  Stream<List<PlaceModel>> getAllPlace() {
    return FirebaseFirestore.instance.collection('places').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => PlaceModel.fromJson(doc)).toList());
  }

  @override
  Future<FirestoreUserModel> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);

    // await users
    //     .where('email', isEqualTo: authResult.user!.email)
    //     .limit(1)
    //     .get()
    //     .then((snapshot) async {
    //   if (snapshot.docs.isNotEmpty) {
    //     chatDocId = snapshot.docs.single.id;
    //     print('-------chatDocId google: $chatDocId');
    //   } else {
    //     await _firebaseAuth.currentUser!.reload();
    //     final newUser = FirestoreUserModel(
    //       idUser: _firebaseAuth.currentUser!.uid,
    //       email: _firebaseAuth.currentUser!.email!,
    //       name: _firebaseAuth.currentUser!.displayName,
    //     );
    //     await users.add(newUser.toMap()).then((value) {
    //       chatDocId = value;
    //     });
    //   }
    // }).catchError((error) {
    //   print(error);
    // });
    return _userFromFirebase(authResult.user);
  }
}
