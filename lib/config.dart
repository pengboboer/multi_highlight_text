import 'package:flutter/material.dart';

/// @author: pengboboer
/// @createDate: 2023/9/14

typedef MixStyleBuilder = TextStyle Function(TextStyle a, TextStyle b);

typedef DecorateTextSpanBuilder = List<InlineSpan> Function(
    List<TextSpanStylesConfig> list);

/// The highlighted word information you want to show
class HighlightItem {
  final String? text;
  final TextRange? range;
  final TextStyle textStyle;

  /// This custom configuration that can be used for information callback
  final dynamic customConfig;

  HighlightItem(
      {this.range, this.text, required this.textStyle, this.customConfig})
      : assert(text != null || range != null,
            "requires at least one condition under which highlighting can be determined");

  HighlightItem copyWith(
      {TextRange? range,
      String? text,
      TextStyle? textStyle,
      dynamic customConfig}) {
    return HighlightItem(
        range: range ?? this.range,
        text: text ?? this.text,
        textStyle: textStyle ?? this.textStyle,
        customConfig: customConfig ?? this.customConfig);
  }
}

class TextSpanStylesConfig {
  /// The textSpan of a certain range after the cut
  final InlineSpan textSpan;

  /// The List of config for overlapping styles
  /// If configs is null, it indicates that the TextSpan does not have a highlighted style
  final List<HighlightItem>? configs;

  TextSpanStylesConfig({required this.textSpan, this.configs});
}
