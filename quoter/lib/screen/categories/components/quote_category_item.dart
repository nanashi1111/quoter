import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/models/category_of_quote.dart';

class QuoteCategoryItem extends StatelessWidget {
  final CategoryOfQuote category;
  final Function(CategoryOfQuote) onClick;

  const QuoteCategoryItem({super.key, required this.category, required this.onClick});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = width * 9 / 16;
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/bg_category_${category.category?.toLowerCase()}.jpg',
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
            Container(
              color: Colors.black.withOpacity(0.5),
              width: width,
              height: height,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    category.category ?? "",
                    style: TextStyle(fontFamily: 'Category', fontSize: 24, color: Colors.white.withOpacity(0.85)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    category.quoteOfCategory ?? "",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(fontSize: 13, color: Colors.white.withOpacity(0.85)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () { onClick(category); },
    );
  }
}
