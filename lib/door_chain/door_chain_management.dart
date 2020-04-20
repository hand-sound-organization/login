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
  List<List> datalist =  [];
  List<bool> chooseData = [false,true,true,true,true,true,true,];
  List<String>  aa = ["周一","周二",'周三','周四','周五',"周六","周日"];


  @override
  void initState() {
    //Hide banner ad if it isn't already hidden
    //Ads.hideBannerAd();
    super.initState();
  }

  String changeDate(List<bool> list){
    String data ='';
    print(list);
    for (int i=0; i<7; i++){
      if(list[i]==true){
        data+=aa[i];
        data+="、";
      }
    }
    if(data.length!=0){
      data = data.substring(0, data.length-1);
    }

    print(data);
    return data;
  }


  @override
  Widget build(BuildContext context) {
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
      body: AnimatedList(
        /// Key to call remove and insert item methods from anywhere
        key: _listKey,
        initialItemCount: _datastart.length,
        itemBuilder: (context, index, animation) {
          return _buildItem(_datastart[index],_dataend[index],changeDate(datalist[index]), animation, index);
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
                    TimeOfDay.now(),TimeOfDay.now(),[true,true,true,true,true,true,true,]))
            as TransferDataEntity;

            _insertSingleItem(result);
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
              _datastart[index]=result.timestart;
              _dataend[index]=result.timeend;

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
//  void _removeSingleItems(int removeAt) {
//    int removeIndex = removeAt;
//    String removedItem = _data.removeAt(removeIndex);
//    String removedItemdata = datalist.removeAt(removeIndex);
//    // This builder is just so that the animation has something
//    // to work with before it disappears from view since the original
//    // has already been deleted.
//    AnimatedListRemovedItemBuilder builder = (context, animation) {
//      // A method to build the Card widget.
//      return _buildItem(removedItem,removedItemdata, animation, removeAt);
//    };
//    _listKey.currentState.removeItem(removeIndex, builder);
//  }


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
  final List<bool> list;

  TransferDataEntity(this.timestart, this.timeend,this.list);
}