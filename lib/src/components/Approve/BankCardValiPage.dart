import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:release_app/src/comm/CommBin.dart';

/**
 * Created by zgx on 2017/6/7.
 * 银行卡认证
 */
class BankCardValidPage extends StatefulWidget {
  BankCardValidPage(this.bankcard, {Key key}) : super(key: key);
  final BankCard bankcard;
  @override
  _BankCardValidPageState createState() => new _BankCardValidPageState();
}

class _BankCardValidPageState extends State<BankCardValidPage> {
  final DatabaseReference _rootRef = FirebaseDatabase.instance.reference();
  final GlobalKey<FormState> _fomrKey = new GlobalKey<FormState>();
  BankCard _bankcard;

  String _openBank = '';

  String _openCity = '';

  TextEditingController _phoneController;
  TextEditingController _cardController;
  TextEditingController _confirmCardController;

  SliverChildListDelegate _bankSlivertList =
      new SliverChildListDelegate(<Widget>[]);
  SliverChildListDelegate _citySlivertList =
  new SliverChildListDelegate(<Widget>[]);


  int _index =0;

  @override
  void initState() {
    super.initState();
    _phoneController = new TextEditingController(
        text: widget.bankcard.phoneNo != null
            ? widget.bankcard.phoneNo
            : TextEditingValue.empty);
    _cardController = new TextEditingController(
        text: widget.bankcard.cardNo != null
            ? widget.bankcard.cardNo
            : TextEditingValue.empty);
    _confirmCardController = new TextEditingController();
    _openBank = widget.bankcard.openBank;
    _openCity = widget.bankcard.opencity;
    _initValiable();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _bottonInputItem(String label, int index) {
      return new InkWell(
        onTap: () {
          _handleClick(index);
        },
        child: new Container(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          color: Colors.white,
          height: 45.0,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Expanded(
                flex: 1,
                child: new Text(label),
              ),
              new Expanded(
                flex: 2,
                child: index == 0
                    ? new Text(_openBank)
                    : index == 1 ? new Text(_openCity) : null,
              ),
              new Expanded(
                flex: 1,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Icon(
                      Icons.arrow_drop_down,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.grey.shade700
                          : Colors.white70,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        title: const Text('银行卡认证'),
        centerTitle: true,
      ),
      body: new Form(
        key: _fomrKey,
        child: new SingleChildScrollView(
          child: new Container(
            child: new Column(
              children: <Widget>[
                new Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  child: new Column(
                    children: <Widget>[
                      _bottonInputItem('开户行', 0),
                      new Divider(height: 1.0, indent: 16.0 ),
                      _bottonInputItem('开户省市', 1),
                      new SizedBox(height: 16.0,),
                      new Container(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        color: Colors.white,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Expanded(
                              child: new Text('预留手机号'),
                              flex: 1,
                            ),
                            new Expanded(
                              flex: 3,
                              child: new TextFormField(
                                decoration: new InputDecoration(
                                    hideDivider: true
                                ),
                                controller: _phoneController != null
                                    ? _phoneController
                                    : null,
                                validator: _validCompInfo,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ),
                      new SizedBox(height: 16.0,),
                      new Container(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        color: Colors.white,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Expanded(
                              child: new Text('银行卡号'),
                              flex: 1,
                            ),
                            new Expanded(
                              flex: 3,
                              child: new TextFormField(
                                decoration: new InputDecoration(
                                    hideDivider: true
                                ),
                                controller: _cardController != null
                                    ? _cardController
                                    : null,
                                validator: _validCompInfo,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Divider(height: 1.0,),
                      new Container(
                        color: Colors.white,
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Expanded(
                              child: new Text('确认卡号'),
                              flex: 1,
                            ),
                            new Expanded(
                              flex: 3,
                              child: new TextFormField(
                                decoration: new InputDecoration(
                                    hideDivider: true
                                ),
                                controller: _confirmCardController != null
                                    ? _confirmCardController
                                    : null,
                                validator: _validConfirmCard,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                new SizedBox(height: 16.0,),
                new Container(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: new Row(
                    children: <Widget>[
                      const Icon(Icons.info),
                      new Text('必须使用本人名下借记卡，暂不支持信用卡'),
                    ],
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 30.0),
                  child: new RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      _handleSubmit();
                    },
                    child: const Text('确定'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomModel(String value) {
    return new InkWell(
//      key: key,
      child: new Container(
        child: new Text(value),
        alignment: FractionalOffset.center,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        height: 48.0,
      ),
      onTap: () {
        setState(() {
          switch (_index) {
            case 0:
              _openBank = value;
              break;
            case 1:
              _openCity = value;
              break;
          }
        });
        Navigator.pop(context);
      },
    );
  }

  void _handleClick(int index) {
    setState((){_index = index;});
    showModalBottomSheet<String>(
        context: context,
        builder: (BuildContext context) {
          return new CustomScrollView(slivers: <Widget>[
            new SliverList(
              delegate: index==0?_bankSlivertList:_citySlivertList,
            ),
          ]);
        }).then((value) {
      setState(() {});
    });
  }

  /**
   * 初始化底部弹出框内容
   */
  _initValiable() async {
    _rootRef.child('comm/banks').once().then((data) {
      print("key:" + data.key + " Value:" + data.value.toString());
      Map<String, dynamic> maps = data.value;
      setState(() {
        for (var key in maps.keys) {
          _bankSlivertList.children.add(_bottomModel(key));
        }
      });
    });
  }

  void _handleSubmit() {
    FormState form = _fomrKey.currentState;
    if (!form.validate()) {
      return;
    } else {
      _bankcard = new BankCard(_openBank,_openCity, _phoneController.value.text,
           _cardController.value.text);
      print(_phoneController.value.text);
      Navigator.pop(context, _bankcard);
    }
  }

  String _validCompInfo(String value) {
    if (value.isEmpty) {
      return '请输入此项内容!';
    }
    return null;
  }
  String _validConfirmCard(String value) {
    if (value.isEmpty) {
      return '请输入此项内容!';
    }
    if (value!=_cardController.value.text){
      return '确认卡号与卡号不一致，请检查!';
    }
    return null;
  }
}
