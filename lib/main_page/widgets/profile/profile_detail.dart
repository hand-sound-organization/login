import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../../utils/constant.dart';
import '../../widgets/profile_image.dart';
import 'package:flutter/material.dart';

class ProfileDetail extends StatefulWidget {
  ProfileDetail({Key key,@required this.username}):super(key:key);
  final String username;
  @override
  _ProfileDetailState createState() => new _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  Map _data;
  verify(String username)async{
    bool result;
    String responseBody;
    try{
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.getUrl(
          Uri(scheme: "http",path: "/app/profile",host: "192.168.0.107",port: 5000,queryParameters: {
            "username":username,
          })
      );
      HttpClientResponse response = await request.close();
      String responseBody = await response.transform(utf8.decoder).join();
      print(responseBody);
      Map data = jsonDecode(responseBody);
      _data = data;
      print(data);
      profileItems[0]['count']=data['safeday'];
      profileItems[1]['count']=data['safetimes'];
      profileItems[2]['count']=data['member'];
      profileItems[3]['count']=data['safepct'];
      return data;
      httpClient.close();
//      responseBody = await response.transform(utf8.decoder).join();
//      var data = jsonDecode(responseBody);
//      result = data['isTrue'];
//      print(data);
      //return result;
    }catch(e){
      print("出错");
      return null;
    }
  }
  Future<List> mockNetworkData()async{
    await verify(widget.username) ;
    List list=[];
    return Future.delayed(Duration(seconds: 0), ()=>list) ;
  }
  @override
  Widget build(BuildContext context) {

    Size deviceSize = MediaQuery.of(context).size;
    return FutureBuilder<List>(
      future: mockNetworkData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // 请求已结束
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            // 请求失败，显示错误
            return Center(child: Text("未连接到互联网"),);
          } else {
            // 请求成功，显示数据
            List profileMenuList = snapshot.data;
            return MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child:Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
                elevation: 0,
                child: Container(
                  height: deviceSize.height * 0.2,
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          ProfileImage(
                            height: 60.0,
                            width: 60.0,
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    '${widget.username}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15.0,
                                  ),
//                        Icon(
//                          Icons.border_color,
//                          color: Colors.white,
//                          size: 15.0,
//                        )
                                ],
                              ),
                              Text(
                                '门锁ID:${_data["lock_id"]}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          for (var item in profileItems)
                            Column(
                              children: <Widget>[
                                Text(
                                  item['count'].toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  item['name'],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            );
          }
        }
        else {
          // 请求未结束，显示loading
          return Center(child:CircularProgressIndicator());
        }
      },
    );

  }
}
