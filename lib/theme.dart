import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Theme {

  /**
   * 登录界面，定义渐变的颜色
   */
  static const Color loginGradientStart = const Color(0xFFfbab66);//(0xFFfbab66);5c3b83  浅紫   87eae6 浅绿   87ccd6 没有那么浅绿  6874e1
  static const Color loginGradientEnd = const Color(0xFFf7418c);//(0xFFf7418c);42b7b4   淡绿    8ca6c8  浅灰   007bff蓝

  static const LinearGradient primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

}