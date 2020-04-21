import 'dart:convert';
import 'dart:typed_data';
import 'door_chain_management.dart';

import 'package:flutter/material.dart';
//import 'circle_day.dart';

class AddAlarm extends StatefulWidget {
  AddAlarm({Key key}) : super(key: key);


  _AddAlarmState createState() => _AddAlarmState();
}

class _AddAlarmState extends State<AddAlarm> {
  bool isloaded= false;
  TransferDataEntity transferDataEntity ;
  List<bool> chooseData = [false,true,true,true,true,true,true,];
  TimeOfDay _selectedTime;
  TimeOfDay _selectedTime2;
  ValueChanged<TimeOfDay> selectTime;
  ValueChanged<TimeOfDay> selectTime2;
  @override
  void initState() {
     _selectedTime = new TimeOfDay(hour: 12, minute: 30);
     _selectedTime2 = new TimeOfDay(hour: 12, minute: 30);

     super.initState();
  }

  @override
  Widget build(BuildContext context) {
    transferDataEntity = ModalRoute.of(context).settings.arguments;

    //Map<String, dynamic> map = json.decode(result);
    if(isloaded==false){
      isloaded=!isloaded;
      _selectedTime = transferDataEntity.timestart;
      _selectedTime2 = transferDataEntity.timeend;
      chooseData = transferDataEntity.list;
    }

    //print(result);
    return Scaffold(
      backgroundColor: Color(0xff1B2C57),
      appBar: AppBar(
        backgroundColor: Color(0xff1B2C57),
        title: Column(
          children: <Widget>[
            //Icon(Icons.lock, color: Color(0xff65D1BA),),
            Text('智能门链', style: TextStyle(
              color: Color(0xff65D1BA),
              fontSize: 25.0
            ))
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 60.0,),
              new GestureDetector(
                child: Text(_selectedTime.format(context), style: TextStyle(
                  fontSize: 60.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),),
                onTap: () {
                  _selectTime(context);
                },
              ),
              Container(
                width: 3,
                height: 20,
                color: Colors.white,
              ),
              new GestureDetector(
                child: Text(_selectedTime2.format(context), style: TextStyle(
                  fontSize: 60.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),),
                onTap: () {
                  _selectTime2(context);
                },
              ),
              SizedBox(height: 30.0,),
              Wrap(
                spacing: 20.0,
                runSpacing: 4.0,
                alignment: WrapAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  circleDay('周一', context, 0),
                  circleDay('周二', context, 1),
                  circleDay('周三', context, 2),
                  circleDay('周四', context, 3),
                  circleDay('周五', context, 4),
                  circleDay('周六', context, 5),
                  circleDay('周日', context, 6),
                ],
              ),
              SizedBox(height: 60.0,),
              SizedBox(height: 2.0, child: Container(color: Color(0x000000)),),
//              ListTile(
//                leading: Icon(Icons.notifications_none, color: Colors.white,),
//                title: Text('Alarm Notification', style: TextStyle(color: Colors.white)),
//              ),
//              SizedBox(height: 2.0, child: Container(color: Colors.white30,),),
//              ListTile(
//                leading: Icon(Icons.check_box, color: Colors.white,),
//                title: Text('Vibrate', style: TextStyle(color: Colors.white)),
//              ),
//              SizedBox(height: 2.0, child: Container(color: Colors.white30,),),
//              SizedBox(height: 60.0,),
              Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    color: Theme.of(context).accentColor,
                    child: Text('保存', style: TextStyle(color: Colors.white,
                    fontSize: 20),
                    ),
                    onPressed: () => Navigator.of(context).pop(TransferDataEntity(_selectedTime,_selectedTime2,chooseData))
                ),
              )
            ],
          ),
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () =>  Navigator.of(context).pop(TransferDataEntity(_selectedTime,_selectedTime2,null)),
        backgroundColor: Colors.white,
        child: Icon(
          Icons.delete,
          size: 20.0,
          color:Theme.of(context).accentColor,
        ),
      )
    );
  }
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (time == null) return;

    setState(() {
      _selectedTime = time;
    });
  }
  Future<void> _selectTime2(BuildContext context) async {
    final TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: _selectedTime2,
    );

    if (time == null) return;

    setState(() {
      _selectedTime2 = time;
    });
  }
//  Future<void> _selectTime(BuildContext context) async {
//    final TimeOfDay picked =  await showTimePicker(
//      context: context,
//      initialTime: _selectedTime
//    );
//    setState(() {
//      _selectedTime = picked;
//    });
//  }
  Widget circleDay(day, context, index){
    return Container(
      width: 70.0,
      height: 70.0,
      decoration: BoxDecoration(
          color: (chooseData[index])?Theme.of(context).accentColor:Colors.transparent,
          //(selected)?Theme.of(context).accentColor:Colors.transparent,
          //Colors.blueAccent,
          borderRadius: BorderRadius.circular(100.0)
      ),
      child: FlatButton(
        onPressed: (){
          setState(() {
            chooseData[index]=!chooseData[index];
          });
          print('${chooseData[index]}');
        },
        child: Text(
          day,
          style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight:FontWeight.bold
          ),
        ),
        shape: CircleBorder(),
      ),
    );
  }
}