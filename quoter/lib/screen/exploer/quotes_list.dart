import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/method_channel_handler.dart';
import 'package:quoter/common/toast.dart';
import 'package:quoter/common/views.dart';
import 'package:quoter/models/quote.dart';
import 'package:quoter/models/quote_category.dart';
import 'package:quoter/screen/exploer/blocs/fetch_quote_bloc.dart';
import 'package:quoter/screen/loading/list_loading_footer.dart';
import 'package:quoter/screen/loading/loading_screen.dart';
import 'package:quoter/utils/admob_helper.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:quoter/utils/widget_to_image/utils.dart';
import 'package:quoter/utils/widget_to_image/widgets_to_image.dart';

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
              int quoteCount = state.quotes.length;
              if (pos < quoteCount) {
                Quote quote = state.quotes[pos];
                return QuoteItem(
                  pos: 1 + pos % 6,
                  content: quote,
                  callback: () {
                    AdmobHelper.instance.showInterAds(() {
                      Map<String, String> pathParameters = <String, String>{}
                        ..addEntries(List.of([MapEntry("quote", jsonEncode(quote)), MapEntry("backgroundPatternPos", "${1 + pos % 6}")]));
                      context.pushNamed("editor", pathParameters: pathParameters);
                    });
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

  WidgetsToImageController controller = WidgetsToImageController();

  _onCopy(BuildContext context) {
    Clipboard.setData(ClipboardData(text: content.content ?? ""));
    showToast(context, "Quote is copied");
  }
  _onShare() {
    controller.capture().then((image) async {
      debugPrint("onSuccess");
      Directory directory = await getApplicationDocumentsDirectory();
      String path = '${directory.path}/my_widget_image_${DateTime.now().millisecondsSinceEpoch}.png';
      File imgFile = File(path);
      await imgFile.writeAsBytes(image?.buffer.asInt8List() ?? []);
      debugPrint('Image saved to $path');
      MethodChannelHandler.instance.invokeMethod(MethodChannelHandler.shareFile, data: path);
    }).catchError((onError) {
      debugPrint("Error: ${onError}");
    });
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.9;
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Center(
        child: WidgetsToImage(
          controller: controller,
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
                )),
                Positioned(right: 15,
                  bottom: 15,child: Row(
                  children: [
                    GestureDetector(
                      child: SvgPicture.asset(
                        'assets/images/ic_copy.svg',
                        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        width: 35,
                        height: 35,
                      ),
                      onTap: () {
                        _onCopy(context);
                      },
                    ),
                    horizontalSpacing(15),
                    GestureDetector(
                      child: SvgPicture.asset(
                        'assets/images/ic_share.svg',
                        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        width: 35,
                        height: 35,
                      ),
                      onTap: () {
                        _onShare();
                      },
                    )
                  ],
                ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
