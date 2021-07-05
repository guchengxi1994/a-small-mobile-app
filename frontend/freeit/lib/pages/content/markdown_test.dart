import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:freeit/utils/shared_preference_utils.dart';

class MyAppMarkdownTest extends StatelessWidget {
  const MyAppMarkdownTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Markdown Demo'),
          centerTitle: true,
        ),
        body: FlutterMarkdown(),
      ),
    );
  }
}

class FlutterMarkdown extends StatefulWidget {
  FlutterMarkdown({Key? key}) : super(key: key);

  @override
  _FlutterMarkdownState createState() => _FlutterMarkdownState();
}

class _FlutterMarkdownState extends State<FlutterMarkdown> {
  ScrollController controller = ScrollController();

  var _future;

  @override
  void dispose() {
    String key = 'assets/test_markdown/README.md';
    double val = controller.offset;
    saveFileReadStatus(key, val).then((value) {
      controller.dispose();
      super.dispose();
    });
  }

  @override
  void initState() {
    _future = readFile();
    super.initState();
    // jumpToPosition();
    // controller.addListener(() {});
  }

  readFile() async {
    var data = await rootBundle.loadString('assets/test_markdown/README.md');
    return data;
  }

  jumpToPosition() async {
    var val = await getFileReadStatus('assets/test_markdown/README.md');
    controller.animateTo(val,
        duration: Duration(milliseconds: 100), curve: Curves.bounceIn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Markdown(
              data: snapshot.data,
              controller: controller,
            );
          } else {
            return Center(
              child: Text("加载中..."),
            );
          }
        },
      ),
    );
  }
}
