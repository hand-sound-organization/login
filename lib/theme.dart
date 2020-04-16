import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Theme {

  /**
   * 登录界面，定义渐变的颜色
   */
  static const Color loginGradientStart = const Color(0xFFf39b7c);//(0xFFfbab66);5c3b83  浅紫   87eae6 浅绿   87ccd6 没有那么浅绿  6874e1    左上微黄f39b7c
  static const Color loginGradientEnd = const Color(0xFF4640c0);//(0xFFf7418c);42b7b4   淡绿    8ca6c8  浅灰   007bff蓝                      右下天蓝4640f0

  static const LinearGradient primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

}