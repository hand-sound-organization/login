import 'package:flutter/material.dart';

Widget circleDay(day, context, selected){
  return Container(
    width: 70.0,
    height: 70.0,
    decoration: BoxDecoration(
      color: Colors.blueAccent,
      //(selected)?Theme.of(context).accentColor:Colors.transparent,
      borderRadius: BorderRadius.circular(100.0)
    ),
    child: FlatButton(
      onPressed: (){
        print('666');
      },
      child: Text(
        day,
        style: TextStyle(
            color: Colors.white,
            fontSize: 15
        ),
      ),
      shape: CircleBorder(),
    ),
  );
}