import 'package:cloud_firestore/cloud_firestore.dart';

class PlaceModel {
  final String name;
  final String city;
  final String imageUrl;
  PlaceModel({required this.name, required this.city, required this.imageUrl});

  factory PlaceModel.fromJson(DocumentSnapshot json) {
    return PlaceModel(
        name: json['name'], city: json['city'], imageUrl: json['imageUrl']);
  }
}
