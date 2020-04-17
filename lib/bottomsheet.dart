import 'package:flutter/material.dart';

class BottomSheetDemo extends StatefulWidget {
  @override
  _BottomSheetDemoState createState() => _BottomSheetDemoState();
}

class _BottomSheetDemoState extends State<BottomSheetDemo> {

  _openModalBottomSheet(){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return Container(
            decoration: BoxDecoration(
              color: Color(0x000000),

            ),
            height: 100,
//            child: Column(
//              children: <Widget>[
//                ListTile(
//                  title: Text('Option A'),
//                ),
//                ListTile(
//                  title: Text('Option B'),
//                ),
//                ListTile(
//                  title: Text('Option C'),
//                ),
//              ],
//            ),
              child:Card(
                color: Colors.blueAccent,
                //z轴的高度，设置card的阴影
                elevation: 20.0,
                //设置shape，这里设置成了R角
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                      bottomLeft: Radius.circular(5.0),
                      bottomRight: Radius.circular(5.0)),
                ),
                clipBehavior: Clip.antiAlias,
                semanticContainer: false,
                child: getChild(),
              )
          );
        }
    );
  }
  getChild() {
    return Container(
      width:300,
      height: 140,
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {

        },
        // Generally, material cards use onSurface with 12% opacity for the pressed state.
//        splashColor:
//        Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
//        // Generally, material cards do not have a highlight overlay.
//        highlightColor: Colors.transparent,),
        child: new Container(
          //设置child 居中
          alignment: Alignment(0, 0),
          child: Text("开始注册",style: TextStyle(color: Colors.white,fontSize: 16.0),),
        ),),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BottomSheetDemo'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text('Modal BottomSheet'),
                onPressed: _openModalBottomSheet,
//                  onPressed: () {
//                    showDialog<Null>(
//                      context: context,
//                      builder: (BuildContext context) {
//                        return new SimpleDialog(
//                          title: new Text('选择'),
//                          children: <Widget>[
//                            new SimpleDialogOption(
//                              child: new Text('选项 1'),
//                              onPressed: () {
//                                Navigator.of(context).pop();
//                              },
//                            ),
//                            new SimpleDialogOption(
//                              child: new Text('选项 2'),
//                              onPressed: () {
//                                Navigator.of(context).pop();
//                              },
//                            ),
//                          ],
//                        );
//                      },
//                    ).then((val) {
//                      print(val);
//                    });
//                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}