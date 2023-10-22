import 'package:flutter/material.dart';
import 'package:surf_together/presentation/widgets/appbar_widget.dart';
import '../../widgets/productions_widget.dart';
import '../../widgets/widgets.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({Key? key}) : super(key: key);

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                  child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 10, bottom: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    coloredCard(),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Ваши заявки",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                          color: Colors.grey[700]),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                  ],
                ),
              )),
            ),
            const ListProductionsWidgets(),
          ],
        ),
      ),
    );
  }
}
