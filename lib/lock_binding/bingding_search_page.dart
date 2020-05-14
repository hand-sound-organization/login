import 'dart:io';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:handsound/login_page.dart';
import 'package:handsound/sign_in_page.dart';
import '../bloc/theme.bloc.dart';
import '../configs/themes.dart';
import 'progress_bar.dart';
import 'package:handsound/user_provider.dart';
import 'package:handsound/user.dart';
import 'package:handsound/lock_sign_up/lock_sign_up_page.dart';
import 'binging_lock_page.dart';
import 'dart:convert';
class BingdingSearchPage extends StatefulWidget {
  BingdingSearchPage({Key key}) : super(key: key);

  _BingdingSearchPage createState() => _BingdingSearchPage();
}

class _BingdingSearchPage extends State<BingdingSearchPage> {
  bool xunhuan = true;
  bool backBoolean = false;
  String IP;
  int PORT;
  User user;
  @override
  void initState() {
    super.initState();
    themeBloc.changeTheme(Themes.stayfit);
    _openModalBottomSheet();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    user = UserContainer.of(context).user;
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
//                  top: 40,
                  width: size.width,
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: size.width*0.05),
                    child: AppBar(
                      leading: IconButton(
                            iconSize: 30,
                            icon:Icon(Icons.arrow_back),
                            color: Colors.white,
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                          ),
                      title: Text("设备搜索",style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),),
                      centerTitle: true,
                      backgroundColor: Color(0x000000),
                      elevation: 0,
                    ),

                  ),
                ),
              ],
            ),
          ),



        ],
      ),
    );




  }

  Search()async{
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
            backBoolean = data.contains("Touch Voice SSDP Standard Response");
            print('1'+backBoolean.toString());
          }
        }
      }
      );
    });
  }

  _openModalBottomSheet()async{
    Search();
    Future.delayed(Duration(seconds: 2), (){
      if(backBoolean){
        Size size = MediaQuery.of(context).size;
        showModalBottomSheet(
            backgroundColor: Color(0x000000),
            context: context,
            builder: (BuildContext bc) {
              return Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        )),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('设备列表',
                              style: TextStyle(
                                  fontSize: 30
                              ),)
                          ],
                        ),
                        Container(
                          height: size.height*0.037,
                          color: Color(0x000000),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: size.height*0.25,
                              //                            width: size.width,
                              child: Padding(
                                padding: EdgeInsets.only(top: size.height*0.02,left: size.width*0.1,right: size.width*0.1),
                                child: Image(image: new AssetImage("assets/lock2.png"),
                                  //                              height: size.height*.1,
                                  fit: BoxFit.contain,),
                              ),
                            ),
                            //                          Image(image: new AssetImage("assets/lock2.png"),
                            //                          width: size.width*0.51,),
                          ],
                        ),
                        Container(
                          height: size.height*0.037,
                          color: Color(0x000000),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('掌音智能门锁',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey
                              ),)
                          ],
                        ),
                        Container(
                          height: size.height*0.017,
                          color: Color(0x000000),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.add_circle,
                                color: Colors.lightBlue,),
                              iconSize: 50,
                              onPressed: () async{

                                Future.delayed(Duration(seconds: 0), () async{
                                  var Psocket = await Socket.connect(InternetAddress(IP), PORT);
                                  Psocket.add(
                                      '{"PAGEID":"",'
                                          '"USERNAME":"",'
                                          '"LOCKID":"",'
                                          '"TOKEN":"",'
                                          '"MEMBERLIST":"[1]",'
                                          '"DATASTART":"[2]",'
                                          '"DATAEND":"[3]",'
                                          '"DATALIST":"[4]",'
                                          '"IsOver":"True"'
                                          '}'
                                          .codeUnits);
                                  Psocket.close();
                                  //Navigator.of(context).pushNamed("bingding_lock_page");
                                  Navigator.push(
                                      context, MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return UserContainer(user: user,
                                            child: new BingdingLockPage());
                                      }
                                  )
                                  );
                                });

                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              );
            });
      }




          });
  }
}


