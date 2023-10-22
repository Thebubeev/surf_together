import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:surf_together/domain/repositories/firebase_repository_impl.dart';
import 'package:surf_together/domain/repositories/interfaces/firestore_repository.dart';
import 'package:surf_together/domain/repositories/interfaces/shared_preferences_repository.dart';
import 'package:surf_together/domain/repositories/shared_preferences_repository_impl.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final _firebaseAuth = FirebaseAuth.instance;
  FirebaseRepository firebaseRepository = FirebaseRepositoryImpl();
  SharedPreferencesRepository sharedPreferencesRepository =
      SharedPreferenceRepositoryImpl();

  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginWithGoogleEvent>((event, emit) async {
      try {
        await firebaseRepository.signInWithGoogle().then((value) {
          if (value.idUser != null) {
            emit(const AuthNavigatorState(route: '/home'));
          }
        });
      } catch (e) {
        print(e.toString());
        emit(const AuthLoginErrorState(warning: 'Что-то прошло не так...'));
      }
    });
    on<AuthForgotPasswordEvent>((event, emit) async {
      try {
        await firebaseRepository.resetPasswordUsingEmail(event.login);
        emit(AuthRecoveryPasswordState());
      } catch (error) {
        String _warning = 'Что-то прошло не так...';
        switch (error.toString()) {
          case "[firebase_auth/invalid-email] The email address is badly formatted.":
            _warning = "Ваша почта недоступна.";
            break;
          case "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.":
            _warning = "Такого пользователя не существует!";
            break;
          case "[firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later.":
            _warning = "Слишком много запросов. Попробуйте позже.";
            break;
          case "[firebase_auth/unknown] Given String is empty or null":
            _warning = '[firebase_auth/unknown] Given String is empty or null';
            break;
        }
        print(error);
        emit(AuthRecoveryErrorState(warning: _warning));
      }
    });
    on<AuthRegisterEvent>((event, emit) async {
      try {
        await firebaseRepository.createUserWithEmailAndPassword(
            event.login.trim(), event.password.trim(), event.name.trim());
        emit(AuthRegisterToastState());
      } catch (error) {
        String _warning = 'Что-то прошло не так...';
        switch (error.toString()) {
          case "[firebase_auth/invalid-email] The email address is badly formatted.":
            _warning = "Ваша почта недоступна.";

            break;
          case "[firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later.":
            _warning = "Слишком много запросов. Попробуйте позже.";

            break;
          case "[firebase_auth/email-already-in-use] The email address is already in use by another account.":
            _warning = "Данная почта уже зарегистрирована.";

            break;
          case "[firebase_auth/unknown] Given String is empty or null":
            _warning = '[firebase_auth/unknown] Given String is empty or null';

            break;
        }
        print(error);
        emit(AuthRegisterErrorState(warning: _warning));
      }
    });
    on<AuthLoginEvent>((event, emit) async {
      try {
        await firebaseRepository
            .signInWithEmailAndPassword(
                event.login.trim(), event.password.trim())
            .then((_) async => _firebaseAuth.currentUser!.emailVerified
                ? {
                    sharedPreferencesRepository
                        .setUserDocId(_firebaseAuth.currentUser!.email!),
                    sharedPreferencesRepository
                        .setTempData(_firebaseAuth.currentUser!.email!),
                    emit(const AuthNavigatorState(route: '/home'))
                  }
                : {emit(AuthLoginToastState())});
      } catch (error) {
        String _warning = 'Что-то прошло не так...';
        switch (error.toString()) {
          case "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.":
            _warning = "Такого пользователя не существует!";

            break;
          case "[firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later.":
            _warning = "Слишком много запросов. Попробуйте позже!";

            break;
          case "[firebase_auth/invalid-email] The email address is badly formatted.":
            _warning = _firebaseAuth.currentUser!.emailVerified
                ? "Почта недоступна."
                : 'Мы отправили письмо . Пожалуйста, подтвердите вашу почту.';

            _firebaseAuth.currentUser!.emailVerified
                ? null
                : await firebaseRepository.sendVerificationEmail();
            break;
          case "[firebase_auth/wrong-password] The password is invalid or the user does not have a password.":
            _warning = "Логин или пароль неверный.";

            break;
          case "[firebase_auth/unknown] Given String is empty or null":
            _warning = '[firebase_auth/unknown] Given String is empty or null';
            break;
        }
        print(error);
        emit(AuthLoginErrorState(warning: _warning));
      }
    });
  }
}
