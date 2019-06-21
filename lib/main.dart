import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_std/pages/PgMain.dart';

void main() {

//  Overlay
//  await AMap.init('71921fa552a5119c74d39fc297f1d2c4');
//  setDesignWHD(750, 1334);
//  ScreenUtil.getInstance();
//  AMap.init('71921fa552a5119c74d39fc297f1d2c4').then((v) {
  // 强制竖屏
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(new PgMain());

//  });
}
//import 'package:flutter/material.dart';
//
///**
// * 侧滑删除
// */
//void main() {
//  runApp(new MaterialApp(
//      title: "",
//      home: new MyApp(
//      )));
//}
//
//class MyApp extends StatefulWidget {
//  @override
//  MyAppState createState() => new MyAppState();
//}
//
//class MyAppState extends State<MyApp> {
//  final List<Widget> items = new List<Widget>.generate(
//      20, (i) => Text("Item ${i + 1}"));
//
//
//  @override
//  Widget build(BuildContext context) {
//    final title = "Dismissing Items";
//    return new MaterialApp(
//      title: title,
//      home: new Scaffold(
//        appBar: new AppBar(
//          title: new Text(title),
//          leading: Builder(
//            builder: (context) =>
//                IconButton(
//                  icon: Icon(Icons.crop_free,
//                      size: ScreenUtil.getScaleW(context, 25)),
//                  onPressed: () {
//                    items.removeAt(0);
//                    setState(() {
//
//                    });
//                  },
//                ),
//          ),
//        ),
//        body: new ListView.builder(
//          itemCount: items.length,
//          itemBuilder: (context, index) {
//            return new ListTile(
//              title:items[index],
//            );
//          },
//        ),
//      ),
//    );
//  }
//
//}
