import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserField {
  static const String lastCreationTime = 'lastCreationTime';
}

class FirestoreUserModel extends Equatable {
  final String? idUser;
  final String? email;
  final String? name;
  const FirestoreUserModel(
      { this.idUser,  this.email,  this.name});

  static FirestoreUserModel fromJson(DocumentSnapshot snapshot) {
    FirestoreUserModel firestoreUser = FirestoreUserModel(
      idUser: snapshot['idUser'],
      email: snapshot['email'],
      name: snapshot['name'],
    );
    return firestoreUser;
  }

  Map<String, Object?> toMap() {
    return {'idUser': idUser, 'email': email, 'name': name!};
  }

  @override
  List<Object?> get props => [
        idUser,
        email,
      ];
}
