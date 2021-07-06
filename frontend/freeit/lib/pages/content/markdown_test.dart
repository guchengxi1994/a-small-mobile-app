import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:freeit/utils/shared_preference_utils.dart';

GlobalKey<_FlutterMarkdownState> globalKey = GlobalKey();

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
          actions: [
            InkWell(
              onTap: () async {
                await globalKey.currentState!.jumpToPosition();
              },
              child: Icon(
                Icons.arrow_downward,
                color: Colors.black,
              ),
              // child: Text("跳转到上次阅读"),
            ),
          ],
        ),
        body: FlutterMarkdown(
          key: globalKey,
        ),
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
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _future = readFile();
    super.initState();
  }

  readFile() async {
    var data = await rootBundle.loadString('assets/test_markdown/README.md');
    return data;
  }

  jumpToPosition() async {
    var val = await getFileReadStatus('assets/test_markdown/README.md');
    print("============" + val.toString());
    controller.animateTo(val,
        duration: Duration(milliseconds: 100), curve: Curves.bounceIn);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Container(
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
        ),
        onWillPop: () async {
          await _onwillpop();
          return true;
        });
  }

  Future _onwillpop() async {
    String key = 'assets/test_markdown/README.md';
    double val = controller.offset;
    saveFileReadStatus(key, val);
  }
}
