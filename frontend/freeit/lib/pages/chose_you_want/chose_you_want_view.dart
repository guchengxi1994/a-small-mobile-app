/*
 * @Descripttion: 
 * @version: 
 * @Author: xiaoshuyui
 * @email: guchengxi1994@qq.com
 * @Date: 2021-07-03 09:05:35
 * @LastEditors: xiaoshuyui
 * @LastEditTime: 2021-07-03 09:05:35
 */

/// 分类页面
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freeit/utils/common.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:yaml/yaml.dart';

class ChoseWhatYouPreferredPage extends StatefulWidget {
  ChoseWhatYouPreferredPage({Key? key}) : super(key: key);

  @override
  _ChoseWhatYouPreferredPageState createState() =>
      _ChoseWhatYouPreferredPageState();
}

class _ChoseWhatYouPreferredPageState extends State<ChoseWhatYouPreferredPage> {
  late bool _isLoading;
  var _future;
  List _selected = [];
  late Map _map;

  final Color selectedColor = Colors.blue[100]!;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _future = loadData();
  }

  loadData() async {
    final data = await rootBundle.loadString('assets/classify/subject.yaml');
    final mapdata = loadYaml(data);
    return mapdata;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildBottomButtons(),
      appBar: AppBar(
        title: Text("请选择你感兴趣的类目"),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                setState(() {
                  _selected.sort();
                });
              },
              child: Text(
                "整理",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ))
        ],
      ),
      body: LoadingOverlay(
        isLoading: _isLoading,
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              _map = snapshot.data as Map;
              // print((snapshot.data as Map).keys.toList());
              return SingleChildScrollView(
                // child: Container(
                //   child: Text(snapshot.data.toString()),
                // ),
                child: Column(
                  children: [
                    Container(
                      width: CommonUtil.screenW(),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.all(10),
                      child: Text(
                        "你已选择了：",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      width: CommonUtil.screenW(),
                      color: Colors.grey[200],
                      height: _selected.length <= 3
                          ? _selected.length * 65.0
                          : (_selected.length / 2).ceil() * 85,
                      margin: EdgeInsets.all(10),
                      child: _selected.length <= 3
                          ? ListView.builder(
                              itemBuilder: (context, index) {
                                if (_selected.length > 0) {
                                  // return Container(
                                  //   child: Text(_selected[index]),
                                  // );
                                  return renderListItem(
                                      _selected[index], index);
                                } else {
                                  return Container();
                                }
                              },
                              itemCount: _selected.length,
                            )
                          : GridView.builder(
                              itemCount: _selected.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio:
                                    CommonUtil.screenW() * 0.4 / 70,
                              ),
                              itemBuilder: (context, index) {
                                return renderGridItem(_selected[index], index);
                              }),
                    ),
                    buildMainSubjects((snapshot.data as Map).keys.toList()),
                    Container(
                      height: 200,
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          future: _future,
        ),
      ),
    );
  }

  Widget buildMainSubjects(List<dynamic> l) {
    return Container(
      width: CommonUtil.screenW(),
      child: Wrap(
        children: l.map((e) {
          return ExpansionTile(
              children: renderSubitems(e.toString()),
              title: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  //设置四周圆角 角度
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  //设置四周边框
                  border: new Border.all(width: 1, color: Colors.red),
                ),
                child: Text(e.toString()),
              ));
        }).toList(),
      ),
    );
  }

  Widget buildSubclassItem(String main, String s) {
    String text = main + "-->" + s;
    return InkWell(
      onTap: () {
        if (!_selected.contains(text)) {
          setState(() {
            _selected.add(text);
          });
        }
      },
      child: Container(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.only(
              left: 0.1 * CommonUtil.screenW(), bottom: 10, top: 10),
          child: Text("|___    " + s),
        ),
      ),
    );
  }

  List<Widget> renderSubitems(String main) {
    var items = _map[main] as List;
    List<Widget> ws = [];
    for (var i in items) {
      ws.add(buildSubclassItem(main, i.toString()));
    }
    return ws;
  }

  Widget renderListItem(String content, int currentIndex) {
    return Card(
      child: Container(
        color: selectedColor,
        height: 55,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(content),
            ),
            InkWell(
              child: Icon(Icons.delete),
              onTap: () {
                setState(() {
                  _selected.removeAt(currentIndex);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBottomButtons() {
    return Container(
      width: CommonUtil.screenW(),
      // alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(onPressed: () {}, child: Text("确定")),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _selected.clear();
                });
              },
              child: Text("清空")),
          ElevatedButton(onPressed: () {}, child: Text("跳过")),
        ],
      ),
    );
  }

  Widget renderGridItem(String content, int currentIndex) {
    return Card(
      child: Container(
        alignment: Alignment.center,
        color: selectedColor,
        width: 0.4 * CommonUtil.screenW(),
        height: 70,
        child: ListTile(
          title: Text(content),
          trailing: InkWell(
            child: Icon(Icons.delete),
            onTap: () {
              setState(() {
                _selected.removeAt(currentIndex);
              });
            },
          ),
        ),
        // child: Column(
        //   children: [
        //     Container(
        //       padding: EdgeInsets.only(left: 10, top: 10, right: 10),
        //       alignment: Alignment.topLeft,
        //       child: Text(content),
        //     ),
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.end,
        //       children: [
        //         InkWell(
        //           child: Icon(Icons.delete),
        //           onTap: () {
        //             setState(() {
        //               _selected.removeAt(currentIndex);
        //             });
        //           },
        //         ),
        //       ],
        //     )
        //   ],
        // ),
      ),
    );
  }
}
