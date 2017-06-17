// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseui/firebaseui.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:release_app/src/bin/BorrowRecord.dart';

class BorrowRecord extends StatefulWidget {
  static const String routeName = '/material/two-level-list';

  @override
  _BorrowRecordState createState() => new _BorrowRecordState();
}

class _BorrowRecordState extends State<BorrowRecord>
    with TickerProviderStateMixin {
  final DatabaseReference _rootRef = FirebaseDatabase.instance.reference();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  final List<SingleRecord> _listRecord = <SingleRecord>[];

  @override
  void initState() {
    super.initState();
//    _initRecordDebug(new Completer<Null>());
    _initRecord(new Completer<Null>());
  }

  @override
  Widget build(BuildContext context) {
//    Widget _recordItem() {
//      return new Card(
//        child: new InkWell(
//            onTap: () {},
//            child: new Column(
//              children: [
//                new Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: [
//                    new Container(
//                      padding: const EdgeInsets.only(left: 5.0),
//                      child: const FlutterLogo(),
//                    ),
//                    new Container(
//                      child: new Text('借款',
//                          style: Theme.of(context).textTheme.subhead),
//                    ),
//                    new Flexible(
//                        child: new Text('ABC-1234564654',
//                            style: Theme.of(context).primaryTextTheme.subhead)),
//                  ],
//                ),
//                const Divider(),
//                new Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: [
//                    new Container(
//                      padding: const EdgeInsets.only(left: 5.0),
//                      child: new Text('金额',
//                          style: Theme.of(context).primaryTextTheme.body1),
//                    ),
//                    new Text('期限',
//                        style: Theme.of(context).primaryTextTheme.body1),
//                    new Container(
//                      padding: const EdgeInsets.all(5.0),
//                      child: new Text('状态',
//                          style: Theme.of(context).primaryTextTheme.body1),
//                    ),
//                  ],
//                ),
//                new Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: [
//                    new Container(
//                      padding: const EdgeInsets.only(left: 5.0),
//                      child: new Text('500元',
//                          style: Theme.of(context).primaryTextTheme.body2),
//                    ),
//                    new Text('7天',
//                        style: Theme.of(context).primaryTextTheme.body2),
//                    new Container(
//                      padding: const EdgeInsets.all(5.0),
//                      child: new Text('初审通过',
//                          style: Theme.of(context).primaryTextTheme.body2),
//                    ),
//                  ],
//                ),
//              ],
//            )),
////        child: ,
//      );
//    }

    return new Scaffold(
      appBar: new AppBar(title: const Text('我的借款'), centerTitle: true),
      body: new RefreshIndicator(
        key: _refreshIndicatorKey,
        child: new ListView.builder(
          itemBuilder: (_, int index) => _listRecord[index],
          itemCount: _listRecord.length,
        ),
        onRefresh: _handleRefresh,
      ),
//      body: new ListView(
//        children: <Widget>[
//          _recordItem(),
//          _recordItem(),
//          _recordItem(),
//        ]
//      )
    );
  }

  Future<Null> _handleRefresh() {
    final Completer<Null> completer = new Completer<Null>();
    _initRecord(completer); //因没有接口，先注释掉
//    _initRecordDebug(completer); //暂时用写死的数据测试

    return completer.future.then((_) {
//      print("刷新返回");
//      _scaffoldKey.currentState?.showSnackBar(new SnackBar(
//          content: const Text("Refresh complete"),
//          action: new SnackBarAction(
//              label: 'RETRY',
//              onPressed: () {
//                _refreshIndicatorKey.currentState.show();
//              }
//          )
//      ));
    });
  }

  Future<Null> _initRecord(Completer<Null> completer) async {
//    String url = '';
//    await http
//        .get(url)
//        .then((res) {
//          _initList(res);
//        })
//        .timeout(const Duration(seconds: 30))
//        .whenComplete(() {
//          completer.complete(null);
//        });
    String uid;
    await Firebaseui.currentUser.then((user) {
      if (user == null) {
        return;
      }
      uid = user.uid;
    });
    _rootRef.child('orders/${uid}').once().then((records) {
      _initList(records);
    }).whenComplete(() {
      completer.complete(null);
    });
  }

  void _initList(DataSnapshot snapshot) {
    if (snapshot.value == null) {
      return;
    }

    _listRecord.clear();

    Map<String, dynamic> recs = snapshot.value;

    setState(() {
      recs.forEach((key, dynamic rec) {
        print(rec['blance']);
        _listRecord.add(new SingleRecord(
          orderno: key,
          balance: rec['blance'],
          term: rec['term'],
          termUnit: rec['terUnit'],
          status: rec['status'],
          animationController: new AnimationController(
            vsync: this,
            duration: new Duration(milliseconds: 500),
          ),
        ));
      });
    });

    for (var i = 0; i < _listRecord.length; ++i) {
      _listRecord[i].animationController.forward();
    }
  }
}
