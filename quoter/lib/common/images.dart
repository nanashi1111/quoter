import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:image/image.dart';

class ImageUtils {

  static Future<String> encodeImage(File file) async {
    List<int> imageBytes = file.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
    //return 'data:image/jpeg;base64,$base64Image';
  }

  static Future<String> decodeImage(String encoded) async {
    String decoded = utf8.decode(base64Url.decode(encoded));
    return decoded;
  }

}