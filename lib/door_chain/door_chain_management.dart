import 'dart:convert';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:handsound/lock_binding/firt_binding_page.dart';
import 'package:handsound/user_provider.dart';
import 'package:handsound/user.dart';
import 'package:handsound/lock_sign_up/lock_sign_up_page.dart';
import 'package:handsound/door_chain/add_alarm.dart';
import 'package:intl/intl.dart';


class DoorChainManage extends StatefulWidget {
  @override
  _DoorChainManageState createState() => _DoorChainManageState();
}

class _DoorChainManageState extends State<DoorChainManage> {
  // the GlobalKey is needed to animate the list
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  TransferDataEntity transferDataEntity;
  // backing data
  List<TimeOfDay> _datastart =[];
  List<TimeOfDay> _dataend =[];
  List<List<String>> datalist =  [];
  List<String>  aa = ["周一","周二",'周三','周四','周五',"周六","周日"];
  String IP;
  int PORT;
  User user;

  @override
  void initState() {
    //Hide banner ad if it isn't already hidden
    //Ads.hideBannerAd();
    super.initState();
  }

  String changeDate(List<String> list){
    String data ='';

    for (int i=0; i<7; i++){
      if(list[i]=="1"){
        data+=aa[i];
        data+="、";
      }
    }
    if(data.length!=0){
      data = data.substring(0, data.length-1);
    }


    return data;
  }

  HTTPget(String username)async{
    try{
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.getUrl(
          Uri(scheme: "http",path: "/app/getchain",host: "192.168.101.10",port: 5000,queryParameters: {
            "username":username,
          })
      );
      HttpClientResponse response = await request.close();
      String responseBody = await response.transform(utf8.decoder).join();

      Map data = jsonDecode(responseBody);
      List list=[];

      splitTimeStart(data['timestart']);
      splitTimeEnd(data['timeend']);
      splitTimeDataList(data['datalist']);
      return list;
      httpClient.close();
//      responseBody = await response.transform(utf8.decoder).join();
//      var data = jsonDecode(responseBody);
//      result = data['isTrue'];
//      print(data);
      //return result;
    }catch(e){
      print("出错666");
      return null;
    }
  }
  HTTPpost(String username)async{
    try{
      HttpClient httpClient = new HttpClient();
      Uri uri;
      if(datalist.length==0){
        uri = Uri(scheme: "http",path: "/app/updatachain",host: "192.168.101.10",port: 5000,queryParameters: {
          "username":user.username,
          "timestart":"",
          "timeend":"",
          "datalist":""
        });
      }
      else{
        uri = Uri(scheme: "http",path: "/app/updatachain",host: "192.168.101.10",port: 5000,queryParameters: {
          "username":user.username,
          "timestart":joinTimeStart(),
          "timeend":joinTimeEnd(),
          "datalist":joinTimeDataList()
        });
      }

      HttpClientRequest request = await httpClient.getUrl(uri);
      print("123123123123123123123123");
      HttpClientResponse response = await request.close();

      String responseBody = await response.transform(utf8.decoder).join();

      Map data = jsonDecode(responseBody);

      return data;
      httpClient.close();
//      responseBody = await response.transform(utf8.decoder).join();
//      var data = jsonDecode(responseBody);
//      result = data['isTrue'];
//      print(data);
      //return result;
    }catch(e){
      print("出错66");
      return null;
    }
  }


  splitTimeStart(String timestart){
    List timeStartList = timestart.split(",");
    List<TimeOfDay> list=[];

    for(var i=0; i < timeStartList.length; i+=2) {
      list.add(new TimeOfDay(hour: int.parse(timeStartList[i]), minute: int.parse(timeStartList[i+1])));

    }
    _datastart = list;
  }
  splitTimeEnd(String timeend){
    List timeEndList = timeend.split(",");
    List<TimeOfDay> list=[];
    for(var i=0;i<timeEndList.length;){
      list.add(new TimeOfDay(hour: int.parse(timeEndList[i]), minute: int.parse(timeEndList[i+1])));

      i+=2;
    }
    _dataend = list;
  }
  splitTimeDataList(String _datalist){
    List timeDataList = _datalist.split(",");
    List<List<String>> _list=[];
    for(var i=0;i<timeDataList.length;){
      List<String> list =[];
      for(int j=0;j<7;j++){
        list.add(timeDataList[i+j]);
      }
      _list.add(list);
      i+=7;
    }
    datalist = _list;
  }

  joinTimeStart(){
    String timeStart="";
    for(var item in _datastart){
      timeStart += "${item.hour}" + "," + "${item.minute}" + ",";
    }
    timeStart = timeStart.substring(0,timeStart.length-1);
    return timeStart;
  }
  joinTimeEnd(){
    String timeEnd="";
    for(var item in _dataend){
      timeEnd += "${item.hour}" + "," + "${item.minute}" + ",";
    }
    timeEnd = timeEnd.substring(0,timeEnd.length-1);
    return timeEnd;
  }
  joinTimeDataList(){
    String _datalist = "";
    for(var item1 in datalist){
      for(var item2 in item1){
        _datalist += item2 + ",";
      }
    }
    _datalist = _datalist.substring(0,_datalist.length-1);
    return _datalist;
  }
  Future<List> mockNetworkData() async {
    List dataList = await HTTPget(user.username) as List;

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
          '门链管理',
          style: TextStyle(
            fontSize: 20.0,
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
              return AnimatedList(
                /// Key to call remove and insert item methods from anywhere
                key: _listKey,
                initialItemCount: _datastart.length,
                itemBuilder: (context, index, animation) {
                  return _buildItem(_datastart[index],_dataend[index],changeDate(datalist[index]), animation, index);
                },
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

//            Navigator.pushNamed( context,"add_alarm");
            var result = await Navigator.of(context).pushNamed("add_alarm",
                arguments: TransferDataEntity(
                    TimeOfDay.now(),TimeOfDay.now(),["1","1","1","1","1","1","1"]))
            as TransferDataEntity;
            if(result.list!=null){
              print("+++++++++++++++++++++++++++++++++++++++++++++++++");
              print(result);
              _insertSingleItem(result);
              HTTPpost(user.username);
            }

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

  Widget _buildItem(TimeOfDay timestart,TimeOfDay timeend, String data, Animation animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        elevation: 5.0,
        child: ListTile(
          title: Text(
            "${timestart.hour} : ${timestart.minute} - ${timeend.hour} : ${timeend.minute} ",
            style: TextStyle(fontSize: 20),
          ),
          subtitle: Text(
            data,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15
            ),
          ),
          trailing: GestureDetector(
            child: Icon(
              Icons.settings,
              color: Colors.grey,
            ),
            onTap: () async{
              var result = await Navigator.of(context).pushNamed("add_alarm",
                //arguments:[timestart,timeend,data],
                arguments:TransferDataEntity(timestart,timeend,datalist[index])
                //{"timerstart":timestart,"timed":timeend},
              )as TransferDataEntity;
              print("$result");
              if(result.list==null){

                _removeSingleItems(index);

                HTTPpost(user.username);
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
                      '{"PAGEID":"deleteClock",'
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
              else{
                datalist[index] =result.list;
                _datastart[index]=result.timestart;
                _dataend[index]=result.timeend;
                HTTPpost(user.username);
              }


            },
          ),
        ),
      ),
    );
  }

  /// Method to add an item to an index in a list
  void _insertSingleItem(TransferDataEntity transferDataEntity) {
    int insertIndex;
    if (_datastart.length > 0) {
      insertIndex = _datastart.length;
    } else {
      insertIndex = 0;
    }
//    String item = "成员 ${insertIndex + 1}";


    _datastart.insert(insertIndex, transferDataEntity.timestart);
    _dataend.insert(insertIndex,transferDataEntity.timeend);
    datalist.insert(insertIndex, transferDataEntity.list);
    _listKey.currentState.insertItem(insertIndex);
  }


//  void _rename(int removeAt){
//    int removeIndex = removeAt;
//    String removedItem = _data.removeAt(removeIndex);
//    // This builder is just so that the animation has something
//    // to work with before it disappears from view since the original
//    // has already been deleted.
//    AnimatedListRemovedItemBuilder builder = (context, animation) {
//      // A method to build the Card widget.
//      return _buildItem(removedItem, animation, removeAt);
//    };
//    _listKey.currentState.removeItem(removeIndex, builder);
//  }
  /// Method to remove an item at an index from the list
  void _removeSingleItems(int removeAt) {
    int removeIndex = removeAt;
    TimeOfDay removedItem1 = _datastart.removeAt(removeIndex);
    TimeOfDay removedItem2 = _dataend.removeAt(removeIndex);
    List<String> removedItem3 = datalist.removeAt(removeIndex);
    // This builder is just so that the animation has something
    // to work with before it disappears from view since the original
    // has already been deleted.
    AnimatedListRemovedItemBuilder builder = (context, animation) {
      // A method to build the Card widget.
      return _buildItem(removedItem1,removedItem2,changeDate(removedItem3), animation, removeAt);
    };
    _listKey.currentState.removeItem(removeIndex, builder);
  }


  Future<bool> showDeleteConfirmDialog1() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("您希望添加一个新门链吗?"),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
            FlatButton(
              child: Text("确定"),
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

class TransferDataEntity {
  final TimeOfDay timestart;
  final TimeOfDay timeend;
  final List<String> list;

  TransferDataEntity(this.timestart, this.timeend,this.list);
}