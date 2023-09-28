import 'package:flutter/material.dart';
import 'package:multi_highlight_text/config.dart';
import 'package:multi_highlight_text/multi_highlight_text.dart';

/// @author: pengboboer
/// @createDate: 2023/7/18
class SimplePage extends StatefulWidget {
  const SimplePage({Key? key}) : super(key: key);

  @override
  State<SimplePage> createState() => _SimplePageState();
}

class _SimplePageState extends State<SimplePage> {
  String chText = "亲爱的，你是我生命中的一切。无论何时何地，我都深深地爱着你。你是我的永恒，我愿陪伴你走过每一个美好的瞬间。";

  String enText =
      "My dearest,Words cannot express the depth of my love for you. "
      "Every moment spent with you is a treasure, filling my heart with joy. "
      "Your smile brightens my darkest days, and your touch ignites a fire within me. "
      "Forever grateful for your love, I cherish every second we share. "
      "You complete me.Yours forever.";
  final TextStyle _textStyle =
      const TextStyle(fontSize: 14, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SimplePage'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildChineseFontColorExample(),
            _buildChineseFontColorExample(
              onMixStyleBuilder: (styleA, styleB) {
                return _textStyle.copyWith(color: Colors.blue, fontSize: 17);
              },
            ),
            _buildEnglishBackgroundColorExample(),
            _buildEnglishBackgroundColorExample(
              onMixStyleBuilder: (styleA, styleB) {
                return _textStyle.copyWith(backgroundColor: Colors.blue);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChineseFontColorExample({MixStyleBuilder? onMixStyleBuilder}) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: MultiHighLightText(
        text: chText,
        textStyle: _textStyle,
        onMixStyleBuilder: onMixStyleBuilder,
        highlights: [
          HighlightItem(
              text: "你是我生命中的一切",
              textStyle: _textStyle.copyWith(color: Colors.green)),
          HighlightItem(
              text: "一切。无论何时何地",
              textStyle: _textStyle.copyWith(color: Colors.yellow)),
          HighlightItem(
              range: const TextRange(start: 0, end: 1),
              textStyle: _textStyle.copyWith(color: Colors.red)),
        ],
      ),
    );
  }

  Widget _buildEnglishBackgroundColorExample(
      {MixStyleBuilder? onMixStyleBuilder}) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: MultiHighLightText(
        text: enText,
        textStyle: const TextStyle(fontSize: 14, color: Colors.black),
        onMixStyleBuilder: onMixStyleBuilder,
        highlights: [
          ...["Words", "depth of my", "and your touch ignites a fire"]
              .map((e) => HighlightItem(
                  text: e,
                  textStyle:
                      _textStyle.copyWith(backgroundColor: Colors.green)))
              .toList(),
          ...["brightens my", "my darkest days", "ignites", "fire within me"]
              .map((e) => HighlightItem(
                  text: e,
                  textStyle:
                      _textStyle.copyWith(backgroundColor: Colors.yellow)))
              .toList(),
          ...[
            const TextRange(start: 0, end: 1),
            const TextRange(start: 6, end: 9),
            const TextRange(start: 30, end: 40)
          ]
              .map((e) => HighlightItem(
                  range: e,
                  textStyle: _textStyle.copyWith(backgroundColor: Colors.red)))
              .toList()
        ],
      ),
    );
  }
}
