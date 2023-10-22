import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:go_router/go_router.dart';
import 'package:surf_together/presentation/screens/authentication_screens/wrapper_auth_screen.dart';
import 'package:surf_together/presentation/screens/interaction_screens/widgets/text_title_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextTitleWidget(
                title:
                    'Находите друзей, компаньонов, путешественников и обмениватесь с ними опытом c SurfTogether'),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue)),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => WrapperAuthScreen()));
                },
                child: Text('Начать'))
          ],
        ));
  }
}
