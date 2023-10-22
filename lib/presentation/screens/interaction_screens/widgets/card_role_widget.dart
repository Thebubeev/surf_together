import 'package:flutter/material.dart';

class CardRoleWidget extends StatelessWidget {
  const CardRoleWidget({
    Key? key,
    required bool isSelected,
    required this.title,
    required this.icon,
  })  : _isSelected = isSelected,
        super(key: key);

  final bool _isSelected;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 2,
        child: Container(
          height: 90,
          width: 90,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: _isSelected ? Colors.white : Colors.green,
              ),
              Text(
                title,
                style: TextStyle(
                  color: _isSelected ? Colors.white : Colors.green,
                ),
              ),
            ],
          )),
          decoration: BoxDecoration(
              color: _isSelected == true ? Colors.green : Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: _isSelected == true ? Colors.green : Colors.white,
              )),
        ),
      ),
    );
  }
}
