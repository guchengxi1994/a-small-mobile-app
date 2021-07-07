import 'package:flutter/material.dart';
import 'package:freeit/pages/loginAndRegist/register/widgets/jdText.dart';

class RegisterThirdPage extends StatefulWidget {
  RegisterThirdPage({Key? key}) : super(key: key);

  _RegisterThirdPageState createState() => _RegisterThirdPageState();
}

class _RegisterThirdPageState extends State<RegisterThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户注册-第三步'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10),
            JdText(
              text: "请输入密码",
              password: true,
            ),
            SizedBox(height: 10),
            JdText(
              text: "请输入确认密码",
              password: true,
            ),
            SizedBox(height: 10),
            InkWell(
              child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                height: 68,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "确认",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//