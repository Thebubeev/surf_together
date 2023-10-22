import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:surf_together/presentation/screens/interaction_screens/widgets/back_navigate_widget.dart';
import 'package:surf_together/presentation/screens/interaction_screens/widgets/text_title_widget.dart';
import 'package:surf_together/presentation/widgets/widgets.dart';

class EmailScreen extends StatelessWidget {
  final String name;
  const EmailScreen({Key? key,required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextTitleWidget(title: 'Напиши свою почту.'),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: TextFormEmailField(emailController: _emailController),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BackNavigateWidget(),
            ElevatedButton(
                onPressed: () {
                  context.goNamed('/password', pathParameters: {
                    'name': name, 
                    'email':_emailController.text
                  });
                },
                child: Center(
                  child: Text('Продолжить'),
                )),
          ],
        )
      ]),
    );
  }
}
