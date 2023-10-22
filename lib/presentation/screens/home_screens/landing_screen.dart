import 'package:flutter/material.dart';
import 'package:surf_together/data/models/place_model.dart';
import 'package:surf_together/domain/repositories/firebase_repository_impl.dart';
import 'package:surf_together/domain/repositories/interfaces/firestore_repository.dart';
import 'package:surf_together/domain/repositories/interfaces/sqflite_places_dao_repository.dart';
import 'package:surf_together/domain/repositories/sqflite_places_dao_repository_impl.dart';
import 'package:surf_together/domain/services/firebase_messaging_services.dart';
import 'package:surf_together/presentation/widgets/card_widget.dart';
import 'package:surf_together/presentation/widgets/appbar_widget.dart';
import 'package:surf_together/presentation/widgets/loader_widget.dart';
import 'package:surf_together/utils/constants/constants.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  String textController = '';

  FirebaseRepository firebaseRepository = FirebaseRepositoryImpl();
  final firebaseMessagingServices = FirebaseMessagingServices();
  SqflitePlacesDaoRepository sqflitePlacesDaoRepository =
      SqflitePlacesDaoRepositoryImpl();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBarWidget(),
      body: StreamBuilder<List<PlaceModel>>(
          stream: firebaseRepository.getAllPlace(),
          builder: (context, snapshot) {
            final places = snapshot.data;
            if (snapshot.hasError) {
              return Center(
                child: Text('Что-то прошло не так...'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoaderWidget();
            }
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Text(
                              'Давай найдем твой ночлег',
                              style: Constants.defaultBigTextStyle,
                            ),
                          ),
                          TextFormField(
                            onChanged: (val) {
                              setState(() {
                                textController = val;
                              });
                            },
                            decoration: InputDecoration(
                                hintText: 'Поиск жилья',
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15))),
                          ),
                        ]),
                      ),
                      SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                        if (textController.isEmpty) {
                          return CardWidget(
                            placeModel: places![index],
                          );
                        }
                        if (places![index]
                            .name
                            .toLowerCase()
                            .startsWith(textController.toLowerCase())) {
                          return CardWidget(
                            placeModel: places[index],
                          );
                        }
                        return Container();
                      }, childCount: places?.length))
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
