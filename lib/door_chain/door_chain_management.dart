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
  // backing data
  List<TimeOfDay> _datastart = [ TimeOfDay(hour: 9, minute: 30) ,TimeOfDay(hour: 13, minute: 30),TimeOfDay(hour: 21, minute: 30) ];
  List<TimeOfDay> _dataend = [ TimeOfDay(hour: 12, minute: 30) ,TimeOfDay(hour: 14, minute: 30),TimeOfDay(hour: 23, minute: 30)];
  List<String> datalist =  ['周一、周二、周三、周四、周五', '周一、周二、周三、周四、周五', '周一、周二、周三、周四、周五、周六、周日'];
  List<bool> chooseData = [false,true,true,true,true,true,true,];


  @override
  void initState() {
    //Hide banner ad if it isn't already hidden
    //Ads.hideBannerAd();
    super.initState();
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
          return _buildItem(_datastart[index],_dataend[index],datalist[index], animation, index);
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
            var result = await Navigator.of(context).pushNamed("add_alarm");
            _insertSingleItem();
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
              var result = await Navigator.of(context).pushNamed("add_alarm",arguments: "$timestart,$timeend,$data",);
              print("$result");
//              if(result==null){
//              }
//              else if("$result"=="delete"){
//                _removeSingleItems(index);
//              }
//              else{
//                _data[index]="$result";
//              }

            },
          ),
        ),
      ),
    );
  }

  /// Method to add an item to an index in a list
  void _insertSingleItem() {
    int insertIndex;
    if (_datastart.length > 0) {
      insertIndex = _datastart.length;
    } else {
      insertIndex = 0;
    }
//    String item = "成员 ${insertIndex + 1}";
    String data = '周一、周二、周三、周四、周五';

   var timestart =  TimeOfDay.now();
    var timeend   =   TimeOfDay.now();
    _datastart.insert(insertIndex, timestart);
    _dataend.insert(insertIndex,timeend);
    datalist.insert(insertIndex, data);
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
