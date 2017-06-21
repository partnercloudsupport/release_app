import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:release_app/src/comm/Colors.dart';
import 'package:release_app/src/logo/logo.dart';

class BorrowHome extends StatefulWidget {
  final String title;

  BorrowHome({
    Key key,
    this.title,
  })
      : super(key: key);

//  final BuildContext context;

  @override
  _BorrowHomeState createState() => new _BorrowHomeState();
}

class _BorrowHomeState extends State<BorrowHome> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> actions = <Widget>[
//    new CupertinoButton(
//      onPressed: (){},
//      child: new Text('消息'),
//    ),
//
//    new IconButton(
//      onPressed: (){},
//      icon: const Icon(Icons.info),
//    ),
      defaultTargetPlatform == TargetPlatform.iOS
          ? new CupertinoButton(
              child: new Icon(Icons.info, color: Colors.blue),
              onPressed: () {
                _showMessage(context);
              })
          : new IconButton(
              icon: const Icon(Icons.info),
              onPressed: () {
                _showMessage(context);
              }),
    ];

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        centerTitle: true,
        actions: [
          new CupertinoButton(
            child: new Text(
              '消息',
              style: new TextStyle(color: Theme.of(context).buttonColor),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/message');
            },
          ),
        ],
      ),
      body: new Center(
          child: new Column(
        children: [
          new Flexible(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
//                new Image.asset(
//                  'images/ic_center_more_icon.png',
//                  height: 200.0,
//                  width: 200.0,
//                  fit: BoxFit.contain,
//                ),
//                new CashLogo(size: 200.0,colors: AppColors.primary,),
                new Container(
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
//                    color: AppColors.primary,
                  ),
                    alignment: FractionalOffset.center,
                  child: new CashLogo(
                    size: 150.0,
                  ),
//                  child: new Icon(
//                    Icons.attach_money,
//                    size: 150.0,
//                    color: AppColors.primary.shade100,
//                  ),
                ),
                new Container(
//                decoration: defaultTargetPlatform == TargetPlatform.iOS
//                    ? null
//                    : new BoxDecoration(
//                        border: new Border.all(
//                          color: Colors.grey,
//                          width: 2.0,
//                        ),
//                        borderRadius:
//                            new BorderRadius.all(new Radius.circular(8.0)),
//                      ),
                  margin: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: defaultTargetPlatform == TargetPlatform.iOS
                      ? new CupertinoButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/cash');
                          },
                          child: const Text(
                            '我要借钱',
                            style: const TextStyle(
//                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
//                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          color: Theme.of(context).primaryColor,
                        )
                      : new RaisedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/cash');
                          },
                          child: const Text(
                            '我要借钱',
                          ),
//                          color: Theme.of(context).primaryColor,
                        ),
                  height: 45.0,
                  width: 200.0,
                ),
                new RichText(
                  text: new TextSpan(
                    text: '简单4步，放款只需',
                    children: [
                      new TextSpan(
                          text: '20',
                          style: new TextStyle(
                              color: Theme.of(context).primaryColor)),
                      new TextSpan(text: '分钟'),
                    ],
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }

  void _showMessage(BuildContext context) {
    Navigator.of(context).pushNamed('/message');
  }
}
