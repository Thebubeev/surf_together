import 'package:flutter/material.dart';
import 'package:surf_together/data/models/place_model.dart';
import 'package:surf_together/domain/repositories/interfaces/sqflite_places_dao_repository.dart';
import 'package:surf_together/domain/repositories/sqflite_places_dao_repository_impl.dart';
import 'package:surf_together/presentation/widgets/appbar_widget.dart';
import 'package:surf_together/presentation/widgets/widgets.dart';

class SavedPlacesScreen extends StatefulWidget {
  const SavedPlacesScreen({Key? key}) : super(key: key);

  @override
  State<SavedPlacesScreen> createState() => _SavedPlacesScreenState();
}

class _SavedPlacesScreenState extends State<SavedPlacesScreen> {
  List<PlaceModel> places = [];
  SqflitePlacesDaoRepository sqflitePlacesDaoRepository =
      SqflitePlacesDaoRepositoryImpl();

  @override
  initState() {
    getPlaces();
    super.initState();
  }

  getPlaces() async {
    final updatedPlaces = await sqflitePlacesDaoRepository.getPlacesDao();
    setState(() {
      places = updatedPlaces;
    });
  }

  deletePlaces(PlaceModel place) async {
    await sqflitePlacesDaoRepository.delete(place);
    final updatedPlaces = await sqflitePlacesDaoRepository.getPlacesDao();
    setState(() {
      places = updatedPlaces;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'SurfTogether',
          style: TextStyle(
              color: Colors.black, fontSize: 19, fontWeight: FontWeight.w400),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemBuilder: ((context, index) {
            return Dismissible(
              background: Container(color: Colors.red),
              direction: DismissDirection.endToStart,
              confirmDismiss: (direction) async {
                return await showDialog(
                    context: context,
                    builder: (
                      context,
                    ) {
                      return AlertDialog(
                        title: const Text(
                          'Вы действительно хотите удалить?',
                          style: TextStyle(color: Colors.black),
                        ),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: [
                          TextButton(
                              onPressed: () async {
                                await deletePlaces(places[index]);
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Да',
                                style: TextStyle(color: Colors.black),
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Нет',
                                style: TextStyle(color: Colors.black),
                              )),
                        ],
                      );
                    });
              },
              key: ValueKey(places[index].name),
              child: albomCard(places[index].imageUrl, places[index].name,
                  places[index].city),
            );
          }),
          itemCount: places.length,
        ),
      ),
    );
  }
}
