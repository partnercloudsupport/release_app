import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseui/firebaseui.dart';
import 'package:flutter/material.dart';
import 'package:release_app/src/components/Approve/IdentityCertificate.dart';
import 'package:release_app/src/components/Approve/PersonalInfo.dart';
import 'package:share/share.dart';

class Approve extends StatefulWidget {
  Approve({Key key}) : super(key: key);

  @override
  _ApproveState createState() => new _ApproveState();
}

class _ApproveState extends State<Approve> {
//  List<bool> _checkStatus= <bool>[false,false,false,false];
  int _checkStatus = -1;

  final DatabaseReference _rootRef = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    initCheckStatus();
  }

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
          _showIdentity(context);
          break;
        case 1:
          if (_checkStatus < 0) {
            showDialog(
                context: context,
                child: new AlertDialog(
                  title: const Text('提示'),
                  content: const Text('请先完成身份认证!'),
                  actions: [
                    new FlatButton(
                      child: const Text('OK'),
                      onPressed: (){Navigator.pop(context,null);},
                    ),
                  ],
                ));
            break;
          }
          _verPersonInfo(context);
          break;
        default:
          share('check out my website https://example.com');
          break;
      }
    }

    Widget _itemLine(String lable, IconData icon, int index) {
      return new Container(
        color: Colors.white,
          height: 45.0,
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: new InkWell(
            onTap: () {
              _handlePress(index);
            },
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                new Icon(
                  icon,
                  color: Theme.of(context).primaryColor,
                ),
                new Container(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: new Text(lable),
                ),
                new Expanded(
                  child: new Container(
                    alignment: FractionalOffset.centerRight,
                    child: _checkStatus >= index
                        ? const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          )
                        : const Icon(Icons.cancel),
                  ),
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

    return new Scaffold(
//      appBar: new AppBar(
//        title: const Text('认证'),
//        centerTitle: true,
//        elevation: 0.0,
//      ),
      body: new ListView(
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
            padding: const EdgeInsets.only(left: 16.0),
            alignment: FractionalOffset.centerLeft,
            height: 40.0,
//            color: Colors.grey[300],
            child: const Text('基本资料',),
          ),
          new Container(
//          color: Colors.green,
//          height: 100.0,
            child: new Column(
              children: [
                _itemLine('身份认证', Icons.account_box, 0),
                new Divider(height: 1.0, indent: 16.0,),
                _itemLine('个人信息', Icons.person, 1),
//                new Divider(height: 1.0, indent: 16.0),
                new SizedBox(height: 16.0,),
                _itemLine('信用认证', Icons.security, 2),
                new Divider(height: 1.0, indent: 16.0),
                _itemLine('手机认证', Icons.phone_iphone, 3),
                new SizedBox(height: 16.0,),
                _itemLine('上传银行卡', Icons.credit_card, 3),

              ],
            ),
          ),
        ],
      ),
    );
  }

  _showIdentity(BuildContext context) async {
    Object o = await Navigator.push(
        context,
        new MaterialPageRoute<IdentityDialogAction>(
          builder: (BuildContext context) => new IdentityCertificate(),
          fullscreenDialog: true,
        ));
    if (o == IdentityDialogAction.save) {
      setState(() {
        _checkStatus += 1;
      });
    }
  }

  void _showMessage(BuildContext context) {
    Navigator.of(context).pushNamed('/message');
  }

  _verPersonInfo(BuildContext context) async {
    bool reslut = await Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new PersonalInfo(),
          fullscreenDialog: true,
        ));
    if (reslut != null && reslut) {
      setState(() {
        _checkStatus += 1;
      });
    }
  }

  initCheckStatus() async {
    String uid;
    await Firebaseui.currentUser.then((user) {
      uid = user.uid;
    });
    _rootRef.child('person_info/${uid}/checkStatus').once().then((status) {
      if (status.value != null) {
        print('认证状态：${status.key} ${status.value}');
        setState(() {
          _checkStatus = status.value;
        });
      }
    });
  }
}
