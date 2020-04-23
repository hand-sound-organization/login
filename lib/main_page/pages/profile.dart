

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
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 30.0,
          ),
          child: Column(
            //mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TitleLarge(
                title: '掌音管家',
              ),
              SizedBox(
                height: 20.0,
              ),
              ProfileDetail(),
              SizedBox(
                height: 30.0,
              ),
              ProfileCategories(),
              SizedBox(
                height: 30.0,
              ),
              Flexible(child: ProfileMenu()),
            ],
          ),
        ),
      ),

    );
  }
}
