library multi_highlight;

import 'package:flutter/material.dart';

import 'config.dart';

/// @author: pengboboer
/// @createDate: 2023/7/11

class MultiHighLightText extends StatelessWidget {
  /// The text you want to show
  final String text;

  /// The normal text style
  final TextStyle textStyle;

  final int? maxLines;

  final TextOverflow overflow;

  /// List with the word you need to highlight
  final List<HighlightItem>? highlights;

  /// When multiple words overlap, multiple TextStyle mix the final TextStyle
  /// When mixing more than two TextStyles, the third TextStyle will be remixed with the previous mixed TextStyle
  final MixStyleBuilder? onMixStyleBuilder;

  /// For the decoration of List<InlineSpan> after cutting
  /// return a new List<InlineSpan>
  final DecorateTextSpanBuilder? onDecorateTextSpanBuilder;

  const MultiHighLightText({
    Key? key,
    required this.text,
    required this.textStyle,
    this.highlights,
    this.onMixStyleBuilder,
    this.onDecorateTextSpanBuilder,
    this.maxLines,
    this.overflow = TextOverflow.clip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (highlights?.isEmpty ?? true) {
      return Text(text, style: textStyle);
    }
    return RichText(
      text: TextSpan(children: _buildTextSpan(), style: textStyle),
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  List<InlineSpan> _buildTextSpan() {
    List<InlineSpan> textSpans = [];
    List<TextSpanStylesConfig> configTextSpans = [];
    Map<int, List<HighlightItem>> indexMap =
        _getIndexMapWithHighLight(highlights!);
    int current = 0;
    TextStyle prevStyle = textStyle;
    // insert into list
    void add(int start, int end) {
      TextSpan textSpan =
          TextSpan(text: text.substring(start, end), style: prevStyle);
      textSpans.add(textSpan);
      if (onDecorateTextSpanBuilder != null) {
        configTextSpans.add(
            TextSpanStylesConfig(textSpan: textSpan, configs: indexMap[start]));
      }
    }

    for (int i = 0; i < text.length; i++) {
      TextStyle? style = _getMixStyle(indexMap[i]);
      // add text with the same style to the list
      if (prevStyle != style) {
        add(current, i);
        current = i;
        prevStyle = style;
      }

      if (i == text.length - 1 &&
          (current != i || current == text.length - 1)) {
        add(current, i + 1);
      }
    }

    if (onDecorateTextSpanBuilder != null) {
      return onDecorateTextSpanBuilder!(configTextSpans);
    }

    return textSpans;
  }

  /// Get a map with all highlighted index
  Map<int, List<HighlightItem>> _getIndexMapWithHighLight(
      List<HighlightItem> list) {
    Map<int, List<HighlightItem>> map = {};
    void add(HighlightItem item) {
      for (int i = item.range!.start; i < item.range!.end; i++) {
        map[i] ??= [];
        map[i]!.add(item);
      }
    }

    for (HighlightItem item in list) {
      if (item.range == null) {
        // Match the position where the text appears in the full text
        var matches = item.text!.allMatches(text).toList();
        for (var match in matches) {
          int start = match.start;
          int end = start + match.pattern.toString().length;
          add(item.copyWith(range: TextRange(start: start, end: end)));
        }
        continue;
      }
      add(item);
    }
    return map;
  }

  /// Get multiple mixed style
  TextStyle _getMixStyle(List<HighlightItem>? list) {
    if (list?.isEmpty ?? true) return textStyle;
    TextStyle? style;
    for (var value in list!) {
      style ??= value.textStyle;
      if (style != value.textStyle) {
        style = onMixStyleBuilder?.call(style, value.textStyle) ??
            TextStyle.lerp(style, value.textStyle, 0.5);
      }
    }
    return style ?? textStyle;
  }
}
