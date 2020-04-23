import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import '../bloc/theme.bloc.dart';
import '../configs/themes.dart';
import 'bingding_search_page.dart';

import 'package:handsound/user_provider.dart';
import 'package:handsound/user.dart';

class FirstBingdingPage extends StatefulWidget {
  FirstBingdingPage({Key key}) : super(key: key);

  _FirstBingdingPageState createState() => _FirstBingdingPageState();
}

class _FirstBingdingPageState extends State<FirstBingdingPage> {

  @override
  void initState() {
    super.initState();
    themeBloc.changeTheme(Themes.stayfit);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
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
                        Color(0xFFa06f9c).withOpacity(0.95), //原色(0xFF422479)
                        Color(0xFF1610a6).withOpacity(0.75), //原色(0xFF1C0746)
                      ],
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.06,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child:
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '门锁绑定',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.31,
                  left: size.width * 0.17,
                  width: size.width / 1.5,
                  height: size.width / 1.5,
                  child: Container(
                    //alignment: Alignment.center,
                    //color: Colors.red,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        new FlareActor(
                          "assets/ButtonAnimation.flr",
                          alignment: Alignment.center,
                          fit: BoxFit.contain,
                          animation: "record",
                        ),
                        Padding(padding: EdgeInsets.only(
                            left: size.width * 0.115,
                            right: size.width * 0.115),
                          child: RaisedButton(
                            shape: CircleBorder(),
                            color: Color(0xbbffffff),
                            child: Container(
                              //color: Colors.blue,
                              //height: size.width/1.5,
                              //width: size.width/2.5,
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.vpn_key,
                                  size: size.width * 0.15,)
                            ),
                            onPressed: () {
                              //Navigator.of(context).pop();
                              Navigator.push(
                                  context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return UserContainer(user: User('1', '1'),
                                        child: new BingdingSearchPage());
                                  }
                              )
                              );
                            },
                          ),)
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: size.height * 0.752,
                    left: size.width * 0.182,
                    width: size.width / 1.5,
                    height: size.height - size.height * .28,
                    child:
                    new Text('请先绑定门锁再使用完整功能',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),)
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
