import 'package:flutter/material.dart';
import 'package:surf_together/presentation/screens/interaction_screens/widgets/text_title_widget.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [TextTitleWidget(title: 'Подтвердите вашу почту.')]),
    );
  }
}
