import 'package:flutter/material.dart';
import 'package:freeit/pages/loginAndRegist/register/view_3.dart';
import 'package:freeit/pages/loginAndRegist/register/widgets/jdText.dart';

class RegisterSecondPage extends StatefulWidget {
  RegisterSecondPage({Key? key}) : super(key: key);

  _RegisterSecondPageState createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户注册-第二步'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              child: Text('请输入xxx手机收到的验证码'),
            ),
            Stack(
              children: <Widget>[
                JdText(
                  text: "请输入验证码",
                  password: true,
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: RaisedButton(
                    child: Text('重新发送'),
                    onPressed: () {},
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            // JdButton(
            //   text: "下一步",
            //   color: Colors.red,
            //   cb: () {
            //     Navigator.of(context)
            //         .push(MaterialPageRoute(builder: (context) {
            //       return RegisterThirdPage();
            //     }));
            //   },
            // )

            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return RegisterThirdPage();
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
