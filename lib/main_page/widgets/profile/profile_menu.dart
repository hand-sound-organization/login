import '../../utils/constant.dart';
import '../../widgets/profile/menu_item.dart';
import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  Widget divider = Container(
    height: 10,
    color: Color(0x00000000),
  );
  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: ListView.separated(
        itemCount: 8,
        //itemExtent: 80.0, //强制高度为50.0
        itemBuilder: (BuildContext context, int index) {
          return  MenuItem(menu: profileMenuList[index],);
        },
        separatorBuilder: (BuildContext context, int index) {
          return divider;
        },
      ),
    );

//      Column(
//      mainAxisSize: MainAxisSize.max,
//      mainAxisAlignment: MainAxisAlignment.spaceAround,
//      children: <Widget>[
//
////        for (var menu in profileMenuList)
////          MenuItem(
////            menu: menu,
////          ),
//      ],
//    );
  }
}
