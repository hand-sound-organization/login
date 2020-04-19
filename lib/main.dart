import 'package:flutter/material.dart';
import 'package:handsound/door_chain/main_door_chain_page.dart';
import 'package:handsound/home_page.dart';
import 'package:handsound/lock_binding/binging_lock_page.dart';
import 'package:handsound/lock_binding/firt_binding_page.dart';
import 'package:handsound/sign_in_page.dart';
import 'package:handsound/user_provider.dart';
import 'package:handsound/user.dart';
import 'user management/main_user_management.dart';
import 'lock_sign_up/lock_sign_up_page.dart';
import 'user management/rename_or_delete_page.dart';


void main() {
//  debugPaintSizeEnabled=true;
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  String url;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'TheGorgeousLogin',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "main_user_management_page":(context)=>MainUserManage(),
        "sign_in_page":(context)=>SignInPage(),
        "lock_sign_up_page":(context)=>LockSignUpPage(),
        "rename_or_delete_page":(context)=>RenameOrDeletePage(),
        "main_door_chain_page":(context)=>MainDoorChainPage(),
        "first_bingding_page":(context)=>FirstBingdingPage(),
        "bingding_lock_page":(context)=>BingdingLockPage()
      },
      home:
      /**
       * 将用户数据共享给子控件，任何地方的子控件都可以获取到父控件所保存的用户信息
       * 根据有没有用户信息，进入不同的页面
       */
//      new UserContainer(user:new User("冬瓜","123456"),child: new HomePage(),),
      new UserContainer(user: null, child: new HomePage(),
      ),
    );
  }
}
