import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quoter/common/colors.dart';
import 'package:quoter/repositories/entities/quote_editor_entity.dart';
part 'quote_editor.freezed.dart';

@freezed
class QuoteEditor with _$QuoteEditor {
  const factory QuoteEditor({
    required int id,
    required String content,
    required int backgroundPatternPos,
    required int backgroundImagePos,
    @Default(Color.fromRGBO(0, 0, 0, 0.5)) Color backgroundColor,
    required TextStyle textStyle,
    required String fontName
  }) = _QuoteEditor;
}

extension QuoteEditorMapper on QuoteEditor {
  QuoteEditorEntity toEntity() {
    return QuoteEditorEntity(id: id, content: content, backgroundPatternPosition: backgroundPatternPos, backgroundColor: backgroundColor.toHexString(), textSize: textStyle
        .fontSize ?? 0, textColor: textStyle.color?.toHexString() ?? "#ffffff", font: fontName, backgroundImagePosition: backgroundImagePos);
  }
}
