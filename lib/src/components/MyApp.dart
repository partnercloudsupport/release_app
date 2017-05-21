import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:release_app/src/components/About.dart';
import 'package:release_app/src/components/MyHomePage.dart';
import 'package:release_app/src/components/singlePage/borrow.dart';
import 'package:release_app/src/widget/MessageCard.dart';


/**
 * 启动入口，应用的主题样式配置
 */
class MyApp extends StatelessWidget {

  final ThemeData kIOSTheme = new ThemeData(
    primarySwatch: Colors.red,
    primaryColor: Colors.red[500],
    primaryColorBrightness: Brightness.light,
  );

  final ThemeData defaultThme = new ThemeData(
    primarySwatch: Colors.blue,
    accentColor: Colors.blueAccent[400],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: defaultTargetPlatform == TargetPlatform.iOS
          ? kIOSTheme
          : defaultThme,
//      theme: new ThemeData(
//        // This is the theme of your application.
//        //
//        // Try running your application with "flutter run". You'll see
//        // the application has a blue toolbar. Then, without quitting
//        // the app, try changing the primarySwatch below to Colors.green
//        // and then invoke "hot reload" (press "r" in the console where
//        // you ran "flutter run", or press Run > Hot Reload App in IntelliJ).
//        // Notice that the counter didn't reset back to zero -- the application
//        // is not restarted.
//        primarySwatch: Colors.blue,
//      ),
      home: new About(title: '现金口贷'),
      routes: <String, WidgetBuilder>{
        '/a': (BuildContext context) => new MyHomePage(title: '我要借钱'),
        '/b': (BuildContext context) => new About(title: '口贷'),
        '/c': (BuildContext context) => new borrow(title: '我要借钱'),
        '/message': (BuildContext context) => new MessageCard(title: '信息'),
      },
    );
  }
}