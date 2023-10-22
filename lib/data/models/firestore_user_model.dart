import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class FirestoreUserModel extends Equatable {
  final String? idUser;
  final String? email;
  final String? name;
  final String? imageUrl;
  final String? role;
  const FirestoreUserModel({this.idUser, this.email, this.name, this.imageUrl, this.role});

  static FirestoreUserModel fromJson(DocumentSnapshot snapshot) {
    FirestoreUserModel firestoreUser = FirestoreUserModel(
        idUser: snapshot['idUser'],
        email: snapshot['email'],
        name: snapshot['name'],
        imageUrl: snapshot['imageUrl'], role: snapshot['role']);
    return firestoreUser;
  }

  Map<String, Object?> toMap() {
    return {
      'idUser': idUser,
      'email': email,
      'name': name,
      'imageUrl': imageUrl,
      'role': role
    };
  }

  @override
  List<Object?> get props => [idUser, email, name, imageUrl, role];
}
