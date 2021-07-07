import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freeit/utils/common.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}

/// 登录相关
class _LoginPageState extends State<LoginPage> {
  // 焦点
  FocusNode _focusNodeUserName = FocusNode();
  FocusNode _focusNodePassWord = FocusNode();

  // 用户名输入框控制器，此控制器可以监听用户名输入框的操作
  TextEditingController _userNameController = TextEditingController();

  // 表单状态
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // 用户名、密码
  String? _username = "", _password = "";

  String fatherPageRouter = '';

  // 是否显示密码
  bool _isShowPwd = false;

  bool _isSelected = false;

  // 是否显示输入框尾部的清除按钮
  bool _isShowClear = false;

  bool _rememberState = false;

  /// 插入到渲染树时调用，只执行一次。（类似Android Fragment的onCreateView函数）
  @override
  void initState() {
    // TODO: implement initState
    // 设置焦点监听
    _focusNodeUserName.addListener(_focusNodeListener);
    _focusNodePassWord.addListener(_focusNodeListener);
    // 监听用户名框的输入改变
    _focusNodeUserName.addListener(() {
      print(_userNameController.text);

      // 监听输入变化，当有内容的时候，显示尾部清除按钮，否则不显示
      if (_userNameController.text.isNotEmpty) {
        _isShowClear = true;
      } else {
        _isShowClear = false;
      }
      // 调用setState 方法,重新调用build 进行渲染界面
      setState(() {});
    });

    // getFatherRouter().then((value) {
    //   fatherPageRouter = value;
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //　返回按钮
    Widget backImageArea = Container(
      height: 45,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 0),
      child: IconButton(
        // icon:
        icon: Icon(Icons.chevron_left_rounded),
        onPressed: () {
          print("返回------");
          if (mounted) {
            Navigator.pop(context);
          }
        },
      ),
    );

    // logo图片区域
    Widget logoImageArea = Container(
      margin: EdgeInsets.only(top: 20),
      alignment: Alignment.topCenter,
      child: Image.asset(
        CommonUtil.appIcon,
        width: 226,
        height: 130,
      ),
    );

    // 文本输入框区域
    Widget inputTextArea = Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      // 文本输入框区域的装饰
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white),
      // 使用Form将两个输入框包起来做控制
      child: Form(
        key: _formKey,
        // Form里面是一个垂直布局
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // 控件
          children: <Widget>[
            // 用户名
            TextFormField(
              controller: _userNameController,
              // 焦点控制
              focusNode: _focusNodeUserName,
              // 设置键盘类型
              keyboardType: TextInputType.number,
              // 输入框的装饰
              decoration: InputDecoration(
                  labelText: "用户名",
                  hintText: "请输入用户名",
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  // 尾部添加清除按钮
                  suffixIcon: (_isShowClear)
                      ? IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            // 清空文本框的内容
                            _userNameController.clear();
                          })
                      : null),
              // 校验用户名
              validator: validateUserName,
              // 保持数据
              onSaved: (String? value) {
                _username = value;
              },
            ),
            // 间隔
            SizedBox(height: 10),
            // 密码
            TextFormField(
              focusNode: _focusNodePassWord,
              decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "请输入密码",
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.blue,
                  ),
                  // 是否显示密码
                  suffixIcon: IconButton(
                      icon: Icon(
                        _isShowPwd ? Icons.visibility : Icons.visibility_off,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        setState(() {
                          _isShowPwd = !_isShowPwd;
                        });
                      })),
              obscureText: !_isShowPwd,
              // 校验密码
              validator: validatePassWord,
              // 保存数据
              onSaved: (String? value) {
                _password = value!;
              },
            )
          ],
        ),
      ),
    );

    // 忘记密码
    Widget forgetPwdArea = Container(
      margin: EdgeInsets.only(right: 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton(
              child: Text(
                "忘记密码？",
                style: TextStyle(color: Colors.black54),
              ),
              onPressed: () {
                print('找回密码');
              })
        ],
      ),
    );

    // 登录按钮区域
    Widget loginButtonArea = Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      height: 45,
      child: RaisedButton(
          color: Colors.blue[500],
          child: Text(
            "登录",
            style: TextStyle(color: Colors.white),
          ),
          // 设置圆角
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          onPressed: () async {}),
    );

    Widget skipLoginButtonArea = Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      height: 45,
      child: RaisedButton(
          color: Colors.blue[500],
          child: Text(
            "跳过",
            style: TextStyle(color: Colors.white),
          ),
          // 设置圆角
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          onPressed: () async {}),
    );

    Widget bottomButtonLists = Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            child: InkWell(
              child: Icon(
                Icons.check_box,
                size: 18,
                color: _rememberState ? Colors.blue : Colors.grey,
              ),
              onTap: () {
                setState(() {
                  if (_rememberState) {
                    _rememberState = false;
                  } else {
                    _rememberState = true;
                  }
                });
              },
            ),
          ),
          Container(
            child: Text("记住登陆状态"),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: TextButton(
              onPressed: () {},
              child: Text("注册"),
            ),
          )
        ],
      ),
    );

    // 组装widget组件，形成界面
    return Scaffold(
        backgroundColor: Colors.white,

        // 外层添加一个手势，用于点击空白部分，回收键盘
        body: GestureDetector(
          onTap: () {
            // 点击空白区域，回收键盘
            _focusNodeUserName.unfocus();
            _focusNodePassWord.unfocus();
          },
          child: ListView(
            children: <Widget>[
              backImageArea,
              logoImageArea,
              SizedBox(height: 60),
              inputTextArea,
              // forgetPwdArea,
              bottomButtonLists,
              SizedBox(height: 14),
              loginButtonArea,
              skipLoginButtonArea,
              Container(
                height: 40,
              ),
              getRadio(),
            ],
          ),
        ));
  }

  /// 销毁(类似于Android的onDestroy， 在执行Navigator.pop后会调用该办法， 表示组件已销毁；)
  @override
  void dispose() {
    // 移除焦点监听
    _focusNodeUserName.removeListener(_focusNodeListener);
    _focusNodePassWord.removeListener(_focusNodeListener);
    _userNameController.dispose();
    super.dispose();
  }

  // 监听焦点
  _focusNodeListener() async {
    if (_focusNodeUserName.hasFocus) {
      print("用户名框获取焦点");
      // 取消密码框的焦点状态
      _focusNodePassWord.unfocus();
    }

    if (_focusNodePassWord.hasFocus) {
      // 取消用户名框焦点状态
      _focusNodeUserName.unfocus();
    }
  }

  // 验证用户名
  String? validateUserName(String? value) {
    // 验证手机号
    if (null != value) {
      if (value.isEmpty) {
        return "用户名不能为空！";
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  // 验证密码
  String? validatePassWord(String? pwd) {
    // 正则验证密码

    if (null != pwd) {
      RegExp exp = RegExp("[a-zA-Z0-9_]{6,20}");
      if (pwd.isEmpty) {
        return "密码不能为空";
      } else if (!exp.hasMatch(pwd)) {
        return "请输入正确的6-20位数字、字母或下划线的密码";
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Widget getRadio() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: InkWell(
              onTap: () {
                setState(() {
                  if (_isSelected) {
                    _isSelected = false;
                  } else {
                    _isSelected = true;
                  }
                });
              },
              child: Icon(
                Icons.check_circle_outline,
                size: 18,
                color: _isSelected ? Colors.blue : Colors.grey,
              ),
            )),
            Container(
              child: Text("我已阅读并同意" + CommonUtil.appName),
            ),
            Container(
              child: InkWell(
                onTap: () {
                  // print("点击了书名");
                  if (mounted) {}
                },
                child: Text(
                  "《用户协议》",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text("以及"),
            ),
            Container(
              child: InkWell(
                onTap: () {
                  // print("点击了书名");
                  if (mounted) {}
                },
                child: Text(
                  "《隐私政策》",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ],
        )
      ],
    );
    // child: Text("我已阅读并同意《职小侠用户隐私协议》"),
  }
}
