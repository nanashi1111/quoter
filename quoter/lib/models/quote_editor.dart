import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class QuoteEditor extends Equatable {
  String content = "";
  Color textColor = Colors.white;
  Color shadowColor = Colors.black;
  double shadowOpacity = 0.5;
  int backgroundPatternPos = 1;

  QuoteEditor copy({String? content, Color? textColor, Color? shadowColor, double? shadowOpacity, int? backgroundPatternPos}) {
    QuoteEditor result = QuoteEditor();
    if (content != null) {
      result.content = content;
    }
    if (textColor != null) {
      result.textColor = textColor;
    }
    if (shadowColor != null) {
      result.shadowColor = shadowColor;
    }
    if (shadowOpacity != null) {
      result.shadowOpacity = shadowOpacity;
    }
    if (backgroundPatternPos != null) {
      result.backgroundPatternPos = backgroundPatternPos;
    }
    return result;
  }

  @override
  List<Object?> get props => [content, textColor, shadowColor, shadowOpacity, backgroundPatternPos];
}
