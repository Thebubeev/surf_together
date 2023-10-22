import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:surf_together/data/models/firestore_user_model.dart';
import 'package:surf_together/data/models/place_model.dart';
import 'package:surf_together/presentation/screens/authentication_screens/forget_screen.dart';
import 'package:surf_together/presentation/screens/authentication_screens/login_screen.dart';
import 'package:surf_together/presentation/screens/authentication_screens/wrapper_auth_screen.dart';
import 'package:surf_together/presentation/screens/home_screens/book_screen.dart';
import 'package:surf_together/presentation/screens/home_screens/landing_screen.dart';
import 'package:surf_together/presentation/screens/home_screens/profile_screens/edit_profile_screen.dart';
import 'package:surf_together/presentation/screens/home_screens/profile_screens/profile_screen.dart';
import 'package:surf_together/presentation/screens/interaction_screens/email_screen.dart';
import 'package:surf_together/presentation/screens/interaction_screens/name_screen.dart';
import 'package:surf_together/presentation/screens/interaction_screens/password_screen.dart';
import 'package:surf_together/presentation/screens/interaction_screens/role_screen.dart';
import 'package:surf_together/presentation/screens/interaction_screens/verification_screen.dart';
import 'package:surf_together/presentation/screens/interaction_screens/welcome_screen.dart';
import 'package:surf_together/presentation/screens/page_screens/page_screen/page_screen.dart';
import 'package:surf_together/presentation/screens/wrapper_screen.dart';

class RouteScreens {
  static final router = GoRouter(routes: [
    GoRoute(
        path: '/',
        builder: (context, state) => FirebaseAuth.instance.currentUser == null
            ? const WelcomeScreen()
            : const WrapperScreen()),
    GoRoute(
        path: '/wrapper_auth',
        builder: (context, state) => const WrapperAuthScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/register', builder: (context, state) => const NameScreen()),
    GoRoute(
        path: '/password/:name/:email',
        builder: (context, state) {
          return PasswordScreen(
            name: state.pathParameters['name'] as String,
            email: state.pathParameters['email'] as String,
          );
        }),
    GoRoute(path: '/role', builder: (context, state) => const RoleScreen()),
    GoRoute(
        path: '/verification',
        builder: (context, state) => const VerificationScreen()),
    GoRoute(path: '/forget', builder: (context, state) => const ForgetScreen()),
    GoRoute(
        path: '/landing', builder: (context, state) => const LandingScreen()),
    GoRoute(
        path: '/profile', builder: (context, state) => const ProfileScreen()),
    GoRoute(path: '/book', builder: (context, state) => const BookScreen()),
    GoRoute(
        path: '/wrapper', builder: (context, state) => const WrapperScreen()),
    GoRoute(
        path: '/email',
        builder: (context, state) {
          String name = state.extra as String;
          return EmailScreen(
            name: name,
          );
        }),
    GoRoute(
      path: '/page',
      builder: (context, state) {
        PlaceModel placeModel = state.extra as PlaceModel;
        return PageScreen(placeModel: placeModel);
      },
    ),
    GoRoute(
      path: '/edit_profile',
      builder: (context, state) {
        FirestoreUserModel user = state.extra as FirestoreUserModel;
        return EditProfileScreen(user: user);
      },
    ),
  ]);
}
