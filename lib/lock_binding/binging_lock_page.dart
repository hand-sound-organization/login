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
  @override
  void initState() {
    super.initState();
    themeBloc.changeTheme(Themes.stayfit);

  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
//                Image.network(
//                  'https://www.debuda.net/wp-content/uploads/2017/11/como-decorar-una-habitacion-para-meditar.jpg',
//                  fit: BoxFit.cover,
//                ),
                DecoratedBox(
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
                ),
                Positioned(
                  top: 40,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 65,
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            iconSize: 30,
                            icon:Icon(Icons.arrow_back),
                            color: Colors.white,
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        Text(
                          '门锁绑定',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 10),
                            Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top:150,
                  left: 100,
                  child: Image(image: new AssetImage("assets/logo1.png")),
                ),
                Positioned(
                  top:430,
                  left: 40,
                  width: size.width/1.2,
                  height: size.height/2.5,
                  child: Stack(
                    fit:StackFit.expand,
                    children: <Widget>[
                      buildSignInTextForm()
                    ],
                  ),
                ),
                Positioned(child: buildSignInButton(), top: 700,left: 135,)
              ],
            ),
          ),
        ],
      ),
    );
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
                      if (focusScopeNode == null) {
                        focusScopeNode = FocusScope.of(context);
                      }
                      focusScopeNode.requestFocus(passwordFocusNode);
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
              width: 250,
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
                      if (focusScopeNode == null) {
                        focusScopeNode = FocusScope.of(context);
                      }
                      focusScopeNode.requestFocus(passwordVerFocusNode);
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
              width: 250,
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
              width: 250,
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
        onTap: () {
          /**利用key来获取widget的状态FormState
              可以用过FormState对Form的子孙FromField进行统一的操作
           */
          if (_SignInFormKey.currentState.validate()) {
            //如果输入都检验通过，则进行登录操作

//            Scaffold.of(context).showSnackBar(
//                new SnackBar(content: new Text("绑定成功")));
            //调用所有自孩子的save回调，保存表单内容
            _SignInFormKey.currentState.save();
            print('666');
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