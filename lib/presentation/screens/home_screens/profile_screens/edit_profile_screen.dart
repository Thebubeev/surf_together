import 'package:flutter/material.dart';
import 'package:surf_together/data/models/firestore_user_model.dart';
import 'package:surf_together/utils/constants/constants.dart';

class EditProfileScreen extends StatelessWidget {
  final FirestoreUserModel user;
  const EditProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: titleText,
      ),
    );
  }
}
