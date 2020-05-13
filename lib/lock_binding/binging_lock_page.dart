import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:handsound/configs/themes.dart';
import 'package:handsound/home_page.dart';
import 'package:handsound/main_page/pages/profile.dart';
import 'package:handsound/user_provider.dart';
import 'package:handsound/user.dart';
import 'package:handsound/theme.dart';
import '../bloc/theme.bloc.dart';
import 'package:handsound/login_page.dart';
import 'dart:io';

class BingdingLockPage extends StatefulWidget {
  BingdingLockPage({Key key}) : super(key: key);

  @override
  _BingdingLockPageState createState() => new _BingdingLockPageState();
}

class _BingdingLockPageState extends State<BingdingLockPage> {
  FocusNode emailFocusNode = new FocusNode();
  FocusNode passwordFocusNode = new FocusNode();
  FocusNode passwordVerFocusNode = new FocusNode();
  FocusScopeNode focusScopeNode = new FocusScopeNode();
  TextEditingController EtextEditingController = new TextEditingController();
  TextEditingController PtextEditingController = new TextEditingController();
  TextEditingController P2textEditingController = new TextEditingController();
  GlobalKey<FormState> _SignInFormKey = new GlobalKey();

  bool isShowPassWord = false;
  String IP;
  int PORT;
  User user;
  verify(String lockid,String username,String password)async{
    bool result;
    String responseBody;
    try{
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.getUrl(
          Uri(scheme: "http",path: "/app/locksignup",host: "192.168.0.107",port: 5000,queryParameters: {
            "username":username,
            "lock_id":lockid,
          })
      );

      HttpClientResponse response = await request.close();
      String responseBody = await response.transform(utf8.decoder).join();
      print(responseBody);
      Map data = jsonDecode(responseBody);
      print(data);
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
  SearchAndLink()async{
    User user = UserContainer.of(context).user;
    await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0)
        .then((RawDatagramSocket socket) {
      print('Sending from ${socket.address.address}:${socket.port}');
      int port = 1901;
      socket.broadcastEnabled = true;
      Future.delayed(Duration(seconds: 1));
      socket.send("LOCK-SEARCH".codeUnits, InternetAddress("255.255.255.255"), port);
      socket.listen((event) {
        if(event == RawSocketEvent.read) {
          var  data = Utf8Codec().decode(socket.receive().data);
          print(data);
          if( data.contains("Touch Voice SSDP Standard Response")){
            IP = data.substring(data.indexOf('//') + ('//').length, data.indexOf('::'));
            PORT = int.parse(data.substring( data.indexOf('::') + ('::').length,data.indexOf('|') ));
            print(IP);
            print(PORT);
//            print(data.contains("Touch Voice SSDP Standard Response"));
          }
        }
      }
      );
    });
    Future.delayed(Duration(seconds: 1), () async{
      var Psocket = await Socket.connect(InternetAddress(IP), PORT);
      Psocket.add(
          '{"PAGEID":1,'
          '"USERNAME":"${user.username}",'
          '"LOCKID":"${EtextEditingController.text}",'
          '"TOKEN":"${PtextEditingController.text}",'
          '"MEMBERLIST":[],'
          '"DATASTART":[],'
          '"DATAEND":[],'
          '"DATALIST":[],'
          '"IsOver":"True"'
          '}'
          .codeUnits);
//      Psocket.add("END".codeUnits);
      //Navigator.of(context).pushNamed("bingding_lock_page");z
    });
  }
  @override
  void initState() {
    super.initState();
    themeBloc.changeTheme(Themes.stayfit);

  }
  @override
  Widget build(BuildContext context) {
    user = UserContainer.of(context).user;
    Size size = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFa06f9c).withOpacity(0.95),
                Color(0xFF1610a6).withOpacity(0.75),
              ],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
            ),
          ),
          child: Column(
            children: <Widget>[
              AppBar(
                title: Text("门锁注册",style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                ),),
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  iconSize: 30,
                  icon:Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
                elevation: 0,
                centerTitle: true,
              ),
              Container(
                height: size.height*0.4,
                width: size.width,

                child: Padding(
                  padding: EdgeInsets.only(top: size.height*0.02,left: size.width*0.1,right: size.width*0.1),
                  child: Image(image: new AssetImage("assets/login_logo.png")),
                ),
              ),

//              SizedBox(height: size.height*0.03,),
              SizedBox(width:size.width*0.8,height:size.height*0.3,child: buildSignInTextForm(),),
              SizedBox(height: size.height*0.02,),
              buildSignInButton()
//            buildSignInTextForm()
              //buildSignInTextForm(size)

              //buildSignInButton()
            ],
          ),
        ),
      ),
    );

//      Scaffold(
//      resizeToAvoidBottomPadding:false,
//      //resizeToAvoidBottomInset: false,
//      body: Column(
//        children: <Widget>[
//          Expanded(
//            child: Stack(
//              fit: StackFit.expand,
//              children: <Widget>[
//                DecoratedBox(
//                  decoration: BoxDecoration(
//                    gradient: LinearGradient(
//                      colors: [
//                        Color(0xFFa06f9c).withOpacity(0.95),
//                        Color(0xFF1610a6).withOpacity(0.75),
//                      ],
//                      begin: FractionalOffset.topCenter,
//                      end: FractionalOffset.bottomCenter,
//                    ),
//                  ),
//                ),
//                Positioned(
////                  top: 40,
//                  width: size.width,
//                  child: Padding(
//                    padding:  EdgeInsets.symmetric(horizontal: size.width*0.05),
//                    child: AppBar(
//                      leading: IconButton(
//                        iconSize: 30,
//                        icon:Icon(Icons.arrow_back),
//                        color: Colors.white,
//                        onPressed: (){
//                          Navigator.of(context).pop();
//                        },
//                      ),
//                      title: Text("设备搜索",style: TextStyle(
//                        color: Colors.white,
//                        fontWeight: FontWeight.bold,
//                        fontSize: 25,
//                      ),),
//                      centerTitle: true,
//                      backgroundColor: Color(0x000000),
//                      elevation: 0,
//                    ),
//                  ),
//                ),
//                Positioned(
//                  top:size.height*0.2,
//                  left: size.width*0.213,
//                  child: Image(image: new AssetImage("assets/logo.png")),
//                ),
//                Positioned(
//                  top:size.height*0.535,
//                  left: size.width*0.08,
//                  width: size.width/1.2,
//                  height: size.height/2.5,
//                  child: Stack(
//                    fit:StackFit.expand,
//                    children: <Widget>[
//                      buildSignInTextForm(size)
//                    ],
//                  ),
//                ),
//                Positioned(child: buildSignInButton(), top: size.height*0.87,left: size.width*.31,)
//              ],
//            ),
//          ),
//        ],
//      ),
//    );
  }
  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }
  Widget buildSignInTextForm() {
    return new Container(

      decoration:
      new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8))
          , color: Color(0x000000)
      ),
      //width: 500,
      //height: 190,
      /**
       * Flutter提供了一个Form widget，它可以对输入框进行分组，
       * 然后进行一些统一操作，如输入内容校验、输入框重置以及输入内容保存。
       */
      child: new Form(
        key: _SignInFormKey,
        //开启自动检验输入内容，最好还是自己手动检验，不然每次修改子孩子的TextFormField的时候，其他TextFormField也会被检验，感觉不是很好
//        autovalidate: true,
        child: new Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 0, right: 0, top: 10, bottom: 10),
                child: Container(
                  padding: EdgeInsets.only(
                    left: 10, right: 10, ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: Colors.white,
                  ),
                  child: new TextFormField(
                    //关联焦点
                    controller: EtextEditingController,
                    focusNode: emailFocusNode,
                    onEditingComplete: () {
//                      if (focusScopeNode == null) {
//                        focusScopeNode = FocusScope.of(context);
//                      }
//                      focusScopeNode.requestFocus(passwordFocusNode);
                      FocusScope.of(context).requestFocus(passwordFocusNode);
                    },

                    decoration: new InputDecoration(
                        icon: new Icon(Icons.vpn_key, color: Colors.black,),
                        hintStyle: new TextStyle(color: Colors.grey),
                        hintText: "门锁ID",
                        hoverColor: Colors.black,
                        border: InputBorder.none
                    ),
                    style: new TextStyle(fontSize: 16, color: Colors.black),
                    //验证
                    validator: (value) {
                      if (value.isEmpty) {
                        return "请输入门锁ID！";
                      }
                    },
                    onSaved: (value) {

                    },
                  ),
                ),
              ),
            ),
            new Container(
              height: 1,
              //width:  20,
              //size.width*.637,
              color: Color(0x000000),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 0, right: 0, top: 10,bottom: 10),
                child: Container(
                  padding: EdgeInsets.only(
                    left: 10, right: 10, ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: Colors.white,
                  ),
                  child: new TextFormField(
                    controller: PtextEditingController,
                    focusNode: passwordFocusNode,
                    onEditingComplete: () {
//                      if (focusScopeNode == null) {
//                        focusScopeNode = FocusScope.of(context);
//                      }
//                      focusScopeNode.requestFocus(passwordVerFocusNode);
                      FocusScope.of(context).requestFocus(passwordVerFocusNode);
                    },
                    decoration: new InputDecoration(
                        icon: new Icon(Icons.lock, color: Colors.black,),
                        hintStyle: new TextStyle(color: Colors.grey),
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
            ),
            new Container(
              height: 1,
              //width:  30,
              //size.width*.637,
              color: Color(0x000000),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 0, right: 0, top: 10,bottom: 10),
                child: Container(
                  padding: EdgeInsets.only(
                    left: 10, right: 10, ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: Colors.white,
                  ),
                  child: new TextFormField(
                    controller: P2textEditingController,
                    focusNode: passwordVerFocusNode,
                    onEditingComplete: () {
//                      if (focusScopeNode == null) {
//                        focusScopeNode = FocusScope.of(context);
//                      }
//                      focusScopeNode.requestFocus(passwordVerFocusNode);
                    emailFocusNode.unfocus();
                    passwordFocusNode.unfocus();
                    passwordVerFocusNode.unfocus();
                    },
                    decoration: new InputDecoration(
                        icon: new Icon(Icons.lock, color: Colors.black,),
                        hintStyle: new TextStyle(color: Colors.grey),
                        hintText: "确认密码",
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
//                      if (value == null || value.isEmpty || value.length < 6) {
//                        return "密码需要大于6位！";
//                      }
                    if(value!=PtextEditingController.text){
                      return "两次输入密码不一致！";
                    }
                    },
                    onSaved: (value) {

                    },
                  ),
                ),
              ),
            ),
            new Container(
              height: 1,
              //width:30,
              //size.width*.637,
              color: Color(0x000000),
            ),


          ],
        ),),
    );
  }

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
            verify(EtextEditingController.text, user.username, user.password);
            SearchAndLink();

//            Scaffold.of(context).showSnackBar(
//                new SnackBar(content: new Text("绑定成功")));
            //调用所有自孩子的save回调，保存表单内容
            _SignInFormKey.currentState.save();
            Navigator.push(
                context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return UserContainer(user: User(EtextEditingController.text,PtextEditingController.text), child: new Profile());
                }
            )
            );

          }
          print('666');
//          debugDumpApp();
        },

      );
  }
}