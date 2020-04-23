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
  void initState()async{
    super.initState();

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
      return dataList;
      httpClient.close();
    }catch(e){
      print("666");
      return null;
    }
  }

  @override
  Widget build(BuildContext context)  {

      return MediaQuery.removePadding(
          removeTop: true,
          context: context,
        child: ListView.separated(
            itemCount: 8,
            //itemExtent: 80.0, //强制高度为50.0
            itemBuilder: (BuildContext context, int index) {
            return  MenuItem(menu: profileMenuList[index],);
                },
            separatorBuilder: (BuildContext context, int index) {
            return divider;
                },
            ),
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





