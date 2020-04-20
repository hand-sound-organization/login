import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:handsound/configs/themes.dart';
import 'package:handsound/home_page.dart';
import 'package:handsound/user_provider.dart';
import 'package:handsound/user.dart';
import 'package:handsound/theme.dart';
import '../bloc/theme.bloc.dart';
import 'package:handsound/login_page.dart';
import 'package:intl/intl.dart';

class MainDoorChainPage extends StatefulWidget {
  MainDoorChainPage({Key key}) : super(key: key);

  @override
  _MainDoorChainPageState createState() => new _MainDoorChainPageState();
}

class _MainDoorChainPageState extends State<MainDoorChainPage> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 9, minute: 30);

  DateTime selectedDate2 = DateTime.now();
  TimeOfDay selectedTime2 = TimeOfDay(hour: 9, minute: 30);
  GlobalKey<FormState> _SignInFormKey = new GlobalKey();

  bool isShowPassWord = false;

  Future<void> _selectDate() async {
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    setState(() {
      selectedDate = date;
    });
  }
  Future<void> _selectTime() async {
    final TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (time == null) return;

    setState(() {
      selectedTime = time;
    });
  }

  Future<void> _selectDate2() async {
    final DateTime date = await showDatePicker(
//      builder: (BuildContext context, Widget child) {
//        return Theme(
//          data: ThemeData.dark(),
//          child: child,
//        );
//      },
      context: context,
      initialDate: selectedDate2,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    setState(() {
      selectedDate2 = date;
    });
  }
  Future<void> _selectTime2() async {
    final TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: selectedTime2,
    );

    if (time == null) return;

    setState(() {
      selectedTime2 = time;
    });
  }
  @override
  void initState() {
    super.initState();
    themeBloc.changeTheme(Themes.stayfit);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }

  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }
  Widget buildSignInTextForm() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: _selectDate,
                child: Row(
                  children: <Widget>[
                    Text(DateFormat.yMMMMd().format(selectedDate)),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
              InkWell(
                onTap: _selectTime,
                child: Row(
                  children: <Widget>[
                    Text(selectedTime.format(context)),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: _selectDate2,
                child: Row(
                  children: <Widget>[
                    Text(DateFormat.yMMMMd().format(selectedDate2)),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
              InkWell(
                onTap: _selectTime2,
                child: Row(
                  children: <Widget>[
                    Text(selectedTime2.format(context)),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
//      Container(
//        height: 200,
//        color: CupertinoColors.white,
//        child: DefaultTextStyle(
//          style: const TextStyle(
//            color: CupertinoColors.black,
//            fontSize: 22.0,
//          ),
//          child:
//          CupertinoDatePicker(
//            minimumDate: DateTime.now(),
//            maximumDate: DateTime.now().add(Duration(days: 7)),
//            use24hFormat: true,
//            mode: CupertinoDatePickerMode.dateAndTime,
//            initialDateTime: DateTime.now(),
//            onDateTimeChanged: (date) {
//
//            },
//          ),
    //  ));
//      new Container(
//      decoration:
//      new BoxDecoration(
//          borderRadius: BorderRadius.all(Radius.circular(8))
//          , color: Color(0x000000)
//      ),
//    );
  }

//  Widget buildSignInButton() {
//    return
//      new GestureDetector(
//        child: new Container(
//          padding: EdgeInsets.only(left: 50, right: 50, top: 2, bottom: 2),
//          decoration: new BoxDecoration(
//              borderRadius: BorderRadius.all(Radius.circular(25)),
//              //gradient: theme.Theme.primaryGradient,
//              color: Colors.white
//          ),
//          child: new IconButton(icon: Icon(Icons.arrow_forward,color: Color(0x90000000),),
//              iconSize: 35,
//              onPressed: null),
////          new Text(
////            "登录", style: new TextStyle(fontSize: 25, color: Colors.black),),
//        ),
//        onTap: () {
//          /**利用key来获取widget的状态FormState
//              可以用过FormState对Form的子孙FromField进行统一的操作
//           */
//          if (_SignInFormKey.currentState.validate()) {
//            //如果输入都检验通过，则进行登录操作
//
//            Scaffold.of(context).showSnackBar(
//                new SnackBar(content: new Text("绑定成功")));
//            //调用所有自孩子的save回调，保存表单内容
//            _SignInFormKey.currentState.save();
//
//            Navigator.push(
//                context, MaterialPageRoute(
//                builder: (BuildContext context) {
//                  return UserContainer(user: User(EtextEditingController.text,PtextEditingController.text), child: new HomePage());
//                }
//            )
//            );
//
//          }
////          debugDumpApp();
//        },
//
//      );
//  }

//  Widget build(BuildContext context) {
//    Size size = MediaQuery.of(context).size;
//    // TODO: implement build
//    return Scaffold(
//      body: Column(
//        children: <Widget>[
//          Expanded(
//            child: Stack(
//              fit: StackFit.expand,
//              children: <Widget>[
//                Image.network(
//                  'https://www.debuda.net/wp-content/uploads/2017/11/como-decorar-una-habitacion-para-meditar.jpg',
//                  fit: BoxFit.cover,
//                ),
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
//                  top: 40,
//                  width: size.width,
//                  child: Padding(
//                    padding: const EdgeInsets.symmetric(horizontal: 20),
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        Container(
//                          width: 65,
//                          alignment: Alignment.centerLeft,
//                          child: Icon(
//                            Icons.menu,
//                            color: Colors.white,
//                          ),
//                        ),
//                        Text(
//                          '门锁绑定',
//                          textAlign: TextAlign.center,
//                          style: TextStyle(
//                            color: Colors.white,
//                            fontWeight: FontWeight.bold,
//                            fontSize: 25,
//                          ),
//                        ),
//                        Row(
//                          children: <Widget>[
//                            SizedBox(width: 10),
//                            Icon(
//                              Icons.edit,
//                              color: Colors.white,
//                            ),
//                          ],
//                        )
//                      ],
//                    ),
//                  ),
//                ),
//
//                Positioned(
//                  top:250,
//                  left: 40,
//                  width: size.width/1.2,
//                  height: size.height/2.5,
//                  child: Stack(
//                    fit:StackFit.expand,
//                    children: <Widget>[
//                      buildSignInTextForm(),
//                    ],
//                  ),
//                ),
////                Positioned(child: buildSignInButton(), top: 500,left: 135,)
//              ],
//            ),
//          ),
//        ],
//      ),
//    );
//  }
}