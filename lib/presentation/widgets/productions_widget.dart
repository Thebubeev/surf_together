import 'package:flutter/material.dart';
import 'package:surf_together/data/models/place_model.dart';
import 'package:surf_together/domain/repositories/interfaces/sqflite_places_dao_repository.dart';
import 'package:surf_together/domain/repositories/sqflite_places_dao_repository_impl.dart';
import 'package:surf_together/presentation/widgets/widgets.dart';

class ListProductionsWidgets extends StatefulWidget {
  const ListProductionsWidgets({Key? key}) : super(key: key);

  @override
  State<ListProductionsWidgets> createState() => _ListProductionsWidgetsState();
}

class _ListProductionsWidgetsState extends State<ListProductionsWidgets> {
  List<PlaceModel> places = [];
  SqflitePlacesDaoRepository sqflitePlacesDaoRepository =
      SqflitePlacesDaoRepositoryImpl();

  @override
  initState() {
    getPlaces();
    super.initState();
  }

  getPlaces() async {
    final addedPlaces = await sqflitePlacesDaoRepository.getPlacesDao();
    setState(() {
      places = addedPlaces;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
            child: albomCard(places[index].imageUrl, places[index].name,
                places[index].city));
      }, childCount: places.length),
    );
  }
}
