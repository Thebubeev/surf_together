// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:equatable/equatable.dart';
// class FirestoreUserTempModel extends Equatable {
//   final String? idUser;
//    String? email;
//    String? name;
//   final String? imageUrl;
//   const FirestoreUserTempModel({ this.idUser, this.email, this.name,  this.imageUrl});

//   static FirestoreUserTempModel fromJson(DocumentSnapshot snapshot) {
//     FirestoreUserTempModel firestoreUser = FirestoreUserTempModel(
//       idUser: snapshot['idUser'],
//       email: snapshot['email'],
//       name: snapshot['name'],
//       imageUrl: snapshot['imageUrl']
//     );
//     return firestoreUser;
//   }

//   Map<String, Object?> toMap() {
//     return {'idUser': idUser, 'email': email, 'name': name, 'imageUrl': imageUrl};
//   }

//   @override
//   List<Object?> get props => [
//         idUser,
//         email,
//         name, imageUrl
//       ];
// }
