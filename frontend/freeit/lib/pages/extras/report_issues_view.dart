import 'package:flutter/material.dart';
import 'package:freeit/utils/common.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReportIssuesPage extends StatefulWidget {
  ReportIssuesPage({Key? key}) : super(key: key);

  @override
  _ReportIssuesPageState createState() => _ReportIssuesPageState();
}

class _ReportIssuesPageState extends State<ReportIssuesPage> {
  List<String> adType = ['功能异常', '产品建议', '其他问题'];
  dynamic selectedAdType = [];
  String _adType = '';
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("感谢你的宝贵意见！"),
          leading: InkWell(
            child: Icon(Icons.chevron_left),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 20),
                    width: CommonUtil.screenW() * 0.95,
                    alignment: Alignment(0, 0),
                    child: Card(
                      child: Container(
                        // height: 150,
                        // width: Adapt.screenW() * 0.8,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text("反馈类型"),
                              // leading: Icon(Icons.ac_unit),
                              leading: Container(
                                width: 20,
                                height: 20,
                                child: Icon(
                                  Icons.search,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                            Container(
                              child: Divider(),
                              // width: Adapt.screenW() * 0.75,
                            ),
                            Container(
                              // child: getAdTypes(adType),
                              child: getDropdownAdtype(adType),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              width: CommonUtil.screenW() * 0.95,
                              alignment: Alignment(0, 0),
                              child: Card(
                                child: Container(
                                  height: 350,
                                  // width: Adapt.screenW() * 0.8,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text("反馈建议"),
                                        // leading: Icon(Icons.access_alarm_sharp),
                                        leading: Container(
                                          width: 20,
                                          height: 20,
                                          child: Icon(
                                            Icons.message,
                                            color: Colors.blueAccent,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Divider(),
                                        // width: Adapt.screenW() * 0.75,
                                      ),
                                      Container(
                                        child: TextField(
                                          controller: textEditingController,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText:
                                                  "请阐述你的问题和意见，以便我们提供更好的帮助。"),
                                          // controller: controller,
                                          maxLength:
                                              300, //最大长度，设置此项会让TextField右下角有一个输入数量的统计字符串
                                          maxLines: 9, //最大行数
                                          // autocorrect: true, //是否自动更正
                                          // autofocus: true, //是否自动对焦
                                          // obscureText: true, //是否是密码

                                          textAlign: TextAlign.start, //文本对齐方式
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.black), //输入文本的样式
                                          // inputFormatters: [
                                          //   WhitelistingTextInputFormatter.digitsOnly
                                          // ], //允许的输入格式
                                          // onChanged: (text) {
                                          //   //内容改变的回调
                                          //   print('change $text');
                                          // },
                                          // onSubmitted: (text) {
                                          //   //内容提交(按回车)的回调
                                          //   print('submit $text');
                                          // },
                                          enabled: true, //是否禁用
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                              ),
                              height: 40,
                              margin: EdgeInsets.only(top: 20, bottom: 20),
                              width: CommonUtil.screenW() * 0.9,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (selectedAdType == [] ||
                                      textEditingController.text == "") {
                                    Fluttertoast.showToast(
                                        msg: "请填写建议内容",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.orange,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  } else {
                                    // sendAdvice();
                                    Future.delayed(Duration.zero).then((value) {
                                      Fluttertoast.showToast(
                                          msg: "感谢你的意见反馈",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.orange,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    });
                                  }
                                },
                                child: Text(
                                  "提交",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }

  Widget getDropdownAdtype(List l) {
    return Container(
      child: DropdownButton(
        hint: Container(
          width: CommonUtil.screenW() * 0.8,
          child: Text(
            _adType == "" ? "请选择反馈类型" : _adType,
            style: _adType == ""
                ? TextStyle(
                    color: Colors.blue,
                  )
                : null,
          ),
        ),
        // isExpanded: true,
        items: l.map((e) {
          return DropdownMenuItem(
            value: e,
            child: Text(e.toString()),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _adType = value.toString();
          });
        },
      ),
    );
  }
}
