//import 'package:flutter/material.dart';
//
//class _AnimPageState extends State<AnimPage> with SingleTickerProviderStateMixin {
//  AnimationController controller;
//  Animation<double> animation;
//
//  @override
//  void initState() {
//    super.initState();
//
//    controller = AnimationController(////创建 Animation对象
//        duration: const Duration(milliseconds: 2000), //时长
//        vsync: this);
//
//    var tween = Tween(begin: 25.0, end: 150.0); //创建从25到150变化的Animatable对象
//    animation = tween.animate(controller); //执行animate方法，生成
//    animation.addListener(() {
//      print(animation.value);
//    });
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//    controller.dispose(); // 资源释放
//  }