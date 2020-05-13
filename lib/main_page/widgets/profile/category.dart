import 'package:handsound/door_chain/door_chain_management.dart';
import 'package:handsound/door_chain/main_door_chain_page.dart';
import 'package:handsound/user%20management/main_user_management.dart';
import 'package:handsound/user_provider.dart';

import '../../../user.dart';
import '../../utils/constant.dart';
import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  final String username;
  final Catg catg;
  Category({Key key,@required this.catg,@required this.username}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                if (catg.name == listProfileCategories[0].name)
                  Navigator.push(
                      context, MaterialPageRoute(
                      builder: (BuildContext context) {
                        return UserContainer(user: User(this.username,"1"), child: new DoorChainManage());
                      }
                  )
                  );
                else if(catg.name == listProfileCategories[1].name)
                  Navigator.push(
                      context, MaterialPageRoute(
                      builder: (BuildContext context) {
                        return UserContainer(user: User(this.username,"1"), child: new MainUserManage());
                      }
                  )
                  );
              },
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white70,
                ),
                child: Icon(
                  catg.icon,
                  // size: 20.0,
                ),
              ),
            ),
            catg.number > 0
                ? Positioned(
                    right: -5.0,
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: profile_info_background,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        catg.number.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          catg.name,
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.white
          ),
        )
      ],
    );
  }
}
