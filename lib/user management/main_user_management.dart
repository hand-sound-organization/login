import 'package:flutter/material.dart';
import 'package:handsound/lock_binding/firt_binding_page.dart';
import 'package:handsound/user_provider.dart';
import 'package:handsound/user.dart';
import 'package:handsound/lock_sign_up/lock_sign_up_page.dart';
//import '../Ads.dart';


class MainUserManage extends StatefulWidget {
  @override
  _MainUserManageState createState() => _MainUserManageState();
}

class _MainUserManageState extends State<MainUserManage> {
  // the GlobalKey is needed to animate the list
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  // backing data
  List<String> _data = ['成员 1', '成员 2', '成员 3', '成员 4', '成员 5'];

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
        centerTitle: true,
        title: Text(
          '用户管理',
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
        initialItemCount: _data.length,
        itemBuilder: (context, index, animation) {
          return _buildItem(_data[index], animation, index);
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
              var result = Navigator.of(context).pushNamed("rename_or_delete_page",arguments: "$item");
              _removeSingleItems(index);
            },
          ),
        ),
      ),
    );
  }

  /// Method to add an item to an index in a list
  void _insertSingleItem() {
    int insertIndex;
    if (_data.length > 0) {
      insertIndex = _data.length;
    } else {
      insertIndex = 0;
    }
    String item = "成员 ${insertIndex + 1}";
    _data.insert(insertIndex, item);
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
    String removedItem = _data.removeAt(removeIndex);
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
    String removedItem = _data.removeAt(removeIndex);
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

