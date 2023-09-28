import 'package:flutter/material.dart';

import 'dart:ui' as ui show PlaceholderAlignment;

import 'package:multi_highlight_text/config.dart';
import 'package:multi_highlight_text/multi_highlight_text.dart';
import 'package:collection/collection.dart';
import 'package:multi_highlight_text_example/widget/tooltip.dart';

/// @author: pengboboer
/// @createDate: 2023/7/20

class CorrectErrorWidget extends StatelessWidget {
  final String text;
  final List<String> searchList;
  final List<CorrectItem> errorList;
  final ValueChanged<CorrectItem> onClickCorrectError;

  const CorrectErrorWidget(
      {Key? key,
      required this.text,
      required this.searchList,
      required this.errorList,
      required this.onClickCorrectError})
      : super(key: key);

  final TextStyle _textStyle =
      const TextStyle(fontSize: 14, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    List<HighlightItem> list = [];
    // error
    list.addAll(errorList
        .map((e) => HighlightItem(
              text: e.errorText,
              range: TextRange(start: e.start, end: e.end),
              textStyle: _textStyle.copyWith(
                decoration: TextDecoration.underline,
                decorationColor: Colors.red[700],
                decorationStyle: TextDecorationStyle.solid,
                decorationThickness: 3,
              ),
              customConfig: e,
            ))
        .toList());
    // search
    list.addAll(searchList
        .map((e) => HighlightItem(
              text: e,
              textStyle: _textStyle.copyWith(backgroundColor: Colors.amber),
            ))
        .toList());
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        children: [
          MultiHighLightText(
            text: text,
            textStyle: _textStyle,
            onMixStyleBuilder: _onMixCorrectErrorTextStyleBuilder,
            onDecorateTextSpanBuilder: _onDecorateBuilder,
            highlights: list,
          ),
          _buildHintWidget(),
        ],
      ),
    );
  }

  TextStyle _onMixCorrectErrorTextStyleBuilder(
      TextStyle styleA, TextStyle styleB) {
    TextStyle base =
        styleA.decoration == TextDecoration.underline ? styleA : styleB;
    return base.copyWith(
        backgroundColor:
            Color.lerp(styleA.backgroundColor, styleB.backgroundColor, 1));
  }

  List<InlineSpan> _onDecorateBuilder(List<TextSpanStylesConfig> list) {
    List<InlineSpan> textSpans = [];
    for (int i = 0; i < list.length; i++) {
      InlineSpan inlineSpan = list[i].textSpan;
      CorrectItem? correctItem = list[i]
          .configs
          ?.firstWhereOrNull((element) => element.customConfig != null)
          ?.customConfig;
      if (correctItem != null) {
        inlineSpan = buildErrorWidgetSpan(inlineSpan, correctItem);
      }
      textSpans.add(inlineSpan);
    }
    return textSpans;
  }

  /// build Tooltip Widget
  WidgetSpan buildErrorWidgetSpan(
      InlineSpan textSpan, CorrectItem correctItem) {
    return WidgetSpan(
      alignment: ui.PlaceholderAlignment.baseline,
      baseline: TextBaseline.alphabetic,
      child: ClickTooltip(
        preferBelow: false,
        padding: const EdgeInsets.all(0),
        waitDuration: const Duration(milliseconds: 200),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
        ),
        richMessage: WidgetSpan(
          child: Container(
            width: 100,
            height: 76,
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Material(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 22,
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "错别字修正",
                      style: TextStyle(fontSize: 12, color: Color(0xff666666)),
                    ),
                  ),
                  Listener(
                    onPointerDown: (detail) => onClickCorrectError(correctItem),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 40,
                        color: Colors.white,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          correctItem.correctText,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[500]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        child: RichText(
          text: textSpan,
        ),
      ),
    );
  }

  Widget _buildHintWidget() {
    return const Padding(
      padding: EdgeInsets.only(top: 100),
      child: Text(
        "android or ios devices require long press error correction",
        style: TextStyle(
          fontSize: 12,
          color: Color(0xff999999),
        ),
      ),
    );
  }
}

class CorrectItem {
  final String errorText;
  final String correctText;
  final int start;
  final int end;

  CorrectItem(
      {required this.errorText,
      required this.correctText,
      required this.start,
      required this.end});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CorrectItem &&
          runtimeType == other.runtimeType &&
          errorText == other.errorText &&
          correctText == other.correctText &&
          start == other.start &&
          end == other.end;

  @override
  int get hashCode =>
      errorText.hashCode ^ correctText.hashCode ^ start.hashCode ^ end.hashCode;
}
