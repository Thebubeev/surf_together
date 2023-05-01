import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_together/domain/services/firebase_messaging_services.dart';
import 'package:surf_together/presentation/bloc/cubit_bloc.dart';
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
        BlocProvider<CubitBloc>(create: (_) => CubitBloc()),
      ],
      child: MaterialApp.router(
        routerConfig: RouteScreens.router,
          debugShowCheckedModeBanner: false,
          title: 'SurfTogether',
          theme: ThemeData(
              primaryColor: Colors.white, primarySwatch: Colors.green),
        ),
    );
  }
}
