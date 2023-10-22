import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:surf_together/utils/constants/constants.dart';

void _fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

bool _isPasswordVisible = false;

class TextFormEmailField extends StatefulWidget {
  final TextEditingController emailController;
  const TextFormEmailField({Key? key, required this.emailController})
      : super(key: key);

  @override
  State<TextFormEmailField> createState() => _TextFormEmailFieldState();
}

class _TextFormEmailFieldState extends State<TextFormEmailField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: const TextStyle(color: Colors.white, fontFamily: 'Gilroy'),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10)),
      ),
      controller: widget.emailController,
      validator: (val) {
        if (val!.isEmpty || val == '') {
          return 'Введите почту';
        } else if (val.contains('@') == false || (val.contains('.') == false)) {
          return 'Введите настоящую почту!';
        } else {
          return null;
        }
      },
      onSaved: (val) {
        setState(() {
          widget.emailController.text = val as String;
        });
      },
    );
  }
}

class TextFormNameField extends StatefulWidget {
  final TextEditingController nameController;
  const TextFormNameField({Key? key, required this.nameController})
      : super(key: key);

  @override
  State<TextFormNameField> createState() => _TextFormNameFieldState();
}

class _TextFormNameFieldState extends State<TextFormNameField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: 'Ваше имя',
        labelStyle: const TextStyle(color: Colors.black, fontFamily: 'Gilroy'),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 0.7)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 0.7),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 0.7),
            borderRadius: BorderRadius.circular(10)),
      ),
      controller: widget.nameController,
      validator: (val) {
        if (val!.isEmpty || val == '') {
          return 'Введите ФИО';
        } else {
          return null;
        }
      },
      onSaved: (val) {
        setState(() {
          widget.nameController.text = val as String;
        });
      },
    );
  }
}

class TextFormRoleField extends StatefulWidget {
  const TextFormRoleField({
    Key? key,
  }) : super(key: key);

  @override
  State<TextFormRoleField> createState() => _TextFormRoleFieldState();
}

const List<String> list = <String>['Сёрфер', 'Хост'];

class _TextFormRoleFieldState extends State<TextFormRoleField> {
  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(
          Icons.arrow_downward,
          color: Colors.white,
        ),
        elevation: 16,
        style: const TextStyle(color: Colors.green),
        underline: Container(
          height: 2,
          color: Colors.green,
        ),
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value!;
          });
        },
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class TextFormPassField extends StatefulWidget {
  final TextEditingController passController;
  final bool isRegister;
  const TextFormPassField(
      {Key? key, required this.passController, required this.isRegister})
      : super(key: key);

  @override
  State<TextFormPassField> createState() => _TextFormPassFieldState();
}

class _TextFormPassFieldState extends State<TextFormPassField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
          labelText: 'Пароль',
          labelStyle:
              const TextStyle(color: Colors.black, fontFamily: 'Gilroy'),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 0.7)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 0.7),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 0.7),
              borderRadius: BorderRadius.circular(10)),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
            icon: Icon(
              _isPasswordVisible == true
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: Colors.black,
            ),
          )),
      controller: widget.passController,
      validator: widget.isRegister
          ? (val) {
              if (val!.isEmpty || val == '') {
                return 'Введите пароль';
              } else if (val.length < 6) {
                return 'Пароль должен быть больше 6 символов';
              } else {
                return null;
              }
            }
          : (val) {
              if (val!.isEmpty || val == '') {
                return 'Введите пароль';
              } else {
                return null;
              }
            },
      obscureText: _isPasswordVisible ? false : true,
      onSaved: (val) {
        setState(() {
          widget.passController.text = val as String;
        });
      },
    );
  }
}

class TextFormConfirmPassField extends StatefulWidget {
  final TextEditingController passController, confirmPassController;
  const TextFormConfirmPassField(
      {Key? key,
      required this.passController,
      required this.confirmPassController})
      : super(key: key);

  @override
  State<TextFormConfirmPassField> createState() =>
      _TextFormConfirmPassFieldState();
}

class _TextFormConfirmPassFieldState extends State<TextFormConfirmPassField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
          labelText: 'Подтвердите пароль',
          labelStyle:
              const TextStyle(color: Colors.black, fontFamily: 'Gilroy'),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 0.7)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 0.7),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 0.7),
              borderRadius: BorderRadius.circular(10)),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
            icon: Icon(
              _isPasswordVisible == true
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: Colors.black,
            ),
          )),
      controller: widget.confirmPassController,
      validator: (val) {
        if (val!.isEmpty || val == '') {
          return 'Введите пароль';
        } else if (val.length < 6) {
          return 'Пароль должен быть больше 6 символов';
        } else if (val.trim() != widget.passController.text.trim()) {
          return "Пароли должны быть одинаковыми";
        } else {
          return null;
        }
      },
      obscureText: _isPasswordVisible ? false : true,
      onSaved: (val) {
        setState(() {
          widget.passController.text = val as String;
        });
      },
    );
  }
}

class ShowAlert extends StatefulWidget {
  String? warning;
  Function? function;
  ShowAlert({Key? key, this.warning, this.function}) : super(key: key);

  @override
  State<ShowAlert> createState() => _ShowAlertState();
}

class _ShowAlertState extends State<ShowAlert> {
  @override
  Widget build(BuildContext context) {
    if (widget.warning != null) {
      return Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            const Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Icon(Icons.error_outline, color: Colors.black)),
            Expanded(
              child: Text(
                widget.warning!,
                style: const TextStyle(
                    fontSize: 18, fontFamily: 'Gilroy', color: Colors.black),
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
                onPressed: () {
                  widget.function!();
                },
              ),
            )
          ],
        ),
      );
    }
    return const SizedBox(height: 0);
  }
}

Widget iconBackButton(BuildContext context) => IconButton(
    padding: const EdgeInsets.only(top: 15, bottom: 15),
    alignment: Alignment.topLeft,
    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
    iconSize: 35,
    onPressed: () {
      context.pop();
    });

Widget enterButton(
  GlobalKey<FormState> _formKey,
  Function _submitForm,
  String text,
) =>
    GestureDetector(
        onTap: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            _submitForm();
          }
        },
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              color: Colors.green),
          height: 70,
          width: 300,
          child: Center(
              child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontFamily: 'Gilroy', fontSize: 17),
          )),
        ));

Widget discriptionCard(
    IconData icon, String text, String title, BuildContext context) {
  return Row(
    children: [
      Icon(
        icon,
        size: 20,
        color: Colors.grey,
      ),
      const SizedBox(
        width: 6,
      ),
      Text('$text: ' + title, style: Constants.defaultTextTitleStyle),
    ],
  );
}

Padding coloredCard() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Row(
      children: [
        cardWidget(
            'assets/images/Users.svg',
            const Color.fromARGB(255, 52, 101, 195),
            const Color.fromARGB(255, 87, 133, 222),
            'Мои сети\n',
            'Подключайтесь и расширяйте свою сеть'),
        cardWidget(
            'assets/images/Vector.svg',
            const Color.fromARGB(255, 236, 78, 39),
            const Color.fromARGB(255, 244, 126, 97),
            'Поиск жилья',
            'Найдите жилье себе быстро и удобно'),
        cardWidget(
            'assets/images/Subtract.svg',
            const Color.fromARGB(255, 107, 52, 195),
            const Color.fromARGB(255, 142, 94, 219),
            'Мой профиль',
            'Обновляйте свой, чтобы быть в топе'),
      ],
    ),
  );
}

Widget albomCard(String imageUrl, String title, String subtitle) {
  return GestureDetector(
    onTap: () {},
    child: Card(
      color: const Color.fromARGB(255, 240, 242, 245),
      elevation: 0,
      child: Stack(
        children: [
          Row(children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: 70,
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                bottom: 10,
                top: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 13),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 101, 101, 101)),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
          ])
        ],
      ),
    ),
  );
}

Expanded cardWidget(String imageUrl, Color color1, Color color2, String title,
    String subtitle) {
  return Expanded(
    child: SizedBox(
      height: 160,
      child: Card(
        child: InkWell(
          onTap: () {
            debugPrint('go to page');
          },
          child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color1, color2],
              )),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        imageUrl,
                        width: 35,
                        height: 35,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(subtitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          )),
                    ]),
              )),
        ),
      ),
    ),
  );
}
