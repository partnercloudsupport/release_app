import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BorrowHome extends StatefulWidget {
  BorrowHome({
    Key key,
    this.title,
  })
      : super(key: key);

  // This widget is the home page of your application. It is stateful,
  // meaning that it has a State object (defined below) that contains
  // fields that affect how it looks.

  // This class is the configuration for the state. It holds the
  // values (in this case the title) provided by the parent (in this
  // case the App widget) and used by the build method of the State.
  // Fields in a Widget subclass are always marked "final".

  final String title;

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

    return new Column(
      children: [
        new Flexible(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Image.asset(
                'images/ic_center_more_icon.png',
                height: 200.0,
                width: 200.0,
                fit: BoxFit.contain,
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
                        onPressed: () {},
                        child: const Text(
                          '我要借钱',
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        color: Theme.of(context).primaryColor,
                        //                    highlightColor: Colors.grey[100],
                      )
                    : new RaisedButton(
                        onPressed: () {},
                        child: const Text(
                          '我要借钱',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        color: Theme.of(context).buttonColor,
                      ),
                height: 45.0,
                width: 200.0,
              ),
              new RichText(
                text: new TextSpan(
                  text: '简单4步，放款只需',
                  children: [
                    new TextSpan(text: '20', style: const TextStyle(color: Colors.redAccent)),
                    new TextSpan(text: '分钟'),
                  ],
                  style: const TextStyle(color: Colors.grey),
                ),

              ),
            ],
          ),
        )
      ],
    );
  }

  void _showMessage(BuildContext context) {
    Navigator.of(context).pushNamed('/message');
  }
}
