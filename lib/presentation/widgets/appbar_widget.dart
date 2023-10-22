import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:surf_together/domain/repositories/firebase_repository_impl.dart';
import 'package:surf_together/domain/repositories/interfaces/shared_preferences_repository.dart';
import 'package:surf_together/domain/repositories/shared_preferences_repository_impl.dart';
import 'package:surf_together/presentation/screens/page_screens/saved_places_screen.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  AppBarWidget({
    Key? key,
  }) : super(key: key);

  final firebaseRepository = FirebaseRepositoryImpl();
  SharedPreferencesRepository sharedPreferenceRepository =
      SharedPreferenceRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return SavedPlacesScreen();
            }));
          },
          icon: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: const Center(
              child: Icon(
                Icons.favorite_border,
                color: Colors.black,
              ),
            ),
          )),
      centerTitle: true,
      title: const Text(
        'SurfTogether',
        style: TextStyle(
            color: Colors.black, fontSize: 19, fontWeight: FontWeight.w400),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            await firebaseRepository.signOut();
            await sharedPreferenceRepository.deleteUserDocId();
            context.push('/wrapper_auth');
          },
          icon: const Icon(
            Icons.exit_to_app_outlined,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
