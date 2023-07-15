import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quoter/common/views.dart';
import 'package:quoter/models/category.dart';
import 'package:quoter/screen/exploer/blocs/fetch_quote_bloc.dart';

class QuotesList extends StatelessWidget {
  QuoteCategory category;
  FetchQuoteBloc? bloc;

  QuotesList({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    // BlocProvider(
    //   create: (context) => FetchQuoteBloc(),
    // );
    print("Init QuotesList for ${category.title}");
    return BlocProvider(
      create: (context) => FetchQuoteBloc(),
      child: BlocBuilder<FetchQuoteBloc, QuoteState>(
        builder: (context, state) {
          bloc ??= context.read<FetchQuoteBloc>();
          return _provideWidget(state);
        },
      ),
    );
  }

  Widget _provideWidget(QuoteState state) {
    if (state is FetchingQuoteState) {
      return const Center(
        child: Text("Loading..."),
      );
    }

    return Column(
      children: [
        verticalSpacing(10),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, pos) {
              return QuoteItem(
                pos: 1 + pos % 6,
                content: (state as FetchedQuoteState).quotes[pos].content,
              );
            },
            separatorBuilder: (context, pos) {
              return verticalSpacing(10);
            },
            itemCount: (state as FetchedQuoteState).quotes.length,
            key: PageStorageKey(category),
          ),
        )
      ],
    );
  }

  void fetchQuotesIfNeeded() async {
    print("Call API from ${category.title}");
    Future.delayed(Duration(milliseconds: 300), () {
      if (bloc!.state is FetchingQuoteState) {
        bloc!.add(FetchQuoteEvent(category: category.title));
      }
    });
  }
}

class QuoteItem extends StatelessWidget {
  int pos;
  String content;

  QuoteItem({super.key, required this.pos, required this.content});

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
                child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                content,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Lato',
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 25,
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
