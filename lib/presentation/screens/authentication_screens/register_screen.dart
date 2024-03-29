import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_together/domain/repositories/firebase_repository_impl.dart';
import 'package:surf_together/domain/repositories/interfaces/firestore_repository.dart';
import 'package:surf_together/presentation/bloc/auth/auth_bloc.dart';
import 'package:surf_together/presentation/widgets/loader_widget.dart';
import 'package:surf_together/presentation/widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  FirebaseRepository firebaseRepository = FirebaseRepositoryImpl();
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  String? _warning;
  bool _isLoading = false;

  @override
  void dispose() {
    if (!mounted) return;
    _emailController.dispose();
    _passController.dispose();

    _nameController.dispose();
    _confirmPassController.dispose();
    _warning = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthBlocState>(
      listener: (context, state) async {
        if (state is AuthRegisterToastState) {
          setState(() {
            _isLoading = false;
            _warning = 'Пожалуйста, подтвердите вашу почту.';
          });
          await firebaseRepository.sendVerificationEmail();
        }

        if (state is AuthRegisterErrorState) {
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
                            'Регистрация',
                            style: TextStyle(
                                fontSize: 45,
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormEmailField(emailController: _emailController),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormNameField(nameController: _nameController),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormPassField(
                            passController: _passController,
                            isRegister: true,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormConfirmPassField(
                              passController: _passController,
                              confirmPassController: _confirmPassController),
                          const SizedBox(
                            height: 45,
                          ),
                          enterButton(
                            _formKey,
                            _submitForm,
                            'Зарегистрироваться',
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
    BlocProvider.of<AuthBloc>(context).add(AuthRegisterEvent(
        login: _emailController.text.trim(),
        password: _passController.text.trim(),
        name: _nameController.text.trim(),
        role: ''));
  }
}
