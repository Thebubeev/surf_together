import 'package:flutter/material.dart';

class AlbomCardWidget extends StatelessWidget {
  final String url;
  final String title;
  final String subtitle;
  const AlbomCardWidget(
      {Key? key,
      required this.url,
      required this.title,
      required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Stack(alignment: Alignment.bottomLeft, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                url,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.map_sharp,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(subtitle,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 16))
                    ],
                  )
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
