import 'dart:convert';
import 'dart:io';
import 'package:handsound/main_page/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:handsound/lock_binding/firt_binding_page.dart';
import 'package:handsound/user_provider.dart';
import 'package:handsound/user.dart';
import 'package:handsound/lock_sign_up/lock_sign_up_page.dart';

import '../user_provider.dart';
//import '../Ads.dart';


class MainUserManage extends StatefulWidget {
  @override
  _MainUserManageState createState() => _MainUserManageState();
}

class _MainUserManageState extends State<MainUserManage> {
  // the GlobalKey is needed to animate the list
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  String IP;
  int PORT;
  User user;
  // backing data

  @override
  void initState() {
    //Hide banner ad if it isn't already hidden
    //Ads.hideBannerAd();
    super.initState();
  }
  HTTPget()async{
    try{
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.getUrl(
          Uri(scheme: "http",path: "/app/usermanagement",host:"152.136.116.37",port:5000,queryParameters: {
            "username":user.username
          }));
      HttpClientResponse response = await request.close();
      String responseBody = await response.transform(utf8.decoder).join();
      Map returnInfo = jsonDecode(responseBody);
      String data = returnInfo['memberlist'];
      print(data);
      memList= data.split(",");
      if(data.length==0){
        memList=[];
      }
      print(memList);
      return memList;
      httpClient.close();

    }catch(e){
      print("666");
      return null;
    }
  }
  HTTPpost()async{
    try{


      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.getUrl(
          Uri(scheme: "http",path: "/app/updatamemberlist",host:"152.136.116.37",port:5000,queryParameters: {
            "username":user.username,
            "memberlist": memList.join(",")
          }));
      HttpClientResponse response = await request.close();
      String responseBody = await response.transform(utf8.decoder).join();
      Map returnInfo = jsonDecode(responseBody);
      print(returnInfo);
      return returnInfo;
      httpClient.close();

    }catch(e){
      print("666");
      return null;
    }
  }
  searchAndLink()async{
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
          }
        }
      }
      );
    });
    Future.delayed(Duration(seconds: 1), () async{
      var Psocket = await Socket.connect(InternetAddress(IP), PORT);
      Psocket.add(
          '{"PAGEID":"vibration",'
              '"USERNAME":"",'
              '"LOCKID":"",'
              '"TOKEN":"",'
              '"MEMBERLIST":[],'
              '"DATASTART":[],'
              '"DATAEND":[],'
              '"DATALIST":[],'
              '"IsOver":"True"'
              '}'
              .codeUnits);
      Psocket.close();
//      Psocket.add("END".codeUnits);
      //Navigator.of(context).pushNamed("bingding_lock_page");z
    });
  }
  Future<List> mockNetworkData() async {
    List dataList = await HTTPget() as List;

    return Future.delayed(Duration(seconds: 1), ()=>dataList) ;
  }
  @override
  Widget build(BuildContext context) {
    user = UserContainer.of(context).user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5b3fa1),
        centerTitle: true,
        title: Text(
          '用户管理',
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              //fontFamily: Utils.ubuntuRegularFont
          ),
        ),
      ),
      body: FutureBuilder<List>(
        future: mockNetworkData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // 请求已结束
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              // 请求失败，显示错误
              return Center(child: Text("未连接到互联网"),);
            } else {
              // 请求成功，显示数据
              List memberList = snapshot.data;
              return MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: AnimatedList(
                  /// Key to call remove and insert item methods from anywhere
                  key: _listKey,
                  initialItemCount: memList.length,
                  itemBuilder: (context, index, animation) {
                    return _buildItem(memList[index], animation, index);
                  },
                ),
              );
            }
          }
          else {
            // 请求未结束，显示loading
            return Center(child:CircularProgressIndicator());
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        onPressed: () async {

          bool delete = await showDeleteConfirmDialog1();
          if (delete != null) {
            Navigator.pushNamed( context,"lock_sign_up_page");
            _insertSingleItem();
            HTTPpost();
          }

//          Navigator.push(
//              context, MaterialPageRoute(
//              builder: (BuildContext context) {
//                return UserContainer(user: User('1','1'), child: new LockSignUpPage());
//              }
//          )
//          );

        },
      ),
    );
  }

  Widget _buildItem(String item, Animation animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        elevation: 5.0,
        child: ListTile(
          title: Text(
            item,
            style: TextStyle(fontSize: 20),
          ),
          trailing: GestureDetector(
            child: Icon(
              Icons.settings,
              color: Colors.grey,
            ),
            onTap: () async{
              var result = await Navigator.of(context).pushNamed("rename_or_delete_page",arguments: "$item");
              print("$result");
              if(result==null){
              }
              else if("$result"=="delete"){
                _removeSingleItems(index);
                HTTPpost();
              }
              else{
                Future.delayed(Duration(milliseconds: 1000)).then((e) {
                  setState(() {
                    memList[index] = "$result";
                    HTTPpost();
                  });
                });
              }

            },
          ),
        ),
      ),
    );
  }

  /// Method to add an item to an index in a list
  void _insertSingleItem() {
    int insertIndex;
    if (memList.length > 0) {
      insertIndex = memList.length;
    } else {
      insertIndex = 0;
    }
    String item = "成员 ${insertIndex + 1}";
    memList.insert(insertIndex, item);
    _listKey.currentState.insertItem(insertIndex);
  }

//  void _insertMultipleItems() {
//    final items = ['Item 1', 'Item 2', 'Item 3'];
//    int insertIndex = 2;
//    _data.insertAll(insertIndex, items);
//    // This is a bit of a hack because currentState doesn't have
//    // an insertAll() method.
//    for (int offset = 0; offset < items.length; offset++) {
//      _listKey.currentState.insertItem(insertIndex + offset);
//    }
//  }
  void _rename(int removeAt){
    int removeIndex = removeAt;
    String removedItem = memList.removeAt(removeIndex);
    // This builder is just so that the animation has something
    // to work with before it disappears from view since the original
    // has already been deleted.
    AnimatedListRemovedItemBuilder builder = (context, animation) {
      // A method to build the Card widget.
      return _buildItem(removedItem, animation, removeAt);
    };
    _listKey.currentState.removeItem(removeIndex, builder);
  }
  /// Method to remove an item at an index from the list
  void _removeSingleItems(int removeAt) {
    int removeIndex = removeAt;
    String removedItem = memList.removeAt(removeIndex);
    // This builder is just so that the animation has something
    // to work with before it disappears from view since the original
    // has already been deleted.
    AnimatedListRemovedItemBuilder builder = (context, animation) {
      // A method to build the Card widget.
      return _buildItem(removedItem, animation, removeAt);
    };
    _listKey.currentState.removeItem(removeIndex, builder);
  }

//  void _removeMultipleItems() {
//    int removeIndex = 2;
//    int count = 2;
//    for (int i = 0; i < count; i++) {
//      String removedItem = _data.removeAt(removeIndex);
//      AnimatedListRemovedItemBuilder builder = (context, animation) {
//        return _buildItem(removedItem, animation);
//      };
//      _listKey.currentState.removeItem(removeIndex, builder);
//    }
//  }
  Future<bool> showDeleteConfirmDialog1() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("您希望添加一个新用户么?"),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
            FlatButton(
              child: Text("确定"),
              onPressed: () async{
                searchAndLink();
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

