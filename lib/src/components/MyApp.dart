import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:release_app/src/comm/AppRoute.dart';
import 'package:release_app/src/comm/Colors.dart';
import 'package:release_app/src/components/Home.dart';
import 'package:release_app/src/components/MyHomePage.dart';
import 'package:release_app/src/components/bottom_navigation_home.dart';
import 'package:release_app/src/components/singlePage/BorrowHome.dart';
import 'package:release_app/src/components/singlePage/BorrowCash.dart';
import 'package:release_app/src/components/singlePage/MessagePage.dart';


/**
 * 启动入口，应用的主题样式配置
 */

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeData kIOSTheme = new ThemeData(
    primarySwatch: Colors.orange,
//    primaryColor: Colors.red[500],
    primaryColorBrightness: Brightness.light,
  );

  final ThemeData defaultThme = new ThemeData(
    brightness: Brightness.light,
    primarySwatch: AppColors.primary,
//    accentColor: Colors.blueAccent[400],
  );

//  final ThemeData defaultThme = new ThemeData.light();

  Widget _home;
  @override
  void initState() {
    super.initState();
//    _createHome();
  } //  final ThemeData defaultThme = new ThemeData.dark();


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    Widget home = new BottomNavigationHome();

    return new MaterialApp(
      title: '现金口贷',
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
      home: home,
        color: Colors.grey,
//      home: _home==null?new SplashScreen():_home,
      routes: AppRoute.routes,
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: const Icon(Icons.phone)),
    );
  }
}

