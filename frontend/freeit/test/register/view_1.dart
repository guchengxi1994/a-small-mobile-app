import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freeit/pages/loginAndRegist/register/view_2.dart';
import 'package:freeit/pages/loginAndRegist/register/widgets/jdText.dart';

class RegisterFirstPage extends StatefulWidget {
  RegisterFirstPage({Key? key}) : super(key: key);

  _RegisterFirstPageState createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户注册-第一步'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            JdText(
              text: "请输入密码",
              password: true,
            ),
            SizedBox(height: 20),
            // JdButton(
            //   text: "下一步",
            //   color: Colors.red,
            //   cb: () {
            //     // Navigator.pushNamed(context, '/RegisterSecond');
            //     Navigator.of(context)
            //         .push(MaterialPageRoute(builder: (context) {
            //       return RegisterSecondPage();
            //     }));
            //   },
            // )
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return RegisterSecondPage();
                }));
              },
              child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                height: 68,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "下一步",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
