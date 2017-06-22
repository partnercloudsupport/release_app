import 'package:firebase_database/firebase_database.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebaseui/firebaseui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:release_app/src/comm/Colors.dart';
import 'package:release_app/src/comm/CommBin.dart';
import 'package:release_app/src/components/singlePage/Approve.dart';

/**
 * Created by zgx on 2017/5/23.
 * 借款申请
 */
class BorrowCash extends StatefulWidget {
  @override
  _BorrowCashState createState() => new _BorrowCashState();
}

class _BorrowCashState extends State<BorrowCash> {
  final DatabaseReference _rootRef = FirebaseDatabase.instance.reference();
  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

//  final FirebaseAuth auth = FirebaseAuth.instance;
  double _borrowBlance = 0.00;
  double _fee = 0.00;
  int _borrowDays = 7;
  int _groupDays = 7;
  bool _otherDay = false;
  String _termUnit = '天';

  String _token = '';

  TextEditingController _daysController;

  List<DropdownMenuItem<String>> _termUnitMenu = [];


  @override
  void initState() {
    super.initState();
    _termUnitMenu.add(new DropdownMenuItem(
      child: new Text('天'),
      value: '天',
    ));
    _termUnitMenu.add(new DropdownMenuItem(
      child: const Text('月'),
      value: '月',
    ));
    _termUnitMenu.add(new DropdownMenuItem(
      child: const Text('年'),
      value: '年',
    ));
    _daysController = new TextEditingController(text: '0');
    _firebaseMessaging.getToken().then((token) {
      print('消息token：${token}');
      setState(() {
        _token = token;
      });
    });
  }

  /**
   * 提示信息
   */
  List<Widget> _dialog() {
    return <Widget>[
      const Icon(
        Icons.attach_money,
        size: 48.0,
      ),
      new SizedBox(
        height: 5.0,
      ),
      new RichText(
        textAlign: TextAlign.center,
        text: new TextSpan(
            style: const TextStyle(
                color: Colors.black54),
            text: '借款本金：',
            children: [
              new TextSpan(
                  text: '${_borrowBlance}',
                  style: new TextStyle(
                      color:
                      AppColors.primary)),
              new TextSpan(text: '元'),
            ]),
      ),
      new SizedBox(
        height: 5.0,
      ),
      new RichText(
        textAlign: TextAlign.center,
        text: new TextSpan(
            style: const TextStyle(
                color: Colors.black54),
            text: '快递信审费：',
            children: [
              new TextSpan(
                  text: '${_fee}',
                  style: new TextStyle(
                      color:
                      AppColors.primary)),
              new TextSpan(text: '元'),
            ]),
      ),
      new SizedBox(
        height: 5.0,
      ),
      new RaisedButton(
        child: const Text('我知道了'),
        onPressed: () {
          Navigator.pop(context, null);
        },
      ),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('现金口贷'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: new ListView(
        children: [
          new Container(
            height: 140.0,
            color: Theme
                .of(context)
                .primaryColor,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                new Container(
                  alignment: FractionalOffset.center,
                  child: new RichText(
                    text: new TextSpan(
                      text: '申请金额 ',
                      children: [
                        new TextSpan(
                            text: '${_borrowBlance.floor()}',
                            style: const TextStyle(fontSize: 30.0)),
                        new TextSpan(text: ' .00元'),
                      ],
                    ),
                  ),
                ),
                new Row(
                  children: [
                    new Flexible(
                      child: new Container(
                        alignment: FractionalOffset.center,
                        child: new Container(
                          decoration: new BoxDecoration(
                              border: const Border(
                                  right: const BorderSide(
                                      width: 1.0, color: Colors.white))),
                          child: new Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              new Column(
                                children: [
                                  new Text('到期应还',
                                      style: Theme
                                          .of(context)
                                          .primaryTextTheme
                                          .body2),
                                  new Text('${_borrowBlance + _fee}元',
                                      style: Theme
                                          .of(context)
                                          .primaryTextTheme
                                          .body2),
                                ],
                              ),
                              new IconButton(
                                icon: const Icon(
                                  Icons.help,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    child: defaultTargetPlatform ==
                                        TargetPlatform.iOS
                                        ? new CupertinoAlertDialog(
                                      title: const Text('提示'),
                                      content: new Text('xxx'),
                                      actions: <Widget>[
                                        new CupertinoButton(
                                            child: const Text("ok"),
                                            onPressed: () {
                                              Navigator.pop(context, null);
                                            })
                                      ],
                                    )
                                        : new SimpleDialog(
                                      contentPadding:
                                      const EdgeInsets.all(16.0),
//                                      title: const Text('借款信息'),
                                      children: _dialog(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    new Flexible(
                      child: new Container(
                        alignment: FractionalOffset.center,
                        child: new Column(
                          children: [
                            new Text('贷款期限',
                                style:
                                Theme
                                    .of(context)
                                    .primaryTextTheme
                                    .body2),
                            new Text('${_borrowDays} ${_termUnit}',
                                style:
                                Theme
                                    .of(context)
                                    .primaryTextTheme
                                    .body2),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
//                ),
              ],
            ),
          ),
          new Container(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//            height: 180.0,
//            color:Theme.of(context).backgroundColor,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: new Text('借款金额'),
                ),
                new Container(
                  width: 300.0,
                  child: defaultTargetPlatform == TargetPlatform.iOS
                      ? new CupertinoSlider(
                    onChanged: (value) {
                      setState(() {
                        _borrowBlance = value;
                        _fee =
                        value > 0 ? 5.0 * (value / 100).ceil() : 0.00;
                      });
                    },
                    value: _borrowBlance,
                    min: 0.00,
                    max: 3000.00,
                    divisions: 30,
                  )
                      : new Slider(
                    onChanged: (value) {
                      setState(() {
                        _borrowBlance = value;
                        _fee =
                        value > 0 ? 5.0 * (value / 100).ceil() : 0.00;
                      });
                    },
                    value: _borrowBlance,
                    min: 0.00,
                    max: 3000.00,
                    divisions: 30,
                    label: '${_borrowBlance}',
                  ),
                ),
                new Container(
//                  margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text('借款期限'),
                      new Row(
                        children: <Widget>[
                          new Radio<int>(
                              value: 7,
                              groupValue: _groupDays,
                              onChanged: handleRadioValueChanged),
                          const Text('7天'),
//                            new SizedBox(width: 16.0,),
                          new Radio<int>(
                              value: 15,
                              groupValue: _groupDays,
                              onChanged: handleRadioValueChanged),
                          const Text('15天'),
//                            new SizedBox(width: 16.0,),
                          new Radio<int>(
                              value: 30,
                              groupValue: _groupDays,
                              onChanged: handleRadioValueChanged),
                          const Text('30天'),
//                            new SizedBox(width: 16.0,),
                          new Radio<int>(
                              value: 0,
                              groupValue: _groupDays,
                              onChanged: handleRadioValueChanged),
                          const Text('其他'),
                        ],
                      ),
                      _otherDay
                          ? new Row(
                        children: <Widget>[
                          new Expanded(
                              child: new TextField(
                                controller: _daysController,
                                decoration: new InputDecoration(
                                    hintText: '请输入还款天数', hideDivider: true),
                                keyboardType: TextInputType.number,
                                onChanged: (days) {
                                  setState(() {
                                    _borrowDays = int.parse(days);
                                  });
                                },
                              )),
                          const Text('单位'),
                          new SizedBox(width: 16.0,),
                          new DropdownButton(
                              value: '${_termUnit}',
                              items: _termUnitMenu,
                              onChanged: (term) {
                                setState(() {
                                  _termUnit = term;
                                });
                              }),
                        ],
                      )
                          : new SizedBox(
                        height: 0.0,
                      )
                    ],
                  ),
                ),
                new SizedBox(
                  height: 16.0,
                ),
                new RaisedButton(
                  child: new Container(
                    alignment: FractionalOffset.center,
                    child: new Text('下一步'),
                  ),
                  onPressed: () {
                    handleOpenOrder();
                  },
                ),
              ],
            ),
          ),
          new Container(),
        ],
      ),
    );
  }

  void handleRadioValueChanged(int value) {
    setState(() {
      _termUnit = '天';
      _groupDays = value;
      _borrowDays = value;
      if (value == 0) {
        _termUnit = '天';
        _otherDay = true;
        _daysController.clear();
      } else {
        _otherDay = false;
      }
    });
  }

  handleOpenOrder() async {
    if (_borrowBlance < 1) {
      showMessage(context, '请选择借款金额!');
      return;
    }
    if (_borrowDays < 1) {
      showMessage(context, '请选择或输入借款期限!');
      return;
    }
    String uid;
//    await Firebaseui.currentUser.then((user) {
    await getFirebaseUser().then((user) {
      if (user == null) {
        return;
      }
      uid = user.uid;
    });

//    await auth.currentUser.getToken(refresh: true).then((token){print(token);});

    _rootRef.child('person_info/${uid}/checkStatus').once().then((status) {
      print('返回了...');
      if (status.value != 3) {
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new Approve(),
            fullscreenDialog: true));
      } else {
        //提交订单处理
        print('开始提交订单');
        _rootRef.child('orders/${uid}').push().set({
          'allBlance': _borrowBlance + _fee, //总还款金额
          'blance': _borrowBlance, //借款金额
          'term': '${_borrowDays}', //借款期限
          'terUnit': '${_termUnit}', //期限单位
          'fee': _fee, //费用
          'status': '0', //状态
          'Token': _token,
          'timestamp': new DateTime.now().millisecondsSinceEpoch,
        }).then((value) async {
          print('已创建订单...');
          await showMessage(context, '创建订单成功！');
          //转到订单页面
          Navigator.pushNamed(context, '/borrowRecord').then((v) {
            Navigator.pop(context, null);
          });
          print('已跳转...');
//          _handleCreateOrder(value);
        }, onError: (e) {
          showMessage(context, '${e.message}');
        });
      }
    });
  }

  showMessage(BuildContext context, String message) async {
    await showDialog(
        context: context,
        child: defaultTargetPlatform == TargetPlatform.iOS
            ? new CupertinoAlertDialog(
          title: const Text('提示'),
          content: new Text('${message}'),
          actions: <Widget>[
            new CupertinoButton(
                child: const Text("ok"),
                onPressed: () {
                  Navigator.pop(context, null);
                })
          ],
        )
            : new AlertDialog(
            title: const Text('提示'),
            content: new Text('${message}'),
            actions: [
              new FlatButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context, null);
                },
              ),
            ]));
  }

  _handleCreateOrder(value) async {
    await showMessage(context, '创建订单成功！');
    //转到订单页面
    Navigator.pushNamed(context, '/borrowRecord');
    print('已跳转...');
  }
}
