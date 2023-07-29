
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../common/colors.dart';

class QuoteEditor extends Equatable {
  String content = "";
  Color textColor = Colors.white;
  int backgroundPatternPos = 1;
  Color backgroundColor = Colors.black.withOpacity(0.5);
  TextStyle textStyle = textStyles.first;

  QuoteEditor copy({String? content, Color? textColor, int? backgroundPatternPos, Color? backgroundColor, TextStyle? textStyle}) {
    QuoteEditor result = QuoteEditor();
    if (content != null) {
      result.content = content;
    }
    if (textColor != null) {
      result.textColor = textColor;
    }
    if (backgroundPatternPos != null) {
      result.backgroundPatternPos = backgroundPatternPos;
    }
    if (backgroundColor != null) {
      result.backgroundColor = backgroundColor;
    }
    if (textStyle != null) {
      result.textStyle = textStyle;
    }
    return result;
  }

  @override
  List<Object?> get props => [content, textColor, backgroundPatternPos, backgroundColor, textStyle];
}
