import 'package:surf_together/data/models/dao/abstract_dao.dart';
import 'package:surf_together/data/models/place_model.dart';

class PlacesDao implements Dao<PlaceModel> {
  final tableName = 'places';
  final columnId = 'id';
  final _columnName = 'name';
  final _columnCity = 'city';
  final _columnImageUrl = 'imageUrl';

  @override
  String get createTableQuery =>
      "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY,"
      " $_columnName TEXT,"
      " $_columnImageUrl TEXT,"
      " $_columnCity TEXT)";

  @override
  PlaceModel fromMap(Map<String, dynamic> query) {
    PlaceModel place = PlaceModel(
        id: query[columnId].toString(),
        name: query[_columnName],
        city: query[_columnCity],
        imageUrl: query[_columnImageUrl]);
    return place;
  }

  @override
  Map<String, dynamic> toMap(PlaceModel object) {
    return <String, dynamic>{
      _columnName: object.name,
      _columnCity: object.city,
      _columnImageUrl: object.imageUrl
    };
  }

  @override
  List<PlaceModel> fromList(List<Map<String, dynamic>> query) {
    List<PlaceModel> placesList = <PlaceModel>[];
    for (Map<String, dynamic> map in query) {
      placesList.add(fromMap(map));
    }
    return placesList;
  }
}
