import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:surf_together/domain/repositories/firebase_repository_impl.dart';
import 'package:surf_together/domain/repositories/interfaces/firestore_repository.dart';
import 'package:surf_together/domain/repositories/interfaces/shared_preferences_repository.dart';
import 'package:surf_together/domain/repositories/shared_preferences_repository_impl.dart';
import 'package:surf_together/presentation/bloc/auth/auth_bloc.dart';
import 'package:surf_together/presentation/screens/wrapper_screen.dart';
import 'package:surf_together/presentation/widgets/loader_widget.dart';
import 'package:surf_together/presentation/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseRepository firebaseRepository = FirebaseRepositoryImpl();
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  String? _warning;
  bool _isLoading = false;

  

  @override
  void dispose() {
    if (!mounted) return;
    _emailController.dispose();
    _passController.dispose();
    _warning = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthBlocState>(
      listener: (context, state) async {
        if (state is AuthNavigatorState) {
          setState(() {
            _isLoading = false;
          });

          Navigator.push(
              context, MaterialPageRoute(builder: (_) => WrapperScreen()));
        }

        if (state is AuthLoginToastState) {
          setState(() {
            _isLoading = false;
            _warning = 'Пожалуйста, подтвердите вашу почту.';
          });
          try {
            await firebaseRepository.sendVerificationEmail();
          } catch (e) {
            print(e);
          }
        }

        if (state is AuthLoginErrorState) {
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
                            'Войти',
                            style: TextStyle(
                                fontSize: 70,
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          TextFormEmailField(emailController: _emailController),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormPassField(
                            passController: _passController,
                            isRegister: false,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          enterButton(
                            _formKey,
                            _submitForm,
                            'Войти',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isLoading = true;
                                });
                                BlocProvider.of<AuthBloc>(context)
                                    .add(AuthLoginWithGoogleEvent());
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0),
                                    ),
                                    color: Colors.white),
                                height: 70,
                                width: 300,
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      const Text(
                                        'Войти с помощью Google',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Gilroy',
                                            fontSize: 17),
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Image.asset(
                                        'assets/google.png',
                                        fit: BoxFit.cover,
                                        height: 25,
                                        width: 25,
                                      )
                                    ],
                                  ),
                                )),
                              )),
                          TextButton(
                              onPressed: () {
                                context.push('/forget');
                              },
                              child: const Text(
                                'Восстановить пароль',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  void _submitForm() async {
    setState(() => _isLoading = true);
    BlocProvider.of<AuthBloc>(context).add(AuthLoginEvent(
        login: _emailController.text.trim(),
        password: _passController.text.trim()));
  }
}
