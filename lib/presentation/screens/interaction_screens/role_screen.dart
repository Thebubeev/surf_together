import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:surf_together/presentation/screens/interaction_screens/widgets/back_navigate_widget.dart';
import 'package:surf_together/presentation/screens/interaction_screens/widgets/card_role_widget.dart';
import 'package:surf_together/presentation/screens/interaction_screens/widgets/text_title_widget.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({Key? key}) : super(key: key);

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  bool _isSurfSelected = false;
  bool _isHostSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextTitleWidget(title: 'Выбери свою роль, пожалуйста.'),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                _isHostSelected
                    ? null
                    : setState(() {
                        _isSurfSelected = !_isSurfSelected;
                      });
              },
              child: CardRoleWidget(
                isSelected: _isSurfSelected,
                title: 'Сёрфер',
                icon: Icons.person_2_sharp,
              ),
            ),
            GestureDetector(
              onTap: () {
                _isSurfSelected
                    ? null
                    : setState(() {
                        _isHostSelected = !_isHostSelected;
                      });
              },
              child: CardRoleWidget(
                isSelected: _isHostSelected,
                title: 'Хост',
                icon: Icons.home,
              ),
            ),
          ],
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
                  context.push('/wrapper');
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
