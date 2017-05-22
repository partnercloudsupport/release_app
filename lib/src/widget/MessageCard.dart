import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:release_app/src/components/singlePage/Borrow.dart';

class MessageCard extends StatefulWidget {
  MessageCard({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MessageCardState createState() => new _MessageCardState();
}

class _MessageCardState extends State<MessageCard>
    with SingleTickerProviderStateMixin {
  final List<BottomNavigationBarItem> _bottomBarList = [
    new BottomNavigationBarItem(
        icon: const Icon(Icons.assignment), title: new Text('登录')),
    new BottomNavigationBarItem(
        icon: const Icon(Icons.access_time), title: new Text('二屏')),
    new BottomNavigationBarItem(
        icon: const Icon(Icons.person), title: new Text('我的')),
  ];

  final List<Widget> _tabviews = <Widget>[
    new Borrow(title: '我要借钱'),
    new Borrow(title: '认证'),
    new Borrow(title: '我的'),
  ];


  TabController _tabController;
  int _index;
  TabController get tabController => _tabController;

//  ScrollController _ScrollController;

  @override
  void initState() {
    super.initState();
    _tabController =
        new TabController(length: _bottomBarList.length, vsync: this);
    _tabController.addListener(_handleTabController);
    _tabController.animation.addListener(_handleTabAnimationController);
    if (_index == null || _index < 0) {
      _index = 0;
    }
//    _ScrollController = new ScrollController();
//    _ScrollController.addListener();
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabController);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),

//      body: new Card(
//        color: Colors.green,
//        child: new Container(
//          height: 100.0,
//          width: 200.0,
//          child: new Text('hahah'),
//        ),
//      ),

        body: new Container(
          child: new TabBarView(
            children: _tabviews,
            controller: _tabController,
          ),
        ),

//      body: new ListView(
//
//        children: [
//          new Card(
//            color: Colors.grey[100],
//            child: new Column()
//          ),
//        ],
//      ),

      //底部导航栏
      bottomNavigationBar: new BottomNavigationBar(
        items: _bottomBarList,
        currentIndex: _index,
        onTap: (index) {
          setState(() {
            _index = index;
            _tabController.animateTo(index);
          });
        },
      ),
//时间选择器
//      body: new Card(
//        color: Colors.grey[100],
//        child: new Container(
//          height: 150.0,
//          child: new DayPicker(
//              selectedDate: new DateTime.now(),
//              currentDate: new DateTime.now(),
//              onChanged: (date) {
////                  showDialog(context: context, child: new Text(date.toIso8601String()));
////                  showAboutDialog(context: context);
//                if (Platform.isIOS) {
//                  showDialog(
//                      context: context,
//                      child: new CupertinoAlertDialog(
//                        title: new Text('提醒'),
//                        content: new Text(date.toIso8601String()),
//                        actions: [
//                          new CupertinoButton(
//                              child: new Text('确定'),
//                              onPressed: () {
//                                Navigator.of(context).pop();
//                              }),
//                        ],
//                      ));
//                } else {
//
//                }
//              },
//              firstDate: new DateTime(2017),
//              lastDate: new DateTime(2018),
//              displayedMonth: new DateTime.now()),
//        ),
//      ),

//      body: new Container(
//        height: 150.0,
//        child: new Card(
//          color: Colors.grey[100],
//          child: new Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              new ListTile(
//                title: const Text('title'),
//                subtitle: const Text('sub title'),
//                isThreeLine: true,
//                trailing: const Icon(Icons.title),
//              ),
//              new RichText(
//                text: new TextSpan(
//                  text: '文本',
//                  style: DefaultTextStyle.of(context).style,
//                  children: <TextSpan>[
//                    new TextSpan(text: 'bold', style: new TextStyle(fontWeight: FontWeight.bold)),
//                    new TextSpan(text: ' world!'),
//                  ],
//                ),
//
//              ),
//            new Row(
//              mainAxisAlignment: MainAxisAlignment.start,
//              children: [
//                new RawImage()
//              ],
//            ),
//            ],
//          ),
//        )
//      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('当前tab index：' + _tabController.index.toString());
    setState(() {
      _index = _tabController?.index;
    });
  }

  void _handleTabController() {
    print('监听tab index：' +
        _tabController.index.toString() +
        '是否changing:' +
        _tabController.indexIsChanging.toString());
//    if (_tabController.indexIsChanging){
    setState(() {
      _index = _tabController.index;
    });
//    }
  }

  @override
  void didUpdateWidget(MessageCard oldWidget) {
    super.didUpdateWidget(oldWidget);

  }



  void _handleTabAnimationController() {
    print("animation : "+ _tabController.index.toString() +"changing: "+_tabController.indexIsChanging.toString());
  }
}
