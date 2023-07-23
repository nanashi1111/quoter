import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class QuoteEditor extends Equatable {
  String content = "";
  Color textColor = Colors.white;
  Color shadowColor = Colors.black;
  double shadowOpacity = 0.5;
  int backgroundPatternPos = 1;
  Color backgroundColor = Colors.transparent;

  QuoteEditor copy({String? content, Color? textColor, Color? shadowColor, double? shadowOpacity, int? backgroundPatternPos, Color? backgroundColor}) {
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
    if (backgroundColor != null) {
      result.backgroundColor = backgroundColor;
    }
    return result;
  }

  @override
  List<Object?> get props => [content, textColor, shadowColor, shadowOpacity, backgroundPatternPos, backgroundColor];
}
