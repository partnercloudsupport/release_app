import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:release_app/src/components/singlePage/Approve.dart';
import 'package:release_app/src/components/singlePage/Borrow.dart';
import 'package:release_app/src/components/singlePage/UserCenter.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  final List<Widget> _tabs = [
    new Tab(text: '借钱', icon: const Icon(Icons.home, size: 24.0)),
    new Tab(text: '认证', icon: const Icon(Icons.assignment, size: 24.0)),
    new Tab(text: '我的', icon: const Icon(Icons.person_pin, size: 24.0)),
  ];

  final List<Widget> _tabviews = <Widget>[
    new Borrow(title: '我要借钱'),
    new Approve(),
    new UserCenter(),
  ];

  TabController _tabController;

  var _drawer = new Drawer();


  @override
  void initState() {
    super.initState();
    _tabController = new TabController(
        length: _tabs.length,
        vsync: this,
    );
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return new Scaffold(
//      drawer: _drawer,
      appBar: new AppBar(
        title: new Text(widget.title),
        bottom: new TabBar(
          tabs: _tabs,
//          indicatorColor: Colors.white,
//          unselectedLabelColor: Colors.grey,
          controller: _tabController,
          labelColor: Colors.white,
        ),
        actions: [
          new CupertinoButton(
            child: new Text('消息', style: const TextStyle(color: Colors.white)),
            onPressed: (){
              Navigator.of(context).pushNamed('/message');
            },
          ),
        ],
      ),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Flexible(
              child: new TabBarView(
                children: _tabviews,
                controller: _tabController,
              ),
          ),
//          new Container(
//            color: Colors.blue,
//            child: new TabBar(
//              tabs: _tabs,
////          indicatorColor: Colors.white,
////          unselectedLabelColor: Colors.grey,
//              controller: _tabController,
////              labelColor: Colors.white,
//            ),
//          ),


        ],
      ),
//      body: new Column(
////        color: Colors.green[300]
//        children: <Widget>[
//          new Flexible(
//            child: new Container(
//              color: Colors.green[500],
//              child: new Center(
//                child: new Text('hehe'),
//              ),
//            ),
//          ),
//        ],
//      ),

    );
  }
}