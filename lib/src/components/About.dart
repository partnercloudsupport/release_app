import 'package:flutter/material.dart';
import 'package:release_app/src/components/singlePage/borrow.dart';

class About extends StatefulWidget {
  About({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful,
  // meaning that it has a State object (defined below) that contains
  // fields that affect how it looks.

  // This class is the configuration for the state. It holds the
  // values (in this case the title) provided by the parent (in this
  // case the App widget) and used by the build method of the State.
  // Fields in a Widget subclass are always marked "final".

  final String title;

  @override
  _AboutState createState() => new _AboutState();
}

class _AboutState extends State<About> with SingleTickerProviderStateMixin {

  final List<Widget> _tabs = [
    new Tab(text: '借钱', icon: const Icon(Icons.home, size: 24.0)),
    new Tab(text: '认证', icon: const Icon(Icons.assignment, size: 24.0)),
    new Tab(text: '我的', icon: const Icon(Icons.person_pin, size: 24.0)),
  ];

  final List<Widget> _tabviews = <Widget>[
    new borrow(title: '我要借钱'),
    new borrow(title: '认证'),
    new borrow(title: '我的'),
  ];

  TabController _tabController;


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
    // This method is rerun every time setState is called, for instance
    // as done by the _incrementCounter method above.
    // The Flutter framework has been optimized to make rerunning
    // build methods fast, so that you can just rebuild anything that
    // needs updating rather than having to individually change
    // instances of widgets.
    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text(widget.title),
////        bottom: new TabBar(
////          tabs: _tabs,
//////          indicatorColor: Colors.white,
//////          unselectedLabelColor: Colors.grey,
////          controller: _tabController,
////          labelColor: Colors.white,
////        ),
//      ),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Flexible(
              child: new TabBarView(
                children: _tabviews,
                controller: _tabController,
              ),
          ),
          new Container(
            color: Colors.blue,
            child: new TabBar(
              tabs: _tabs,
//          indicatorColor: Colors.white,
//          unselectedLabelColor: Colors.grey,
              controller: _tabController,
              labelColor: Colors.white,
            ),
          ),


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