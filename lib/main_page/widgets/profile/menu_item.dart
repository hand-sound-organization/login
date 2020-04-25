import '../../utils/constant.dart';
import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final ProfileMenuConst menu;
  MenuItem({this.menu});
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.all(
        Radius.circular(20.0),
      ),
      //color: Color(0x000000),
      elevation: 5,
      child: Container(
        height: deviceSize.height * 0.09,
        decoration: BoxDecoration(
          boxShadow: [
//          BoxShadow(
//            color: Color(0xFFD1DCFF),
//            blurRadius: 20.0, // has the effect of softening the shadow
//            spreadRadius: 5.0, // has the effect of extending the shadow
//          ),
          ],
          color: Colors.white70,
          borderRadius: BorderRadius.circular(
            20.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: menu.iconColor,
                    ),
                    child: Icon(
                      menu.icon,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${menu.name}' + '${menu.event}',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${menu.time}',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
//            Icon(
//              Icons.chevron_right,
//              color: profile_item_color,
//            )
            ],
          ),
        ),
      ),
    );
  }
}
