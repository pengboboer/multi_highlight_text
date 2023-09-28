import 'package:flutter/material.dart';
import 'package:multi_highlight_text_example/page/ch_correct_error_page.dart';
import 'package:multi_highlight_text_example/page/en_correct_error_page.dart';
import 'package:multi_highlight_text_example/page/simple_page.dart';

void main() {
  runApp(const MaterialApp(home: HomePage()));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi HighLight Example'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SimplePage()));
                  },
                  child: const Text("simple_page"),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ChCorrectErrorPage()));
                  },
                  child: const Text("correct_error_page(chinese)"),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const EnCorrectErrorPage()));
                  },
                  child: const Text("correct_error_page"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
