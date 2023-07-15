import 'package:flutter/material.dart';
import 'package:quoter/common/views.dart';
import 'package:quoter/models/category.dart';

class QuotesList extends StatelessWidget {

  QuoteCategory category;

  QuotesList({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpacing(10),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, pos) {
              return QuoteItem(
                pos: 1 + pos % 6,
              );
            },
            separatorBuilder: (context, pos) {
              return verticalSpacing(10);
            },
            itemCount: 100,
            key: PageStorageKey(category),
          ),
        )
      ],
    );
  }

  void fetchQuotes() {
    print("Call API from ${category.title}");
  }
}

class QuoteItem extends StatelessWidget {
  int pos;

  QuoteItem({required this.pos});

  String _provideImagePath() {
    return "assets/images/pattern_$pos.jpg";
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.9;
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          children: [
            Image(
              image: AssetImage(
                _provideImagePath(),
              ),
              fit: BoxFit.cover,
              width: size,
              height: size,
            ),
            Container(
              color: Colors.black.withOpacity(0.3),
            ),
             Center(
              child: Text(
                "I love you $pos",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Lato',
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 35,

                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
