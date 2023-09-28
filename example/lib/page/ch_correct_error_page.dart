import 'package:flutter/material.dart';

import '../widget/correct_error_widget.dart';

/// @author: pengboboer
/// @createDate: 2023/7/18
class ChCorrectErrorPage extends StatefulWidget {
  const ChCorrectErrorPage({Key? key}) : super(key: key);

  @override
  State<ChCorrectErrorPage> createState() => _ChCorrectErrorPageState();
}

class _ChCorrectErrorPageState extends State<ChCorrectErrorPage> {
  String text = "亲爱底，你是我生明中的一切。无论核实何地，我都深深地爱着你。你是我的勇恒，我愿陪伴你走过每一个妹好的瞬间。";

  final List<String> searchList = [
    "我生明中的一切",
    "实何地",
    "妹好的",
  ];

  final List<CorrectItem> errorList = [
    CorrectItem(errorText: "底", correctText: "的", start: 2, end: 3),
    CorrectItem(errorText: "明", correctText: "命", start: 8, end: 9),
    CorrectItem(errorText: "核实", correctText: "何时", start: 16, end: 18),
    CorrectItem(errorText: "勇", correctText: "永", start: 34, end: 35),
    CorrectItem(errorText: "妹好", correctText: "美好", start: 47, end: 49),
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
