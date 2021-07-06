import 'package:after_layout/after_layout.dart';
import 'package:disable_screenshots/disable_screenshots.dart';
import 'package:flutter/material.dart';

class ContentTest extends StatefulWidget {
  ContentTest({Key? key}) : super(key: key);

  @override
  _ContentTestState createState() => _ContentTestState();
}

class _ContentTestState extends State<ContentTest>
    with AfterLayoutMixin<ContentTest> {
  // 初始化插件
  DisableScreenshots _plugin = DisableScreenshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("这是测试"),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _plugin.addWatermark(context, "默认水印", rowCount: 4, columnCount: 8);
  }
}
