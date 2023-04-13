import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task/presentation/screens/authentication_screens/forget_screen.dart';
import 'package:test_task/presentation/screens/authentication_screens/login_screen.dart';
import 'package:test_task/presentation/screens/authentication_screens/register_screen.dart';
import 'package:test_task/presentation/screens/authentication_screens/wrapper_auth_screen.dart';
import 'package:test_task/presentation/screens/home_screens/book_screen.dart';
import 'package:test_task/presentation/screens/home_screens/landing_screen.dart';
import 'package:test_task/presentation/screens/home_screens/profile_screen.dart';
import 'package:test_task/presentation/screens/wrapper_screen.dart';

class RouteScreens {
  static final router = GoRouter(routes: [
    GoRoute(
        path: '/',
        builder: (context, state) => FirebaseAuth.instance.currentUser == null
            ? const WrapperAuthScreen()
            : const WrapperScreen()),
    GoRoute(
        path: '/wrapper_auth',
        builder: (context, state) => const WrapperAuthScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
        path: '/register', builder: (context, state) => const RegisterScreen()),
    GoRoute(path: '/forget', builder: (context, state) => const ForgetScreen()),
    GoRoute(
        path: '/landing', builder: (context, state) => const LandingScreen()),
    GoRoute(
        path: '/profile', builder: (context, state) => const ProfileScreen()),
    GoRoute(path: '/book', builder: (context, state) => const BookScreen()),
    GoRoute(
        path: '/wrapper', builder: (context, state) => const WrapperScreen()),
    
  ]);
}
