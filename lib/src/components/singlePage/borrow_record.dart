// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
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
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  final List<SingleRecord> _listRecord = <SingleRecord>[];

  @override
  void initState() {
    super.initState();
    _initRecordDebug(new Completer<Null>());
  }

  @override
  Widget build(BuildContext context) {
    Widget _recordItem() {
      return new Card(
        child: new InkWell(
            onTap: () {},
            child: new Column(
              children: [
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new Container(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: const FlutterLogo(),
                    ),
                    new Container(
                      child: new Text('借款',
                          style: Theme.of(context).primaryTextTheme.subhead),
                    ),
                    new Flexible(
                        child: new Text('ABC-1234564654',
                            style: Theme.of(context).primaryTextTheme.subhead)),
                  ],
                ),
                const Divider(),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new Container(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: new Text('金额',
                          style: Theme.of(context).primaryTextTheme.body1),
                    ),
                    new Text('期限',
                        style: Theme.of(context).primaryTextTheme.body1),
                    new Container(
                      padding: const EdgeInsets.all(5.0),
                      child: new Text('状态',
                          style: Theme.of(context).primaryTextTheme.body1),
                    ),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new Container(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: new Text('500元',
                          style: Theme.of(context).primaryTextTheme.body2),
                    ),
                    new Text('7天',
                        style: Theme.of(context).primaryTextTheme.body2),
                    new Container(
                      padding: const EdgeInsets.all(5.0),
                      child: new Text('初审通过',
                          style: Theme.of(context).primaryTextTheme.body2),
                    ),
                  ],
                ),
              ],
            )),
//        child: ,
      );
    }

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
//    _initRecord(completer);   //因没有接口，先注释掉
    _initRecordDebug(completer); //暂时用写死的数据测试

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
    String url = '';
    await http
        .get(url)
        .then((res) {
          _initList(res);
        })
        .timeout(const Duration(seconds: 30))
        .whenComplete(() {
          completer.complete(null);
        });
  }

  void _initRecordDebug(Completer<Null> completer) {
    _listRecord.clear();
    setState(() {
      _listRecord.add(new SingleRecord(
        balance: 1000.00,
        term: '7天',
        status: '通过',
        animationController: new AnimationController(
          vsync: this,
          duration: new Duration(milliseconds: 800),
        ),
      ));
      _listRecord.add(new SingleRecord(
        balance: 1500.00,
        term: '7天',
        status: '通过',
        animationController: new AnimationController(
          vsync: this,
          duration: new Duration(milliseconds: 800),
        ),
      ));
      _listRecord.add(new SingleRecord(
        balance: 1000.00,
        term: '16天',
        status: '未通过',
        animationController: new AnimationController(
          vsync: this,
          duration: new Duration(milliseconds: 800),
        ),
      ));
    });
    new Timer(const Duration(seconds: 2), () {
      completer.complete(null);
    });

    for (var i = 0; i < _listRecord.length; ++i) {
      _listRecord[i].animationController.forward();
    }
  }

  void _initList(http.Response res) {
    Map data = JSON.decode(res.body);
    print(data['data']);
    List<Map> recs = data['data'];
    _listRecord.clear();
    setState(() {
      for (int i = 0; i < recs.length; i++) {
        _listRecord.add(new SingleRecord(
          balance: recs[i]['xx'],
          term: recs[i]['xx'],
          status: recs[i]['xx'],
          animationController: new AnimationController(
            vsync: this,
            duration: new Duration(milliseconds: 800),
          ),
        ));
      }
    });

    for (var i = 0; i < _listRecord.length; ++i) {
      _listRecord[i].animationController.forward();
    }
  }
}
