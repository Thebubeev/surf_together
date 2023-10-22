import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_together/domain/repositories/firebase_repository_impl.dart';
import 'package:surf_together/domain/repositories/interfaces/firestore_repository.dart';
import 'package:surf_together/domain/repositories/interfaces/shared_preferences_repository.dart';
import 'package:surf_together/domain/repositories/shared_preferences_repository_impl.dart';
import 'package:surf_together/presentation/bloc/profile/profile_bloc.dart';
import 'package:surf_together/presentation/widgets/loader_widget.dart';
import 'package:surf_together/presentation/widgets/widgets.dart';
import 'package:surf_together/utils/constants/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  SharedPreferencesRepository sharedPreferencesRepository =
      SharedPreferenceRepositoryImpl();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  bool isLoading = false;
  late String email;
  late String name;
  late String imageUrl;
  late String city;
  late String phone ;

  @override
  void initState() {
    checkFields();
    super.initState();
  }

  checkFields() async {
    setState(() {
      isLoading = true;
    });
    final user = await sharedPreferencesRepository.getTempData();
    setState(() {
      isLoading = false;
      email = user.email!;
      name = user.name!;
      imageUrl = user.imageUrl!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileBlocState>(
      listener: (context, state) {
        if (state is ProfileFetchedImageState) {
          setState(() {
            imageUrl = state.imageUrl;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                BlocProvider.of<ProfileBloc>(context)
                    .add(ProfileFetchImageEvent());
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.black,
              ),
            ),
          ],
          title: titleText
        ),
        body: isLoading
            ? LoaderWidget()
            : Padding(
                padding: const EdgeInsets.only(left: 30, right: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Container(
                                  width: 80,
                                  height: 80,
                                  child: CachedNetworkImage(
                                    placeholder: (context, _) =>
                                        CircularProgressIndicator(),
                                    imageUrl: imageUrl,
                                  ))),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: Constants.defaultTextTitleStyle,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Какое то приветствие...',
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      discriptionCard(Icons.home, 'Город', city, context),
                      SizedBox(
                        height: 5,
                      ),
                      discriptionCard(Icons.phone, 'Телефон', phone, context),
                      SizedBox(
                        height: 5,
                      ),
                      discriptionCard(
                          Icons.email_outlined, 'Email', email, context),
                    ]),
              ),
      ),
    );
  }
}
