import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/views.dart';
import 'package:quoter/models/quote.dart';
import 'package:quoter/models/quote_category.dart';
import 'package:quoter/screen/exploer/blocs/fetch_quote_bloc.dart';
import 'package:quoter/screen/loading/list_loading_footer.dart';
import 'package:quoter/screen/loading/loading_screen.dart';

class QuotesList extends StatefulWidget {
  QuoteCategory category;

  QuotesList({super.key, required this.category});

  @override
  State<QuotesList> createState() => _QuotesListState();
}

class _QuotesListState extends State<QuotesList> with AutomaticKeepAliveClientMixin {
  FetchQuoteBloc? bloc;

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (!_controller.hasClients || (bloc?.state is FetchedQuoteState && (bloc?.state as FetchedQuoteState).loadingMore == true)) {
        return;
      }
      final thresholdReached = _controller.position.extentAfter < 100;
      if (!thresholdReached) {
        return;
      }
      bloc?.add(FetchQuoteEvent(category: widget.category.title ?? ""));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => FetchQuoteBloc()..add(FetchQuoteEvent(category: widget.category.title ?? "")),
        child: BlocBuilder<FetchQuoteBloc, QuoteState>(builder: (context, state) {
          bloc ??= context.read<FetchQuoteBloc>();
          return _provideWidget(state);
        }));
  }

  Widget _provideWidget(QuoteState state) {
    if (state is FetchingQuoteState) {
      return LoadingScreen();
    }

    return Column(
      children: [
        verticalSpacing(10),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, pos) {
              int quoteCount = (state as FetchedQuoteState).quotes.length;
              if (pos < quoteCount) {
                Quote quote = (state as FetchedQuoteState).quotes[pos];
                return QuoteItem(
                  pos: 1 + pos % 6,
                  content: quote,
                  callback: () {
                    Map<String, String> pathParameters = <String, String>{}
                      ..addEntries(List.of([MapEntry("quote", jsonEncode(quote)), MapEntry("backgroundPatternPos", "${1 + pos % 6}")]));
                    context.pushNamed("editor", pathParameters: pathParameters);
                  },
                );
              }
              return const ListLoadingFooter();
            },
            separatorBuilder: (context, pos) {
              return verticalSpacing(10);
            },
            controller: _controller,
            itemCount: 1 + (state as FetchedQuoteState).quotes.length,
            key: PageStorageKey(widget.category),
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class QuoteItem extends StatelessWidget {
  int pos;
  Quote content;

  VoidCallback callback;

  QuoteItem({super.key, required this.pos, required this.content, required this.callback});

  String _provideImagePath() {
    return "assets/images/pattern_$pos.jpg";
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.9;
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Center(
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
                color: Colors.black.withOpacity(0.5),
              ),
              Center(
                  child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  content.content ?? "",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                  /*style: const TextStyle(
                    fontFamily: 'Lato',
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 25,
                  ),*/
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
