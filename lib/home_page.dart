
import 'package:flutter/material.dart';
import 'package:handsound/lock_binding/firt_binding_page.dart';
import 'package:handsound/user.dart';
import 'package:handsound/user_provider.dart';
import 'package:handsound/login_page.dart';

class HomePage extends StatefulWidget {
//  HomePage(Key key ,this.user):super(key:key);
//  final String user;
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    /**
     * 根据是否有用户登录信息进入登录注册页面或者主页
        利用inheritedWidget，可以读取到父控件分享的数据
     */
    User user = UserContainer.of(context).user;
    if (user == null) {
      return new LoginPage();
    } else {
      return new Scaffold(
        body: new Container(
          child: new Center(
            child: new Text("用户已登录\n用户名:${user.username}\n密码：${user.password}"),
//            child:new Text('666666')
          ),
        ),
      );
    }
  }
}
