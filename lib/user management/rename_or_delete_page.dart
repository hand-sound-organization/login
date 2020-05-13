

import 'dart:io';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:handsound/login_page.dart';
import 'package:handsound/sign_in_page.dart';
import '../bloc/theme.bloc.dart';
import '../configs/themes.dart';
import '../lock_sign_up/progress_bar.dart';
import 'package:handsound/user_provider.dart';
import 'package:handsound/user.dart';


class RenameOrDeletePage extends StatefulWidget {
//  final parentContext;
  RenameOrDeletePage({Key key} ) : super(key: key);

  _RenameOrDeletePageState createState() => _RenameOrDeletePageState();
}

class _RenameOrDeletePageState extends State<RenameOrDeletePage> {
  TextEditingController _selectionController =  TextEditingController();
  String name;

  @override
  void initState() {
    super.initState();
    themeBloc.changeTheme(Themes.stayfit);
    Future.delayed(Duration(milliseconds: 0)).then((e) {
      setState(() {
        _selectionController.text = "$name";
        _selectionController.selection = TextSelection(
            baseOffset: 0,
            extentOffset: _selectionController.text.length
        );
      });
    });
  }





  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    name = ModalRoute.of(context).settings.arguments;

    //print(name);

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

//                Positioned(
//                  bottom: 10,
//                  width: size.width,
//                  child: Padding(
//                    padding: const EdgeInsets.symmetric(horizontal: 20),
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      crossAxisAlignment: CrossAxisAlignment.baseline,
//                      textBaseline: TextBaseline.alphabetic,
//                      children: <Widget>[
//                        Expanded(
//                          child: Row(
//                            crossAxisAlignment: CrossAxisAlignment.baseline,
//                            textBaseline: TextBaseline.alphabetic,
//                            children: <Widget>[
//                              Icon(
//                                Icons.vpn_key,
//                                color: Colors.white,
//                              ),
//                              SizedBox(width: 10),
//                              Text(
//                                '已注册CRP',
//                                style: TextStyle(
//                                  fontSize: 22,
//                                  color: Colors.white,
//                                  fontWeight: FontWeight.bold,
//                                ),
//                              )
//                            ],
//                          ),
//                        ),
//                        Expanded(
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.end,
//                            crossAxisAlignment: CrossAxisAlignment.baseline,
//                            textBaseline: TextBaseline.alphabetic,
//                            children: <Widget>[
//                              Text(
//                                '$nownumber/100',
//                                style: TextStyle(
//                                  fontSize: 35,
//                                  letterSpacing: 0.2,
//                                  color: Color(0xFFF83B6D),
//                                  fontWeight: FontWeight.bold,
//                                ),
//                              ),
//                              SizedBox(width: 10),
//                              Text(
//                                '对',
//                                style: TextStyle(
//                                  fontSize: 22,
//                                  color: Colors.white,
//                                  fontWeight: FontWeight.bold,
//                                ),
//                              )
//                            ],
//                          ),
//                        )
//                      ],
//                    ),
//                  ),
//                ),
                Positioned(
                  top: 0,
                  width: size.width,
                  height: size.height - size.height * .3,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      new FlareActor(
                        "assets/beacon.flr",
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                        animation: "record",
                      ),
                      Container(
                          width: size.width,
                          height: size.height - size.height * .28,
                          alignment: Alignment.center,
                          child:
                          new Image(image: AssetImage("assets/sound.png"))
//                        Icon(
//                          Icons.favorite,
//                          size: 100,
//                          color: Colors.black,
//                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
//                  top: 40,
                  width: size.width,
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal:size.width*0.05),
                    child:AppBar(
                      leading: IconButton(
                        iconSize: 30,
                        icon:Icon(Icons.arrow_back),
                        color: Colors.white,
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                      ),
                      title: Text('$name',style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),),
                      centerTitle: true,
                      backgroundColor: Color(0x000000),
                      elevation: 0,
                    ),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        Container(
//                          width: 65,
//                          alignment: Alignment.centerLeft,
//                          child: IconButton(
//                            iconSize: 30,
//                            icon:Icon(Icons.arrow_back),
//                            color: Colors.white,
//                            onPressed: (){
//                              Navigator.of(context).pop();
//                            },
//                          ),
//                        ),
//                        Text(
//                          '$name',
//                          textAlign: TextAlign.center,
//                          style: TextStyle(
//                            color: Colors.white,
//                            fontWeight: FontWeight.bold,
//                            fontSize: 25,
//                          ),
//                        ),
//                        Row(
//                          children: <Widget>[
////                            Stack(
////                              children: <Widget>[
////                                Container(
////                                  width: 50,
////                                  child: Icon(
////                                    Icons.new_releases,
////                                    size: 30,
////                                    color: Colors.white,
////                                  ),
////                                ),
////                                Positioned(
////                                  top: 0,
////                                  right: 0,
////                                  child: Container(
////                                    height: 20,
////                                    width: 20,
////                                    alignment: Alignment.center,
////                                    child: Text(
////                                      '7',
////                                      style: TextStyle(
////                                        color: Colors.white,
////                                        fontWeight: FontWeight.bold,
////                                      ),
////                                    ),
////                                    decoration: BoxDecoration(
////                                      color: Colors.blue,
////                                      borderRadius: BorderRadius.circular(50),
////                                    ),
////                                  ),
////                                )
////                              ],
////                            ),
//                            SizedBox(width: 10),
////                            Icon(
////                              Icons.edit,
////                              color: Colors.white,
////                            ),
//                          ],
//                        )
//                      ],
//                    ),
                  ),
                ),
                Positioned(
                  top:size.height*0.7466,
                  left: size.width*0.12,
                  width: size.width,
                  height: size.height - size.height * .3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisSize:MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width:size.width*0.7639,
                              height: size.height*0.0622,
                              child: FlatButton(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(25))),
                                child: Text(
                                  "重命名",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                onPressed: () async {
                                  String newname = await showDialog(context: context, builder: (context) => Center(
                                      child:Dialog(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                                        child: Container(
                                            height: size.height*0.22398,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(25)),
                                              color: Colors.white,
                                            ),

                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment:MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text("重命名",
                                                      style: TextStyle(
                                                          fontSize: 40
                                                      ),)
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize: MainAxisSize.min,

                                                  children: <Widget>[
                                                    Container(
                                                      width: size.width*0.7639,
                                                      padding: EdgeInsets.only(
                                                        left: 10, right: 10, ),
                                                      decoration: BoxDecoration(
                                                        color: Color(0xffededed),
                                                        borderRadius: BorderRadius.all(Radius.circular(25)),
                                                      ),
                                                      child: TextField(
                                                        autofocus: true,
                                                        controller: _selectionController,
                                                        decoration: InputDecoration(
                                                          border: InputBorder.none,
                                                          //hintText: _selectionController.text,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Container(
                                                  height: size.height*0.02488,
                                                  color: Color(0x000000),
                                                ),
                                                Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Container(
                                                      width:size.width*0.3571,
                                                      child: RaisedButton(
                                                        onPressed: (){
                                                          Navigator.of(context).pop();
                                                        },
                                                        color: Color(0xfff5f5f5),
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                                                        child: Text('取消'),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: size.width*0.05,
                                                      color: Color(0x000000),
                                                    ),
                                                    Container(
                                                      width:size.width*0.3571,
                                                      child: RaisedButton(
                                                        onPressed: (){
                                                          Navigator.of(context).pop(_selectionController.text);
                                                        },
                                                        color: Color(0xfff5f5f5),
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                                                        child: Text('确定'),
                                                      ),
                                                    ),
                                                  ],

                                                )
                                              ],
                                            )
                                        ),

                                      )
                                  ));
                                  //print(newname);
                                  if(newname!=null){
                                    Navigator.of(context).pop(newname);
                                  }
                                }
                                ,
                              ),
                            ),
                          ],
                      ),
                      Container(
                        height: size.height*0.024,
                        color: Color(0x000000),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width:size.width*0.7653,
                            height: size.height*0.0622,
                            child: FlatButton(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(25))),
                              child: Text(
                                "删除",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              onPressed: ()async{
                                bool result = await showDeleteConfirmDialog1();
                                if(result==null){
                                }else{
                                  Navigator.of(context).pop("delete");
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ),
              ],
            ),
          ),
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

  Future<bool> showDeleteConfirmDialog1() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("您确认删除该用户吗"),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("确认"),
              onPressed: () {
                //关闭对话框并返回true
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

}

