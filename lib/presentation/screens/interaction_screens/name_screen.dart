import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:surf_together/presentation/screens/interaction_screens/widgets/back_navigate_widget.dart';
import 'package:surf_together/presentation/screens/interaction_screens/widgets/text_title_widget.dart';
import 'package:surf_together/presentation/widgets/widgets.dart';

class NameScreen extends StatelessWidget {
  const NameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextTitleWidget(
          title: 'Привет.\nДавай познакомимься.\nКак тебя зовут?',
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: TextFormNameField(nameController: _nameController),
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
                  context.goNamed('/email', extra: _nameController.text);
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
