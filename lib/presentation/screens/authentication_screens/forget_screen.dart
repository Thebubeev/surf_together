import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_together/presentation/bloc/auth/auth_bloc.dart';
import 'package:surf_together/presentation/widgets/loader_widget.dart';
import 'package:surf_together/presentation/widgets/widgets.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({Key? key}) : super(key: key);
  @override
  _ForgetScreenState createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final _emailController = TextEditingController();

  String? _warning;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    if (!mounted) return;
    _emailController.dispose();
    _warning = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthBlocState>(
      listener: (context, state) async {
        if (state is AuthRecoveryPasswordState) {
          setState(() {
            _isLoading = false;
            _warning = 'Отправили ссылку на вашу почту';
            _emailController.text = '';
          });
        }

        if (state is AuthRecoveryErrorState) {
          if (state.warning ==
              '[firebase_auth/unknown] Given String is empty or null') {
            setState(() {
              _isLoading = false;
            });
          } else {
            setState(() {
              _isLoading = false;
              _warning = state.warning;
            });
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: _isLoading
            ? const LoaderWidget()
            : GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/background.jpg"),
                        fit: BoxFit.cover),
                  ),
                  child: Form(
                    key: _formKey,
                    child: SafeArea(
                      child: ListView(
                          padding: const EdgeInsets.all(30),
                          children: [
                            iconBackButton(context),
                            ShowAlert(
                              warning: _warning,
                              function: () {
                                setState(() {
                                  _warning = null;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const Text(
                              'Восстановить пароль',
                              style:
                                  TextStyle(fontSize: 39, color: Colors.white),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: Column(
                                children: <Widget>[
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  TextFormEmailField(
                                    emailController: _emailController,
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  enterButton(
                                    _formKey,
                                    _submitForm,
                                    'Восстановить пароль',
                                  )
                                ],
                              ),
                            )
                          ]),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  void _submitForm() async {
    setState(() {
      _isLoading = true;
    });
    BlocProvider.of<AuthBloc>(context).add(AuthForgotPasswordEvent(
      login: _emailController.text.trim(),
    ));
  }
}
