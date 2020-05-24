import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:handsound/lock_binding/binging_lock_page.dart';
import 'package:handsound/lock_binding/bingding_search_page.dart';
import 'package:handsound/lock_binding/firt_binding_page.dart';
import 'package:handsound/theme.dart' as theme;
import 'package:handsound/firstpage.dart';
import 'home_page.dart';
import 'package:handsound/firstpage.dart';
import 'package:handsound/user_provider.dart';
import 'package:handsound/user.dart';
import 'lock_sign_up/lock_sign_up_page.dart';
import 'firstpage.dart';
import 'bottomsheet.dart';
import 'bottom2.dart';
import 'login_page.dart';
import 'sign_in_page.dart';
import 'user management/main_user_management.dart';
import 'door_chain/add_alarm.dart';
import 'package:handsound/main_page/pages/profile.dart';
import 'dart:io';
import 'dart:convert';
/**
 *注册界面
 */
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => new _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  /**
   * 利用FocusNode和FocusScopeNode来控制焦点
   * 可以通过FocusNode.of(context)来获取widget树中默认的FocusScopeNode
   */
  FocusNode emailFocusNode = new FocusNode();
  FocusNode passwordFocusNode = new FocusNode();
  FocusNode VpasswordFocusNode = new FocusNode();
  FocusScopeNode focusScopeNode = new FocusScopeNode();
  TextEditingController EtextEditingController = new TextEditingController();
  TextEditingController PtextEditingController = new TextEditingController();
  TextEditingController P2textEditingController = new TextEditingController();
  GlobalKey<FormState> _SignInFormKey = new GlobalKey();

  bool isShowPassWord = false;
  bool isShowPassWord2 = false;

  /**
   * 访问远端数据库进行验证
   */
  verify(String username,String password)async{
    bool result;
    String responseBody;
    try{
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.getUrl(
          Uri(scheme: "http",path: "/app/signup",host:"192.168.101.10",port:5000,queryParameters: {
            "username":username
          }));
      HttpClientResponse response = await request.close();
      String responseBody = await response.transform(utf8.decoder).join();
      Map data = jsonDecode(responseBody);
      return data;
      httpClient.close();
//      responseBody = await response.transform(utf8.decoder).join();
//      var data = jsonDecode(responseBody);
//      result = data['isTrue'];
//      print(data);
      //return result;
    }catch(e){
      print("666");
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return new Container(
      padding: EdgeInsets.only(top: size.height*0.0286),
      child: new Stack(
        alignment: Alignment.center,
//        /**
//         * 注意这里要设置溢出如何处理，设置为visible的话，可以看到孩子，
//         * 设置为clip的话，若溢出会进行裁剪
//         */
//        overflow: Overflow.visible,
        children: <Widget>[
          new Column(
            children: <Widget>[
              //创建表单
              buildSignInTextForm(size),


              /**
               * Or所在的一行
               */
//              Padding(padding: EdgeInsets.only(top: 10),
//                child: new Row(
////                          mainAxisSize: MainAxisSize.max,
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    new Container(height: 1,
//                      width: 100,
//                      decoration: BoxDecoration(
//                          gradient: new LinearGradient(
//                              colors: [ Colors.white10,
//                                Colors.white,
//                              ])
//                      ),
//                    ),
//                    new Padding(
//                      padding: EdgeInsets.only(left: 15, right: 15),
//                      child: new Text("Or", style: new TextStyle(
//                          fontSize: 16, color: Colors.white),),),
//                    new Container(height: 1,
//                      width: 100,
//                      decoration: BoxDecoration(
//                          gradient: new LinearGradient(
//                              colors: [ Colors.white,
//                                Colors.white10,
//                              ])
//                      ),
//                    ),
//                  ],
//                ),),
//
//              /**
//               * 显示第三方登录的按钮
//               */
//              new SizedBox(height: 10,),
//              new Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  new Container(
//                    padding: EdgeInsets.all(10),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
//                    child: new IconButton(icon: Icon(
//                      FontAwesomeIcons.facebookF, color: Color(0xFF0084ff),),
//                        onPressed: null),
//                  ),
//                  new SizedBox(width: 40,),
//                  new Container(
//                    padding: EdgeInsets.all(10),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.black,
//                    ),
//                    child: new IconButton(icon: Icon(
//                      FontAwesomeIcons.google, color: Color(0xFF0084ff),),
//                        onPressed: null),
//                  ),
//                ],
//              )


            ],
          ),
          new Positioned(child: buildSignInButton(), top: size.height*0.45,)
        ],
      ),
    );
  }

  /**
   * 点击控制密码是否显示
   */
  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }
  void showPassWord2() {
    setState(() {
      isShowPassWord2 = !isShowPassWord2;
    });
  }
  /**
   * 创建登录界面的TextForm
   */
  Widget buildSignInTextForm(Size size) {
    return new Container(
      decoration:
      new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8))
          , color: Colors.white
      ),
      width: size.width*.77,
      height: size.height*.4,
      /**
       * Flutter提供了一个Form widget，它可以对输入框进行分组，
       * 然后进行一些统一操作，如输入内容校验、输入框重置以及输入内容保存。
       */
      child: new Form(
        key: _SignInFormKey,
        //开启自动检验输入内容，最好还是自己手动检验，不然每次修改子孩子的TextFormField的时候，其他TextFormField也会被检验，感觉不是很好
//        autovalidate: true,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Container(
              height: 10,
              width: size.width*.637,
              color: Colors.white,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 20,bottom: 20),
                child: new TextFormField(
                  decoration: new InputDecoration(
                      icon: new Icon(Icons.email, color: Colors.black,),
                      hintStyle: new TextStyle(color: Colors.black),
                      hintText: "邮箱地址",
                      hoverColor: Colors.black,
                      border: InputBorder.none,
                  ),
                  //输入密码，需要用*****显示
                  style: new TextStyle(fontSize: 16, color: Colors.black),
                  validator: (value) {
                  },
                  onSaved: (value) {
                  },
                ),
              ),
            ),
            new Container(
              height: 1,
              width: size.width*.637,
              color: Colors.grey[400],
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 20, bottom: 20),
                child: new TextFormField(
                  //关联焦点
                  controller: EtextEditingController,
                  focusNode: emailFocusNode,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(passwordFocusNode);
//                    if (focusScopeNode == null) {
//                      focusScopeNode = FocusScope.of(context);
//                    }
//                    focusScopeNode.requestFocus(passwordFocusNode);
                  },

                  decoration: new InputDecoration(
                      icon: new Icon(FontAwesomeIcons.user, color: Colors.black,),
                      hintStyle: new TextStyle(color: Colors.black),
                      hintText: "用户名",
                      hoverColor: Colors.black,
                      border: InputBorder.none
                  ),
                  style: new TextStyle(fontSize: 16, color: Colors.black),
                  //验证
                  validator: (value) {
                    if (value.isEmpty) {
                      return "用户名不能为空！";
                    }
                  },
                  onSaved: (value) {

                  },
                ),
              ),
            ),
            new Container(
              height: 1,
              width: size.width*.637,
              color: Colors.grey[400],
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 20,bottom: 20),
                child: new TextFormField(
                  controller: PtextEditingController,
                  focusNode: passwordFocusNode,
                  decoration: new InputDecoration(
                      icon: new Icon(Icons.lock, color: Colors.black,),
                      hintStyle: new TextStyle(color: Colors.black),
                      hintText: "密码",
                      hoverColor: Colors.black,
                      border: InputBorder.none,
                      suffixIcon: new IconButton(icon: new Icon(
                        Icons.remove_red_eye, color: Colors.black,),
                          onPressed: showPassWord)
                  ),
                  //输入密码，需要用*****显示
                  obscureText: !isShowPassWord,
                  style: new TextStyle(fontSize: 16, color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      return "密码需要大于6位！";
                    }
                  },
                  onSaved: (value) {

                  },
                ),
              ),
            ),
            new Container(
              height: 1,
              width: size.width*.637,
              color: Colors.grey[400],
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 20,bottom: 20),
                child: new TextFormField(
                  controller: P2textEditingController,
                  focusNode: VpasswordFocusNode,
                  decoration: new InputDecoration(
                    suffixIcon: new IconButton(icon: new Icon(
                      Icons.remove_red_eye, color: Colors.black,),
                        onPressed: showPassWord2),
                      icon: new Icon(Icons.lock, color: Colors.black,),
                      hintStyle: new TextStyle(color: Colors.black),
                      hintText: "确认密码",
                      hoverColor: Colors.black,
                      border: InputBorder.none,
                  ),
                  //输入密码，需要用*****显示
                  obscureText: !isShowPassWord2,
                  style: new TextStyle(fontSize: 16, color: Colors.black),
                  validator: (value) {
                    if(value!=PtextEditingController.text){
                      return "两次输入密码不一致！";
                    }
                  },
                  onSaved: (value) {

                  },
                ),
              ),
            ),
            new Container(
              height: 1,
              width: size.width*.637,
              color: Colors.grey[400],
            ),



          ],
        ),),
    );
  }

  /**
   * 创建登录界面的按钮
   */
  Widget buildSignInButton() {
    return
      new GestureDetector(
        child: new Container(
          padding: EdgeInsets.only(left: 50, right: 50, top: 2, bottom: 2),
          decoration: new BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              //gradient: theme.Theme.primaryGradient,
              color: Colors.white
          ),
          child: new IconButton(icon: Icon(Icons.arrow_forward,color: Color(0x90000000),),
              iconSize: 35,
              onPressed: null),
//          new Text(
//            "登录", style: new TextStyle(fontSize: 25, color: Colors.black),),
        ),
        onTap: () async{
          /**利用key来获取widget的状态FormState
              可以用过FormState对Form的子孙FromField进行统一的操作
           */
          if (_SignInFormKey.currentState.validate()) {
            //如果输入都检验通过，则进行登录操作


            //调用所有自孩子的save回调，保存表单内容
            _SignInFormKey.currentState.save();
            Map result = await verify(EtextEditingController.text,PtextEditingController.text)as Map;
            print(result);
            if(result['IsTrue']==true){
              Scaffold.of(context).showSnackBar(
                  new SnackBar(content: new Text("注册成功")));
                  print("123123123123123123123");
                  Navigator.push(
                      context, MaterialPageRoute(
                      builder: (BuildContext context) {
                        return UserContainer(user: User(EtextEditingController.text,PtextEditingController.text), child: new LoginPage());
                      }
                  )
                  );
            }
            else{
              Scaffold.of(context).showSnackBar(
                  new SnackBar(content: new Text("连接错误")));
            }
            //bool result = verify(EtextEditingController.text,PtextEditingController.text) as bool;
//            bool result = await verify(EtextEditingController.text,PtextEditingController.text)as bool;
//            Navigator.of(context).pushNamed("door_chain_management");
//            if(result==true){
//              Scaffold.of(context).showSnackBar(
//                  new SnackBar(content: new Text("登录成功")));
//              Navigator.push( context,
//                  MaterialPageRoute(builder: (context) {
//                    return FirstBingdingPage();
//                  }));
//            }
//            else{
//              Scaffold.of(context).showSnackBar(
//                  new SnackBar(content: new Text("用户名或者密码输入错误")));
//            }
//            Navigator.push(
//                context, MaterialPageRoute(
//                builder: (BuildContext context) {
//                  return UserContainer(user: User(EtextEditingController.text,PtextEditingController.text), child: new MainUserManage());
//                }
//            )
//            );

          }
//          debugDumpApp();
        },

      );
  }
}