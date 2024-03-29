import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WrapperAuthScreen extends StatelessWidget {
  const WrapperAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: Text(
                      'SurfTogether',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          fontSize: 42),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      context.push('/login');
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        color: Colors.blue,
                      ),
                      height: 60,
                      width: 250,
                      child: const Center(
                          child: Text('Войти',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.w400,
                              ))),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      context.push('/register');
                    },
                    child: Container(
                      child: const Center(
                          child: Text('Зарегистрироваться',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.w300,
                              ))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
