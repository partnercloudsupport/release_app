import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseui/firebaseui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:release_app/src/comm/Colors.dart';
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
  double _borrowBlance = 0.00;
  double _fee = 0.00;
  int _borrowDays = 7;
  int _groupDays = 7;
  bool _otherDay = false;

  TextEditingController _daysController;

  @override
  void initState() {
    super.initState();
    _daysController = new TextEditingController(text: '0');
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
            color: Theme.of(context).primaryColor,
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
                                  new Text('${_borrowBlance+_fee}元',
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
                                    child: new SimpleDialog(
                                      contentPadding:
                                          const EdgeInsets.all(16.0),
//                                      title: const Text('借款信息'),
                                      children: <Widget>[
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
                                      ],
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
                                    Theme.of(context).primaryTextTheme.body2),
                            new Text('${_borrowDays}天',
                                style:
                                    Theme.of(context).primaryTextTheme.body2),
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
                          ? new TextField(
                              controller: _daysController,
                              decoration: new InputDecoration(
                                  hintText: '请输入还款天数', hideDivider: true),
                              keyboardType: TextInputType.number,
                              onSubmitted: (days) {
                                setState(() {
                                  _borrowDays = int.parse(days);
                                });
                              },
                            )
                          : new SizedBox()
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
      _groupDays = value;
      _borrowDays = value;
      if (value == 0) {
        _otherDay = true;
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
    await Firebaseui.currentUser.then((user) {
      uid = user.uid;
    });
    _rootRef.child('person_info/${uid}/checkStatus').once().then((status) {
      print('返回了...');
      if (status.value != 3) {
        Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new Approve(),
          fullscreenDialog: true
            ));
      }
    });
  }

  showMessage(BuildContext context, String message) {
    showDialog(
        context: context,
        child: new AlertDialog(
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
}
