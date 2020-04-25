import 'dart:async';

import '../../utils/constant.dart';
import '../../widgets/profile/menu_item.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

class ProfileMenu extends StatefulWidget {
  @override
  _ProfileMenuState createState() => new _ProfileMenuState();
}
class _ProfileMenuState extends State<ProfileMenu> {
  Widget divider = Container(
  height: 10,
  color: Color(0x00000000)
  );
  //List profileMenuList;
  @override
  void initState(){
    super.initState();
//    Future.delayed(Duration(milliseconds: 200)).then((e) {
//      showDialog<Null>(
//        context: context,
//        //barrierDismissible: barrierDismissible,
//        // false = user must tap button, true = tap outside dialog
//        builder: (BuildContext dialogContext) {
//          return ShowProgress(verify());
//        },
//      );
//    });
  }

  verify()async{
    try{
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.getUrl(
          Uri(scheme: "http",path: "/app/WarningInfo",host:"10.0.2.2",port:5000));
      HttpClientResponse response = await request.close();
      String responseBody = await response.transform(utf8.decoder).join();
      Map returnInfo = jsonDecode(responseBody);
      List dataList = returnInfo['returnInfo'];
      print(dataList);
      httpClient.close();
      return dataList;
    }catch(e){
      print("666");
      return null;
    }
  }
  Future<List> mockNetworkData() async {
    List dataList = await verify() as List;
    int profileMenuListLength = profileMenuList.length;
    print(profileMenuList.length);
    int index = 0;
    for(var item in dataList){
      if(index>=profileMenuListLength){
        profileMenuList.add(ProfileMenuConst());
      }
      profileMenuList[index].event = item['event'];
      if(profileMenuList[index].event=="开门"){
        profileMenuList[index].icon = Icons.check;
        profileMenuList[index].iconColor = Colors.green;
      }
      else if(profileMenuList[index].event=="试错"){
        profileMenuList[index].icon = Icons.warning;
        profileMenuList[index].iconColor = Colors.yellow[700];
      }
      else{
        profileMenuList[index].icon = Icons.cancel;
        profileMenuList[index].iconColor = Colors.red;
      }
      profileMenuList[index].name = item['name'];
      profileMenuList[index].time = item['occur_time'];
      index++;
    }
    print(profileMenuList.length);
    return Future.delayed(Duration(seconds: 2), ()=>profileMenuList) ;
  }
  @override
  Widget build(BuildContext context)  {

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
                child: ListView.separated(
                  itemCount: profileMenuList.length,
                  //itemExtent: 80.0, //强制高度为50.0
                  itemBuilder: (BuildContext context, int index) {
                    return  MenuItem(menu: profileMenuList[index],);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return divider;
                  },
                ),
              );
            }
          } else {
            // 请求未结束，显示loading
            return Center(child:CircularProgressIndicator());
          }
        },
      );


//      Column(
//      mainAxisSize: MainAxisSize.max,
//      mainAxisAlignment: MainAxisAlignment.spaceAround,
//      children: <Widget>[
//
////        for (var menu in profileMenuList)
////          MenuItem(
////            menu: menu,
////          ),
//      ],
//    );
  }
}

//class ShowProgress extends StatefulWidget {
//  ShowProgress(this.requestCallback);
//  final Future<Null> requestCallback;//这里Null表示回调的时候不指定类型
//  @override
//  _ShowProgressState createState() => new _ShowProgressState();
//}
//class _ShowProgressState extends State<ShowProgress> {
//  @override
//  initState() {
//    super.initState();
//    new Timer(new Duration(milliseconds: 10), () {//每隔10ms回调一次
//      widget.requestCallback.then((Null) {//这里Null表示回调的时候不指定类型
//        Navigator.of(context).pop();//所以pop()里面不需要传参,这里关闭对话框并获取回调的值
//      });
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new Center(
//      child: new CircularProgressIndicator(),
//    );
//  }
//}






