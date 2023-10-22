import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:surf_together/domain/services/firebase_messaging_services.dart';
import 'package:surf_together/presentation/bloc/auth/auth_bloc.dart';
import 'package:surf_together/presentation/bloc/profile/profile_bloc.dart';
import 'package:surf_together/presentation/providers/database_provider.dart';
import 'package:surf_together/utils/extensions/http_overrides.dart';
import 'package:surf_together/utils/routes/route_screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp();
  FirebaseMessagingServices().initialiaze;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
        BlocProvider<ProfileBloc>(create: (_) => ProfileBloc()),
      ],
      child: Provider<DatabaseProvider>(
        create: (context) => DatabaseProvider(),
        child: MaterialApp.router(
          routerConfig: RouteScreens.router,
          debugShowCheckedModeBanner: false,
          title: 'SurfTogether',
          theme: ThemeData(
              primaryColor: Colors.white, primarySwatch: Colors.green),
        ),
      ),
    );
  }
}
