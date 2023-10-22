import 'package:flutter/material.dart';
import 'package:surf_together/utils/constants/constants.dart';

class TextTitleWidget extends StatelessWidget {
  final String title;
  const TextTitleWidget({
    Key? key,required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: Constants.defaultThinBigTextStyle,
      ),
    );
  }
}