import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:surf_together/presentation/screens/interaction_screens/widgets/back_navigate_widget.dart';
import 'package:surf_together/presentation/screens/interaction_screens/widgets/text_title_widget.dart';
import 'package:surf_together/presentation/widgets/widgets.dart';

class PasswordScreen extends StatelessWidget {
  final String name;
  final String email;
  const PasswordScreen({Key? key, required this.name,required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _passController = TextEditingController();
    TextEditingController _confirmPassController = TextEditingController();
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextTitleWidget(title: 'Отлично.\nА что насчет пароля?'),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: TextFormPassField(
            passController: _passController,
            isRegister: true,
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: TextFormConfirmPassField(
            confirmPassController: _confirmPassController,
            passController: _passController,
          ),
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
                  context.push('/role');
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
