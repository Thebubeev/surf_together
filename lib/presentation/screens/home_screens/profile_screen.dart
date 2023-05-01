import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:surf_together/presentation/widgets/appbar_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(),
      body: ListView(children: [
        Center(
            child: Container(
                width: 160,
                height: 160,
                child: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/7/72/Default-welcomer.png'))),
      ]),
    );
  }
}
