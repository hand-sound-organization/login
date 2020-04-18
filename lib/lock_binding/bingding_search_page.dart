import 'dart:io';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handsound/login_page.dart';
import 'package:handsound/sign_in_page.dart';
import '../bloc/theme.bloc.dart';
import '../configs/themes.dart';
import 'progress_bar.dart';
import 'package:handsound/user_provider.dart';
import 'package:handsound/user.dart';
import 'package:handsound/lock_sign_up/lock_sign_up_page.dart';
import 'binging_lock_page.dart';

class BingdingSearchPage extends StatefulWidget {
  BingdingSearchPage({Key key}) : super(key: key);

  _BingdingSearchPage createState() => _BingdingSearchPage();
}

class _BingdingSearchPage extends State<BingdingSearchPage> {

  @override
  void initState() {
    super.initState();
    themeBloc.changeTheme(Themes.stayfit);
    _openModalBottomSheet();

  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                          '门锁注册',
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
                  top: 0,
                  width: size.width,
                  height: size.height - size.height * .3,
                  child: Stack(

                    fit: StackFit.loose,
                    children: <Widget>[
                      new FlareActor(
                        "assets/wifi.flr",
                        alignment: Alignment.center,
                        fit: BoxFit.none,
                        animation: "wifi",
                      ),
                    ],
                  ),
                ),
                Positioned(
//                  bottom: 100,
//                  left: 40,
//                    child:Card(
//                      color: Colors.blueAccent,
//                      //z轴的高度，设置card的阴影
//                      elevation: 20.0,
//                      //设置shape，这里设置成了R角
//                      shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.only(
//                            topLeft: Radius.circular(5.0),
//                            topRight: Radius.circular(40.0),
//                            bottomLeft: Radius.circular(5.0),
//                            bottomRight: Radius.circular(5.0)),
//                      ),
//                      clipBehavior: Clip.antiAlias,
//                      semanticContainer: false,
//                      child: getChild(),
//                    )

                child: Container(
//                  padding: EdgeInsets.all(16),
//                  child: Center(
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//                        FlatButton(
//                          child: Text('Modal BottomSheet'),
//                          onPressed: _openModalBottomSheet,
////                  onPressed: () {
////                    showDialog<Null>(
////                      context: context,
////                      builder: (BuildContext context) {
////                        return new SimpleDialog(
////                          title: new Text('选择'),
////                          children: <Widget>[
////                            new SimpleDialogOption(
////                              child: new Text('选项 1'),
////                              onPressed: () {
////                                Navigator.of(context).pop();
////                              },
////                            ),
////                            new SimpleDialogOption(
////                              child: new Text('选项 2'),
////                              onPressed: () {
////                                Navigator.of(context).pop();
////                              },
////                            ),
////                          ],
////                        );
////                      },
////                    ).then((val) {
////                      print(val);
////                    });
////                  },
//                        ),
//                      ],
//                    ),
//                  ),
                ),
                ),
              ],
            ),
          ),


//          Container(
//            width: size.width,
//            height: size.height * .28,
//            child: Row(
//              children: <Widget>[
//                _buildDashboardItem(
//                  Color(0xFF23BFFF),
//                  Icons.local_drink,
//                  70,
//                  '0.58',
//                  'LTRS',
//                  'DRINK',
//                ),
//                _buildDashboardItem(
//                  Color(0xFF9CDD5D),
//                  Icons.fastfood,
//                  50,
//                  '458',
//                  'GRMS.',
//                  'FOOD',
//                  true,
//                ),
//                _buildDashboardItem(
//                  Color(0xFFEF453C),
//                  Icons.hotel,
//                  30,
//                  '7.30',
//                  'HRS',
//                  'SLEEP',
//                ),
//              ],
//            ),
//          ),


        ],
      ),
    );




  }

  Widget _buildDashboardItem(Color color, IconData icon,
      double completedPercentage, String value, String unit, String name,
      [bool useLight = false]) {
    List<Color> colors = [
      Color(0xFF311b5b),
      Color(0xFF221441),
    ];

    if (useLight) {
      colors = [
        Color(0xFF311b5b),
        Color(0xFF321c5c),
      ];
    }

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomPaint(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          value,
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          unit,
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  foregroundPainter: ProgressPainter(
                    percentageCompletedCircleColor: color,
                    completedPercentage: completedPercentage,
                    circleWidth: 10.0,
                  ),
                ),
              ),
            ),
            Container(
              height: 60,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    icon,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _openModalBottomSheet(){
//    showModalBottomSheet(
//        context: context,
//        builder: (BuildContext context){
//          return Container(
//            decoration: BoxDecoration(
//              boxShadow: [
//                BoxShadow(
//                  color: Colors.white,
//                  offset: Offset(0.0, -2.0),
//                  blurRadius: 4.0,
//                ),
//              ],
//              borderRadius: BorderRadius.only(
//                topLeft: Radius.circular(24.0),
//                topRight: Radius.circular(24.0),
//              ),
//
//            ),
//            height: 100,
////            child: Column(
////              children: <Widget>[
////                ListTile(
////                  title: Text('Option A'),
////                ),
////                ListTile(
////                  title: Text('Option B'),
////                ),
////                ListTile(
////                  title: Text('Option C'),
////                ),
////              ],
////            ),
////              child:Card(
////                color: Colors.blueAccent,
////                //z轴的高度，设置card的阴影
////                elevation: 20.0,
////                //设置shape，这里设置成了R角
////                shape: RoundedRectangleBorder(
////                  borderRadius: BorderRadius.only(
////                      topLeft: Radius.circular(40.0),
////                      topRight: Radius.circular(40.0),
////                      bottomLeft: Radius.circular(5.0),
////                      bottomRight: Radius.circular(5.0)),
////                ),
////                clipBehavior: Clip.antiAlias,
////                semanticContainer: false,
////                child: getChild(),
////              )
//          );
//        }
//    );
    Future.delayed(Duration(seconds: 2), (){
//      Navigator.of(context).pop();
//      print('延时1s执行');
      showModalBottomSheet(
          backgroundColor: Color(0x000000),
          context: context,
          builder: (BuildContext bc) {
            return Stack(
              children: <Widget>[
//              Container(
//                height: 30.0,
//                width: double.infinity,
////                color: Colors.black54,
//              color: Color(0xFF382d4f),
//              ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      )),
                ),
                Container(
                  child: FlatButton(
//                  color: Colors.red,
                    child: Container(
//                    color: Colors.white,
                      alignment: Alignment.center,
                      padding:
                      EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: Text(
                        "bottomSheet的内容",
                      ),
                    ),
                    onPressed: (){
                      Navigator.push(
                          context, MaterialPageRoute(
                          builder: (BuildContext context) {
                            return UserContainer(user: User('1','1'), child: new BingdingLockPage());
                          }
                      )
                      );
                    },
                  ),
                ),
              ],
            );
          });
    });


  }

  getChild() {
    return Container(
      width:300,
      height: 140,
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(
              builder: (BuildContext context) {
                return UserContainer(user: User('1','1'), child: new LockSignUpPage());
              }
          )
          );
        },
        // Generally, material cards use onSurface with 12% opacity for the pressed state.
//        splashColor:
//        Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
//        // Generally, material cards do not have a highlight overlay.
//        highlightColor: Colors.transparent,),
        child: new Container(
        //设置child 居中
        alignment: Alignment(0, 0),
        child: Text("开始注册",style: TextStyle(color: Colors.white,fontSize: 16.0),),
      ),),);
  }
}


