import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:release_app/src/components/listItem/MessageItem.dart';
import 'package:release_app/src/comm/CommBin.dart';

/**
 * Created by zgx on 2017/5/23.
 */
class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => new _MessagePageState();
}

class _MessagePageState extends State<MessagePage> with TickerProviderStateMixin {
  final List<MessageItem> _listMessage = <MessageItem>[];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text('系统消息'),
        centerTitle: true,
      ),
      //正常版本，不可下拉刷新
//      body: new Column(
//        children: <Widget>[
//          new Flexible(
//            child: new ListView.builder(
//              reverse: false,
//              itemBuilder: (_, int index)=> _listMessage[index],
//              itemCount: _listMessage.length,
//            ),
//          ),
//          new InkWell(
//            onTap: () {
////                print('联系客服了，。。。');
//            },
//            child: new Container(
//              color: Colors.grey[200],
//              height: 40.0,
//              alignment: FractionalOffset.center,
//              child: new Text('有疑问？请联系客服>'),
//            ),
//          ),
//        ],
//      ),

      //下拉刷新版本,带动画效果版本

      body: new Container(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Flexible(
              child: new RefreshIndicator(
                key: _refreshIndicatorKey,
                child: new ListView.builder(
//                  reverse: false,
                  itemBuilder: (_, int index) => _listMessage[index],
                  itemCount: _listMessage.length,
                ),
                onRefresh: _handleRefresh,
              ),
            ),
            new InkWell(
              onTap: () async {
//                print('联系客服了，。。。');
//                File imageFile = await ImagePicker.pickImage();
              },
              child: new Container(
                color: Theme.of(context).splashColor,
                height: 40.0,
                alignment: FractionalOffset.center,
                child: new Text('有疑问？请联系客服>'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initMessage(new Completer<Null>());
  }

  Future<Null> _initMessage(Completer<Null> completer) async {
    Map data;
    String url = 'http://tz88.com.cn/cmfx/posts/all';
    await http
        .get(url)
        .then((res) {
          _initList(res);
//          print("刷新完成");
          print(_listMessage.length);
        })
        .timeout(const Duration(seconds: 30))
        .whenComplete(() {
          completer.complete(null);
        });
  }

  void _initList(http.Response res) {
    print(res.body);
    Map data = JSON.decode(res.body);
    print(data['data']);
    List<Map> msgs = data['data'];
//    _listMessage.clear();
    setState(() {
      for (int i = 0; i < msgs.length; i++) {
        Message message = new Message(
            msgs[i]['post_title'],
            msgs[i]['post_excerpt'],
            msgs[i]['post_modified'],
            new AnimationController(
              vsync: this,
              duration: new Duration(milliseconds: 800),
            )
        );
        _listMessage.add(
            new MessageItem(
              message: message,
            ));
      }
    });

    for (var i = 0; i < _listMessage.length; ++i) {
      _listMessage[i].message.animationController.forward();

    }
  }

  Future<Null> _handleRefresh() {
    final Completer<Null> completer = new Completer<Null>();
    _initMessage(completer);

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

  @override
  void dispose() {
    for(MessageItem msg in _listMessage){
      msg.message.animationController.dispose();
    }
    super.dispose();
  }


}
