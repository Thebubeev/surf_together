import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:surf_together/data/models/place_model.dart';

class CardSwiperImageWidget extends StatelessWidget {
  const CardSwiperImageWidget({
    Key? key,
    required this.placeModel,
  }) : super(key: key);

  final PlaceModel placeModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Image.network(
              placeModel.imageUrl,
              fit: BoxFit.fill,
            );
          },
          itemCount: 1,
          pagination: SwiperPagination(),
          control: SwiperControl(),
        ),
      ),
    );
  }
}
