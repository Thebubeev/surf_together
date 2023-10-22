import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Constants {
  static const defaultTextTitleStyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 17);

  static const defaultBigTextStyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 25);

  static const defaultThinBigTextStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 25);

  static const defaultTextBlackStyle = TextStyle(
    fontSize: 17,
    color: Colors.black,
    fontWeight: FontWeight.w300,
  );

  static const defaultButtonWhiteStyle = TextStyle(
    fontSize: 20,
    color: Colors.white,
    fontWeight: FontWeight.w300,
  );

  static const defaultButtonBlackStyle = TextStyle(
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.w300,
  );

  static const defaultProfileImageUrl =
      'https://t4.ftcdn.net/jpg/02/15/84/43/360_F_215844325_ttX9YiIIyeaR7Ne6EaLLjMAmy4GvPC69.jpg';

  static String email = FirebaseAuth.instance.currentUser!.email!;
}

const titleText = Text(
  'SurfTogether',
  style:
      TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.w400),
);
