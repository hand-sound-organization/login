import 'dart:io';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:handsound/login_page.dart';
import 'package:handsound/sign_in_page.dart';
import '../bloc/theme.bloc.dart';
import '../configs/themes.dart';
import 'progress_bar.dart';
import 'package:handsound/user_provider.dart';
import 'package:handsound/user.dart';


class LockSignUpPage extends StatefulWidget {
  LockSignUpPage({Key key}) : super(key: key);

  _LockSignUpPageState createState() => _LockSignUpPageState();
}

class _LockSignUpPageState extends State<LockSignUpPage> {
var nownumber = 0;
Timer _timer;

  @override
  void initState() {
    super.initState();
    themeBloc.changeTheme(Themes.stayfit);

  }
  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }


  void f1111(){
    _timer = Timer.periodic(Duration(seconds: 1),(timer){

        if(nownumber<100){
          setState(() {
            nownumber++;
          });
        }
        else {
          timer.cancel();
          //timer=null;
          print(nownumber);
          Navigator.pushReplacement(
              context, MaterialPageRoute(
              builder: (BuildContext context) {
                return UserContainer(
                    user: User('1', '1'), child: new LoginPage());
              }
          )
          );
        }
    });
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    f1111();

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
                        Color(0xFF422479).withOpacity(0.95),
                        Color(0xFF1C0746).withOpacity(0.75),
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
//                            Stack(
//                              children: <Widget>[
//                                Container(
//                                  width: 50,
//                                  child: Icon(
//                                    Icons.new_releases,
//                                    size: 30,
//                                    color: Colors.white,
//                                  ),
//                                ),
//                                Positioned(
//                                  top: 0,
//                                  right: 0,
//                                  child: Container(
//                                    height: 20,
//                                    width: 20,
//                                    alignment: Alignment.center,
//                                    child: Text(
//                                      '7',
//                                      style: TextStyle(
//                                        color: Colors.white,
//                                        fontWeight: FontWeight.bold,
//                                      ),
//                                    ),
//                                    decoration: BoxDecoration(
//                                      color: Colors.blue,
//                                      borderRadius: BorderRadius.circular(50),
//                                    ),
//                                  ),
//                                )
//                              ],
//                            ),
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
                  bottom: 10,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: <Widget>[
                              Icon(
                                Icons.vpn_key,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                '已注册CPR',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: <Widget>[
                              Text(
                                '$nownumber/100',
                                style: TextStyle(
                                  fontSize: 35,
                                  letterSpacing: 0.2,
                                  color: Color(0xFFF83B6D),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                '对',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
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
                )
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
}
