import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quoter/common/views.dart';
import 'package:quoter/models/category.dart';
import 'package:quoter/screen/exploer/blocs/fetch_quote_bloc.dart';

class QuotesList extends StatefulWidget {
  QuoteCategory category;

  QuotesList({super.key, required this.category});

  @override
  State<QuotesList> createState() => _QuotesListState();
}

class _QuotesListState extends State<QuotesList> with AutomaticKeepAliveClientMixin {
  FetchQuoteBloc? bloc;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (bloc!.state is FetchingQuoteState) {
        //bloc!.add(FetchQuoteEvent(category: widget.category.title));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => FetchQuoteBloc(),
        child: BlocConsumer<FetchQuoteBloc, QuoteState>(
          builder: (context, state) {
            bloc ??= context.read<FetchQuoteBloc>();
            return _provideWidget(state);
          },
          listener: (context, state) {
            print("_QuotesListState listener $state");
            if (state is FetchingQuoteState && state.firstFetch) {
              bloc!.add(FetchQuoteEvent(category: widget.category.title));
            }
          },
        ));
  }

  Widget _provideWidget(QuoteState state) {
    if (state is FetchingQuoteState) {
      return  const Center(
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
            key: PageStorageKey(widget.category),
          ),
        )
      ],
    );
  }

  void fetchQuotesIfNeeded() async {
    Future.delayed(Duration(milliseconds: 300), () {
      if (bloc!.state is FetchingQuoteState) {
        bloc!.add(FetchQuoteEvent(category: widget.category.title));
      }
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
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
