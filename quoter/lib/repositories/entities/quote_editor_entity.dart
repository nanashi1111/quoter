import 'dart:collection';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quoter/common/colors.dart';
import 'package:quoter/models/quote_editor.dart';

part 'quote_editor_entity.freezed.dart';

@freezed
class QuoteEditorEntity with _$QuoteEditorEntity {
  const factory QuoteEditorEntity(
      {required int id,
      required String content,
      required int backgroundPatternPosition,
      required String backgroundColor,
      required double textSize,
      required String textColor,
      required String font}) = _QuoteEditorEntity;
}

extension QuoteEditorEntityToModel on QuoteEditorEntity {
  QuoteEditor toModel() {
    return QuoteEditor(
        id: id,
        content: content,
        backgroundPatternPos: backgroundPatternPosition,
        backgroundColor: backgroundColor.toColor(),
        textStyle: textStyleFromFontName(font).copyWith(color: textColor.toColor(), fontSize: textSize),
        fontName: font);
  }

  Map<String, dynamic> toMap() {
    HashMap<String, dynamic> result = HashMap();
    result["id"] = id;
    result["content"] = content;
    result["backgroundPatternPosition"] = backgroundPatternPosition;
    result["backgroundColor"] = backgroundColor;
    result["textSize"] = textSize;
    result["textColor"] = textColor;
    result["font"] = font;
    return result;
  }
}
