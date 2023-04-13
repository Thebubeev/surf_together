import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_task/domain/services/firebase_messaging_services.dart';
import 'package:test_task/presentation/widgets/albom_card_widget.dart';
import 'package:test_task/presentation/widgets/appbar_widget.dart';
import 'package:test_task/presentation/widgets/loader_widget.dart';
import 'package:test_task/utils/constants/constants.dart';
import 'package:test_task/data/models/place_model.dart';
import 'package:test_task/domain/repositories/firestore_repository/firestore_repository_impl.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final _firebaseAuth = FirebaseAuth.instance;

  String textController = '';

  final firebaseRepository = FirebaseRepositoryImpl();
  final firebaseMessagingServices = FirebaseMessagingServices();

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String name = '';

  @override
  void initState() {
    init();
    firebaseMessagingServices.listenFirebaseMessaging();
    super.initState();
  }

  init() async {
    await users
        .where('email', isEqualTo: _firebaseAuth.currentUser!.email)
        .limit(1)
        .get()
        .then((snapshot) async {
      if (snapshot.docs.isNotEmpty) {
        setState(() {
          name = snapshot.docs.single.get('name');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBarWidget(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'Привет, $name',
                      style: Constants.defaultTextStyle,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 20),
                    child: Text(
                      'Давай выберем маршрут путешествия',
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
                        hintText: 'Поиск маршрута',
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                  StreamBuilder<List<PlaceModel>>(
                      stream: firebaseRepository.getAllPlace(),
                      builder: ((context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const LoaderWidget();
                        }
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Some error'),
                          );
                        }
                        if (snapshot.hasData) {
                          return SizedBox(
                            height: 500,
                            child: ListView.builder(
                                itemBuilder: ((context, index) {
                                  if (textController.isEmpty) {
                                    return AlbomCardWidget(
                                        url: snapshot.data![index].imageUrl,
                                        title: snapshot.data![index].name,
                                        subtitle: snapshot.data![index].city);
                                  }
                                  if (snapshot.data![index].name
                                      .toLowerCase()
                                      .startsWith(
                                          textController.toLowerCase())) {
                                    return AlbomCardWidget(
                                        url: snapshot.data![index].imageUrl,
                                        title: snapshot.data![index].name,
                                        subtitle: snapshot.data![index].city);
                                  }
                                  return Container();
                                }),
                                itemCount: snapshot.data?.length),
                          );
                        } else {
                          return Container();
                        }
                      }))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
