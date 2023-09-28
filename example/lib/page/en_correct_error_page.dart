import 'package:flutter/material.dart';

import '../widget/correct_error_widget.dart';

/// @author: pengboboer
/// @createDate: 2023/7/18
class EnCorrectErrorPage extends StatefulWidget {
  const EnCorrectErrorPage({Key? key}) : super(key: key);

  @override
  State<EnCorrectErrorPage> createState() => _EnCorrectErrorPageState();
}

class _EnCorrectErrorPageState extends State<EnCorrectErrorPage> {
  String text = "My deatest,Words canmot express the deoth of my love for you. "
      "Every moment spent with you is a treasure, filling my heart with joy. "
      "Your smile brightens my darkest days, and your touch ignites a fire within me. "
      "Forever grateful for your lpve, I cherish every second we share. "
      "You complete me.Yours forever.";

  final List<String> searchList = [
    "Words canmot express",
    "with you is a treasure",
    "touch",
  ];

  final List<CorrectItem> errorList = [
    CorrectItem(
        errorText: "deatest", correctText: "dearest", start: 3, end: 10),
    CorrectItem(errorText: "canmot", correctText: "cannot", start: 17, end: 23),
    CorrectItem(errorText: "deoth", correctText: "depth", start: 36, end: 42),
    CorrectItem(
        errorText: "treesure", correctText: "treasure", start: 95, end: 103),
    CorrectItem(errorText: "lpve", correctText: "love", start: 237, end: 241),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CorrectErrorPage'),
      ),
      body: CorrectErrorWidget(
        text: text,
        searchList: searchList,
        errorList: errorList,
        onClickCorrectError: _onClickCorrectError,
      ),
    );
  }

  void _onClickCorrectError(CorrectItem correctItem) {
    setState(() {
      text = text.replaceRange(
          correctItem.start, correctItem.end, correctItem.correctText);
      errorList.remove(correctItem);
    });
  }
}
