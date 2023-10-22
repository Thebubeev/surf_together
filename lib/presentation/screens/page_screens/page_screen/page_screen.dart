import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:surf_together/data/models/place_model.dart';
import 'package:surf_together/domain/repositories/interfaces/sqflite_places_dao_repository.dart';
import 'package:surf_together/presentation/screens/page_screens/page_screen/widgets/card_swiper_image_widget.dart';
import 'package:surf_together/utils/constants/constants.dart';

import '../../../../domain/repositories/sqflite_places_dao_repository_impl.dart';

class PageScreen extends StatefulWidget {
  final PlaceModel placeModel;
  const PageScreen({Key? key, required this.placeModel}) : super(key: key);

  @override
  State<PageScreen> createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> {
  bool _isSaved = false;
  SqflitePlacesDaoRepository sqflitePlacesDaoRepository =
      SqflitePlacesDaoRepositoryImpl();

  Future<void> checkPlace() async {
    final listNames = await sqflitePlacesDaoRepository
        .getPlacesDao()
        .then((value) => value.map((e) => e.name).toList());
    if (listNames.contains(widget.placeModel.name)) {
      setState(() {
        _isSaved = true;
      });
    } else {
      setState(() {
        _isSaved = false;
      });
    }
  }

  @override
  void initState() {
    checkPlace();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.green,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        titleSpacing: 0.6,
        centerTitle: true,
        title: Text(
          widget.placeModel.name,
          style: Constants.defaultTextTitleStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ListView(
          children: [
            Text(
              widget.placeModel.name,
              style: Constants.defaultBigTextStyle,
            ),
            const SizedBox(
              height: 10,
            ),
            CardSwiperImageWidget(placeModel: widget.placeModel),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                        width: 60,
                        height: 60,
                        child: CachedNetworkImage(
                          placeholder: (context, _) =>
                              CircularProgressIndicator(),
                          imageUrl:
                              'https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png',
                        ))),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Бубеев Арсалан',
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.w300),
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on),
                        Text(widget.placeModel.city,
                            overflow: TextOverflow.fade,
                            maxLines: 3,
                            softWrap: false,
                            style: Constants.defaultTextBlackStyle),
                      ],
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Какое то длинное приветствие описание, интересы, предпочтения.....',
              style: Constants.defaultTextBlackStyle,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              '1 гостевая комната',
              style: Constants.defaultTextBlackStyle,
            ),
            const SizedBox(
              height: 10,
            ),
            Text('Удобства:', style: Constants.defaultTextBlackStyle),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.wifi,
                  size: 30,
                ),
                const SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.bathtub,
                  size: 30,
                ),
                const SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.tv,
                  size: 30,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      onPressed: () async {
                        _isSaved
                            ? null
                            : {
                                await sqflitePlacesDaoRepository
                                    .insert(widget.placeModel),
                                setState(() {
                                  _isSaved = true;
                                })
                              };
                      },
                      child: _isSaved
                          ? Icon(
                              Icons.check,
                              color: Colors.black,
                            )
                          : Text(
                              'Добавить\nв избраннное',
                              textAlign: TextAlign.center,
                              style: Constants.defaultButtonBlackStyle,
                            )),
                ),
                const SizedBox(
                  width: 6,
                ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Подать заявку',
                        style: Constants.defaultButtonWhiteStyle,
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
