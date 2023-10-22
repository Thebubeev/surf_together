import 'package:flutter/material.dart';

class BackNavigateWidget extends StatelessWidget {
  const BackNavigateWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.green,
        ),
        style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(0),
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.transparent)),
        onPressed: () {
          Navigator.pop(context);
        },
        label: Center(
          child: Text(
            'Назад',
            style: TextStyle(color: Colors.green),
          ),
        ));
  }
}
