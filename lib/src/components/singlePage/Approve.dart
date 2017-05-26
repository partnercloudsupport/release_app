import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:release_app/src/components/singlePage/IdentityCertificate.dart';
import 'package:release_app/src/components/singlePage/PersonalInfo.dart';

class Approve extends StatefulWidget {
  Approve({Key key}) : super(key: key);

  @override
  _ApproveState createState() => new _ApproveState();
}

class _ApproveState extends State<Approve> {
  @override
  Widget build(BuildContext context) {
//    final List<Widget> actions = <Widget>[
//      defaultTargetPlatform == TargetPlatform.iOS
//          ?
//      new CupertinoButton(
//          child: new Icon(Icons.info, color: Colors.blue), onPressed: () {
//        _showMessage(context);
//      })
//          : new IconButton(icon: const Icon(Icons.info), onPressed: () {
//        _showMessage(context);
//      }),
//    ];

    void _handlePress(int index) {
      switch (index) {
        case 0:
          Navigator.push(
              context,
              new MaterialPageRoute<DismissDialogAction>(
                builder: (BuildContext context) => new IdentityCertificate(),
                fullscreenDialog: true,
              ));
          break;
        case 1:
          Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new PersonalInfo(),
            fullscreenDialog: true,
          ));
          break;

      }
    }

    Widget _itemLine(String lable, IconData icon, int index) {
      return new Container(
          height: 45.0,
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: new InkWell(
            onTap: () {
              _handlePress(index);
            },
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                new Icon(icon,color: Theme.of(context).primaryColor,),
                new Container(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: new Text(lable),
                ),
                new Expanded(
                  child: new Container(
                    alignment: FractionalOffset.centerRight,
                    child: const Icon(Icons.done),
                  ),
//                child: const Icon(Icons.done),
                ),
              ],
            ),
          ));

//      return new Container(
//        height: 40.0,
//        padding: const EdgeInsets.only(left: 8.0),
//        color: Colors.white,
//        child: new Row(
//          mainAxisAlignment: MainAxisAlignment.start,
//          textBaseline: TextBaseline.alphabetic,
//          children: [
//            new Icon(icon),
//            new Text(lable),
//            new Row(
//              mainAxisAlignment: MainAxisAlignment.end,
//              children: [
//                const Icon(Icons.done),
//              ],
//            ),
////            new Flexible(child: const Icon(Icons.done)),
////            new Icon(Icons.done),
////          new Icon(Icons.credit_card),
////          new Icon(Icons.phone_iphone),
//          ],
//        ),
//      );
    }

    return new ListView(
      children: [
        new Container(
          height: 200.0,
          color: Theme.of(context).primaryColor,
          child: new Center(
            child: new Container(
              height: 120.0,
              width: 120.0,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
//                borderRadius: new BorderRadius.circular(100.0),
//              color: Colors.white,
                border: new Border.all(color: Colors.white, width: 2.0),
              ),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  new Text("可用额度/元"),
                  new RichText(
                    text: new TextSpan(
                      text: '',
                      style: DefaultTextStyle.of(context).style,
                      children: [
//                          new TextSpan(text: '5000', style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color: Colors.white),
                        new TextSpan(
                            text: '5000',
                            style: Theme.of(context).primaryTextTheme.title),
                        new TextSpan(text: ' .00'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
//          child: new Center(
//            child: const Icon(Icons.panorama_fish_eye, size: 150.0, color: Colors.white),
////            child: new Text(
////              '''
////              可用额度
////            人民币     元
////              '''
////              ,
////                softWrap: true
////            ),
//          ),
        ),
        new Container(
          padding: const EdgeInsets.only(left: 10.0),
          alignment: FractionalOffset.centerLeft,
          height: 40.0,
          color: Colors.grey[300],
          child: const Text('基本信息',
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        new Container(
//          color: Colors.green,
//          height: 100.0,
          child: new Column(
            children: [
              _itemLine('身份认证', Icons.account_circle, 0),
              new Divider(height: 1.0, indent: 40.0),
              _itemLine('个人信息', Icons.person, 1),
              new Divider(height: 1.0, indent: 40.0),
              _itemLine('信用认证', Icons.card_membership, 2),
              new Divider(height: 1.0, indent: 40.0),
              _itemLine('手机认证', Icons.phone_android, 3),
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
