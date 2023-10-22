import 'package:surf_together/data/models/dao/places_dao.dart';
import 'package:surf_together/data/models/place_model.dart';
import 'package:surf_together/domain/repositories/interfaces/sqflite_places_dao_repository.dart';
import 'package:surf_together/presentation/providers/database_provider.dart';

class SqflitePlacesDaoRepositoryImpl implements SqflitePlacesDaoRepository {
  final dao = PlacesDao();

  DatabaseProvider databaseProvider = DatabaseProvider.staticDataBase;

  @override
  Future<PlaceModel> insert(PlaceModel place) async {
    final db = await databaseProvider.db();
    place.id = (await db.insert(dao.tableName, dao.toMap(place))).toString();
    return place;
  }

  @override
  Future<PlaceModel> delete(PlaceModel place) async {
    final db = await databaseProvider.db();
    await db.delete(dao.tableName,
        where: dao.columnId + " = ?", whereArgs: [place.id]);
    return place;
  }

  @override
  Future<PlaceModel> update(PlaceModel place) async {
    final db = await databaseProvider.db();
    await db.update(dao.tableName, dao.toMap(place),
        where: dao.columnId + " = ?", whereArgs: [place.id]);
    return place;
  }

  @override
  Future<List<PlaceModel>> getPlacesDao() async {
    final db = await databaseProvider.db();
    List<Map<String, dynamic>> maps = await db.query(dao.tableName);
    return dao.fromList(maps);
  }
}
