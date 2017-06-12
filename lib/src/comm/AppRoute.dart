import 'package:flutter/material.dart';
import 'package:release_app/src/components/Home.dart';
import 'package:release_app/src/components/MyHomePage.dart';
import 'package:release_app/src/components/singlePage/BorrowCash.dart';
import 'package:release_app/src/components/singlePage/Login.dart';
import 'package:release_app/src/components/singlePage/MessagePage.dart';
import 'package:release_app/src/components/UserCenter/borrow_record.dart';


/**
 * Created by zgx on 2017/5/23.
 */

class AppRoute {

  static  Map<String, WidgetBuilder> routes = {
    '/cash': (BuildContext context) => new BorrowCash(),
    '/message': (BuildContext context) => new MessagePage(),
    '/login': (BuildContext context) => new Login(),
    '/borrowRecord': (BuildContext context) => new BorrowRecord(),

  };

  AppRoute();
}

 