import 'package:surf_together/data/models/place_model.dart';

abstract class SqflitePlacesDaoRepository {
  Future<PlaceModel> insert(PlaceModel place);

  Future<PlaceModel> delete(PlaceModel place);

  Future<PlaceModel> update(PlaceModel place);

  Future<List<PlaceModel>> getPlacesDao();
}
