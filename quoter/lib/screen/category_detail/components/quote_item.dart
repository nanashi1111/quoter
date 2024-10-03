import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quoter/common/method_channel_handler.dart';
import 'package:quoter/common/toast.dart';
import 'package:quoter/common/views.dart';
import 'package:quoter/utils/constants.dart';
import 'package:quoter/utils/widget_to_image/utils.dart';
import 'package:quoter/utils/widget_to_image/widgets_to_image.dart';
import 'package:path_provider/path_provider.dart';

class QuoteItem extends StatelessWidget {
  final String quote;
  final int imagePos;
  //final String imagePath;
  final Function(String, int) onClick;

  WidgetsToImageController controller = WidgetsToImageController();

  QuoteItem({super.key, required this.quote, required this.onClick, required this.imagePos});

  _onCopy(BuildContext context) {
    Clipboard.setData(ClipboardData(text: quote));
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
    double size = MediaQuery.of(context).size.width;
    String imagePath = 'assets/images/bg_${imagePos.toString().padLeft(2, '0')}.jpg';
    return WidgetsToImage(
        controller: controller,
        child: SizedBox(
          width: size,
          height: size,
          child: Stack(
            children: [
              Image.asset(
                imagePath,
                width: size,
                height: size,
                fit: BoxFit.cover,
              ),
              GestureDetector(
                child: Container(
                  width: size,
                  height: size,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  color: Colors.black.withOpacity(BLACK_LAYER_ALPHA),
                  child: Text(
                    quote,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontFamily: 'Category', fontSize: 18, color: Colors.white),
                  ),
                ),
                onTap: () {
                  onClick(quote, imagePos);
                },
              ),
              Positioned(
                right: 15,
                bottom: 15,
                child: Row(
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
                ),
              ),
            ],
          ),
        ));
  }
}
