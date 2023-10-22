import 'package:cloud_firestore/cloud_firestore.dart';

class PlaceModel {
  String id;
  final String name;
  final String city;
  final String imageUrl;
  PlaceModel(
      {required this.id,
      required this.name,
      required this.city,
      required this.imageUrl});

  factory PlaceModel.fromJson(DocumentSnapshot json) {
    return PlaceModel(
        id: json['id'],
        name: json['name'],
        city: json['city'],
        imageUrl: json['imageUrl']);
  }
}
