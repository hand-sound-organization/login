import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../../utils/constant.dart';
import '../../widgets/profile_image.dart';
import 'package:flutter/material.dart';

class ProfileDetail extends StatefulWidget {
  @override
  _ProfileDetailState createState() => new _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  verify(String lockid,String username,String password)async{
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
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Material(
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
                          '王瑞锦',
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
                      '门锁ID:ZY12138',
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
                        item['count'],
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
    );
  }
}
