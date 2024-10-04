import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/method_channel_handler.dart';
import 'package:quoter/common/toast.dart';
import 'package:quoter/common/views.dart';
import 'package:quoter/models/quote_editor.dart';
import 'package:quoter/utils/constants.dart';
import 'package:quoter/utils/widget_to_image/utils.dart';
import 'package:quoter/utils/widget_to_image/widgets_to_image.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

class MyQuoteItem extends StatelessWidget {
  final QuoteEditor content;

  final double size;

  final VoidCallback callback;

  MyQuoteItem({super.key, required this.content, required this.callback, required this.size});


  WidgetsToImageController controller = WidgetsToImageController();

  String _providePatternPath(int pos) {
    return "assets/images/pattern_$pos.jpg";
  }

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
    double size = MediaQuery.of(context).size.width * 1;
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
                _providePatternBackground(),
                _provideColorBackground(),
                _provideImageBackground(),
                Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        content.content ?? "",
                        textAlign: TextAlign.center,
                        style: content.textStyle,
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


  Widget _provideColorBackground() {
    return Container(
      width: size,
      height: size,
      color: content.backgroundColor,
    );
  }

  Widget _providePatternBackground() {
    if (content.backgroundPatternPos > 0) {
      return Image(
        image: AssetImage(
          "assets/images/pattern_${content.backgroundPatternPos}.jpg",
        ),
        fit: BoxFit.cover,
        width: size,
        height: size,
      );
    }
    return SizedBox(
      width: 1,
      height: 1,
    );
  }
  Widget _provideImageBackground() {
    if (content.backgroundImagePos > 0) {
      String path = "assets/images/bg_${content.backgroundImagePos.toString().padLeft(2, '0')}.jpg";
      return Container(
        child: Stack(
          children: [
            Image(
              image: AssetImage(
                path,
              ),
              fit: BoxFit.cover,
              width: size,
              height: size,
            ),
            Container(
              width: size,
              height: size,
              color: Colors.black.withOpacity(BLACK_LAYER_ALPHA),
            )
          ],
        ),
      );
    }
    return SizedBox(
      width: 1,
      height: 1,
    );
  }
}