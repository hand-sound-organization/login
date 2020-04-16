import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:handsound/configs/themes.dart';
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
  FocusScopeNode focusScopeNode = new FocusScopeNode();
  TextEditingController EtextEditingController = new TextEditingController();
  TextEditingController PtextEditingController = new TextEditingController();
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
                Image.network(
                  'https://www.debuda.net/wp-content/uploads/2017/11/como-decorar-una-habitacion-para-meditar.jpg',
                  fit: BoxFit.cover,
                ),
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
                          child: Icon(
                            Icons.menu,
                            color: Colors.white,
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
                  top:250,
                  left: 70,
                  width: size.width/1.5,
                  height: size.height/2.5,
                  child: Stack(
                    fit:StackFit.expand,
                    children: <Widget>[
                      buildSignInTextForm()
                    ],
                  ),
                ),
                Positioned(
                    top:600,
                    left: 75,
                    width: size.width/1.5,
                    height: size.height - size.height * .28,
                    child:
                    new Text('请先绑定门锁再使用完整功能',
                      textAlign:TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                      ),)
                )
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
          , color: Colors.white
      ),
      width: 300,
      height: 190,
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
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 20, bottom: 20),
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
              width: 250,
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
              width: 250,
              color: Colors.grey[400],
            ),


          ],
        ),),
    );
  }
}