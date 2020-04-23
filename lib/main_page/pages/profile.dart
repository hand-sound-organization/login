

import '../widgets/profile/profile_categories.dart';
import '../widgets/profile/profile_detail.dart';
import '../widgets/profile/profile_menu.dart';
import '../widgets/title_large.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => new _ProfileState();
}
class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Material(
      color: Colors.white,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFa06f9c).withOpacity(0.95),
              Color(0xFF1610a6).withOpacity(0.75),
            ],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
          ),
        ),
        child: Padding(
          padding:  EdgeInsets.only(
            left: size.width*0.05093,
            right: size.width*0.05093,
            top: size.height*0.03733,
          ),
          child: Column(
            //mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TitleLarge(
                title: '掌音管家',
              ),
              SizedBox(
                height: size.width*0.05093,
              ),
              ProfileDetail(),
              SizedBox(
                height: size.height*0.03733,
              ),
              ProfileCategories(),
              SizedBox(
                height: size.height*0.03733,
              ),
              Flexible(child: ProfileMenu()),
            ],
          ),
        ),
      ),

    );
  }
}
