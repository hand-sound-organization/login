import '../icon/custome_icon.dart';
import 'package:flutter/material.dart';

//COLORS
const Color profile_info_background = Color(0xFF3775FD);
const Color profile_info_categories_background = Color(0xFFF6F5F8);
const Color profile_info_address = Color(0xFF8D7AEE);
const Color profile_info_privacy = Color(0xFFF369B7);
const Color profile_info_general = Color(0xFFFFC85B);
const Color profile_info_notification = Color(0xFF5DD1D3);
const Color profile_item_color = Color(0xFFC4C5C9);
const String imagePath = 'assets/image';

const String devMausam = 'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/mausam%2Fprofile.jpg?alt=media&token=83fa8b83-f53b-489c-a799-ca5d5aceae7b';

const Color furnitureCateDisableColor = Color(0xFF939BA9);
const List lampsImage = [
  {'image': 'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/mausam%2Fa.jpg?alt=media&token=6af6cfed-84a6-4cf3-a5ce-875fe47f8c5b'},
  {'image': 'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/mausam%2Fb.jpg?alt=media&token=801b2f22-94fd-419b-8b84-c9b4fbd45d4d'},
  {'image': 'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/mausam%2Fc.jpg?alt=media&token=b4470e0b-411f-4925-acaf-d6cb9292a44e'},
  {'image': 'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/mausam%2Fd.jpg?alt=media&token=01ed6f8d-8e1d-403a-a5a0-423b7aa958be'},
  {'image': 'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/mausam%2Fe.jpg?alt=media&token=a9342ee6-9dc6-452d-ade7-4a1d7783e7fe'},
  {'image': 'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/mausam%2Ff.jpg?alt=media&token=c65c13ad-5b2f-494e-82eb-13d730d823ce'},
];
List<ProfileMenu> lampList = [
  ProfileMenu(name: 'Landscape', time: '384'),
  ProfileMenu(name: 'Discus Pendant', time: '274'),
  ProfileMenu(name: 'Mushroom Lamp', time: '374'),
  ProfileMenu(name: 'Titanic Pendant', time: '562'),
  ProfileMenu(name: 'Torn Lighting', time: '105'),
  ProfileMenu(name: 'Abduction Pendant', time: '365'),
];
const List profileItems = [
  {'count': '46', 'name': '保护天数'},
  {'count': '51', 'name': '安全开锁次数'},
  {'count': '3', 'name': '家庭成员人数'},
  {'count': '100%', 'name': '安全系数'},
];

List<Catg> listProfileCategories = [
  Catg(name: '智能门链', icon: Icons.vpn_key, number: 0),
  Catg(name: '用户管理', icon: Icons.person, number: 0),
  //Catg(name: 'Message', icon: CustomIcon.chat, number: 2),
  //Catg(name: 'Service', icon: CustomIcon.money, number: 0),
];

List<FurnitureCatg> furnitureCategoriesList = [
  FurnitureCatg(icon: Icons.desktop_windows, elivation: true),
  FurnitureCatg(icon: CustomIcon.account_balance_wallet, elivation: false),
  FurnitureCatg(icon: Icons.security, elivation: false),
  FurnitureCatg(icon: CustomIcon.chat, elivation: false),
  FurnitureCatg(icon: CustomIcon.money, elivation: false),
];

List<ProfileMenu> profileMenuList = [
  ProfileMenu(
    name: '用户 1',
    event: '开门',
    time: 'April,21,15:34',
    iconColor: Colors.green,
    icon: Icons.check,
  ),
  ProfileMenu(
    name: '用户 1',
    event: '开门',
    time: 'April,21,15:34',
    iconColor: Colors.green,
    icon: Icons.check,
  ),
  ProfileMenu(
    name: '用户 1',
    event: '开门',
    time: 'April,21,15:34',
    iconColor: Colors.green,
    icon: Icons.check,
  ),
  ProfileMenu(
    name: '用户 1',
    event: '开门',
    time: 'April,21,15:34',
    iconColor: Colors.green,
    icon: Icons.check,
  ),
  ProfileMenu(
    name: '用户 1',
    event: '开门',
    time: 'April,21,15:34',
    iconColor: Colors.green,
    icon: Icons.check,
  ),
  ProfileMenu(
    name: '用户 1',
    event: '开门',
    time: 'April,21,15:34',
    iconColor: Colors.green,
    icon: Icons.check,
  ),
  ProfileMenu(
    name: '用户 1',
    event: '开门',
    time: 'April,21,15:34',
    iconColor: Colors.green,
    icon: Icons.check,
  ),
  ProfileMenu(
    name: '用户 1',
    event: '开门',
    time: 'April,21,15:34',
    iconColor: Colors.green,
    icon: Icons.check,
  ),
//  ProfileMenu(
//    name: 'Privacy',
//    time: 'System permission change',
//    iconColor: profile_info_privacy,
//    icon: Icons.lock,
//  ),
//  ProfileMenu(
//    name: 'General',
//    time: 'Basic functional settings',
//    iconColor: profile_info_general,
//    icon: Icons.layers,
//  ),
//  ProfileMenu(
//    name: 'Notification',
//    time: 'Take over the news in time',
//    iconColor: profile_info_notification,
//    icon: Icons.notifications,
//  ),
];

class ProfileMenu {
  String name;
  String event;
  String time;
  IconData icon;
  Color iconColor;
  ProfileMenu({this.name,this.event,this.time,this.icon, this.iconColor, });
}

class Catg {
  String name;
  IconData icon;
  int number;
  Catg({this.icon, this.name, this.number});
}

class FurnitureCatg {
  IconData icon;
  bool elivation;
  FurnitureCatg({this.icon, this.elivation});
}
