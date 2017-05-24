import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserCenter extends StatefulWidget {
  UserCenter({Key key}) : super(key: key);

  @override
  _UserCenter createState() => new _UserCenter();
}

class _UserCenter extends State<UserCenter> {
  @override
  Widget build(BuildContext context) {
    Widget _itemLine(String lable, IconData icon) {
      return new Container(
//          height: 45.0,
          child: new RaisedButton(
//        color: Colors.white,
        colorBrightness: Brightness.light,
        onPressed: () {},
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            new Icon(icon),
            new Container(
              padding: const EdgeInsets.only(left: 2.0),
              child: new Text(lable),
            ),
            new Expanded(
              child: new Container(
                alignment: FractionalOffset.centerRight,
                child: const Icon(Icons.keyboard_arrow_right),
              ),
            ),
          ],
        ),
      ));
    }

    return new ListView(
      children: [
        new Container(
          height: 150.0,
          color: Theme.of(context).primaryColor,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                height: 100.0,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    new Icon(Icons.person_outline, size: 80.0),
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        new Text(
                          '您好',
                        ),
                        new Text(
                          'XXX',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              new Container(
                height: 50.0,
//                color: Colors.white,
                decoration: new BoxDecoration(
                  border: const Border(top: const BorderSide(width: 1.0)),
                ),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Flexible(
                      child: new Container(
                        alignment: FractionalOffset.center,
                        decoration: new BoxDecoration(
                          border: new Border(
                              right: const BorderSide(
                                  color: Colors.grey, width: 1.0)),
                        ),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Column(
                              children: [
                                new Text('525.00',
                                    style: Theme
                                        .of(context)
                                        .primaryTextTheme
                                        .title),
                                new Text('待还金额'),
                              ],
                            ),
                            new Text('元')
                          ],
                        ),
                      ),
                    ),
                    new Flexible(
                      child: new Container(
                        alignment: FractionalOffset.center,
                        decoration: new BoxDecoration(
                          border: new Border(
                              right: const BorderSide(
                                  color: Colors.grey, width: 1.0)),
                        ),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Column(
                              children: [
                                new Text('1',
                                    style: Theme
                                        .of(context)
                                        .primaryTextTheme
                                        .title),
                                new Text('需还贷款'),
                              ],
                            ),
                            new Text('笔')
                          ],
                        ),
                      ),
                    ),
                    new Flexible(
                      child: new Container(
                        alignment: FractionalOffset.center,
                        decoration: new BoxDecoration(
                          border: new Border(
                              right: const BorderSide(
                                  color: Colors.grey, width: 1.0)),
                        ),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Column(
                              children: [
                                new Text('3',
                                    style: Theme
                                        .of(context)
                                        .primaryTextTheme
                                        .title),
                                new Text('我的卡券'),
                              ],
                            ),
                            new Text('张')
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        new Container(
            margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            height: 50.0,
//            color: Colors.white,
            child: new Container(
                child: new RaisedButton(
//              color: Colors.white,
              colorBrightness: Brightness.light,
              onPressed: () {},
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  new Icon(Icons.attach_money),
                  new Container(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: new Text('借款记录'),
                  ),
                  new Expanded(
                    child: new Container(
                      alignment: FractionalOffset.centerRight,
                      child: const Icon(Icons.keyboard_arrow_right),
                    ),
                  ),
                ],
              ),
            ))),
        new Container(
//          color: Colors.green,
//          height: 100.0,
          child: new Column(
            children: [
              _itemLine('帮助中心', Icons.lightbulb_outline),
              new Divider(height: 1.0, indent: 40.0),
              _itemLine('个人资料', Icons.info),
              new Divider(height: 1.0, indent: 40.0),
              _itemLine('我的卡券', Icons.card_giftcard),
              new Divider(height: 1.0, indent: 40.0),
              _itemLine('邀请好友', Icons.person_add),
              new Divider(height: 1.0, indent: 40.0),
              _itemLine('设置', Icons.settings),
            ],
          ),
        ),
      ],
    );
  }

  void _showMessage(BuildContext context) {
    Navigator.of(context).pushNamed('/message');
  }
}
