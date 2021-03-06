import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseui/firebaseui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:release_app/src/comm/CommBin.dart';
import 'package:release_app/src/comm/commBottomModel.dart';
import 'package:release_app/src/components/Approve/BankCardValiPage.dart';
import 'package:release_app/src/components/Approve/ContactsPage.dart';
import 'package:release_app/src/components/Approve/JobInfoPage.dart';

/**
 * Created by zgx on 2017/5/25.
 * 个人信息认证
 */

class PersonalInfo extends StatefulWidget {
  PersonalInfo({Key key}) : super(key: key);

  @override
  _PersonalInfoState createState() => new _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool _autovalidate = false;
  final DatabaseReference _rootRef = FirebaseDatabase.instance.reference();

  String _userid;

  bool _saveNeeded = false;
  String _education = '';
  String _marriage = '';
  String _childencount = '';
  String _livetime = '';

  Jobinfo _jobinfo;
  Contacts _contactsinfo;
  BankCard _bankcard;
  List<Map<String, String>> _contacts = [];
  List<Map<String, String>> _bankcards = [];

  List<DialogItemValue> _educations = educations;
  List<DialogItemValue> _marriages = marriages;
  List<DialogItemValue> _childencounts = childencounts;

  StreamSubscription _infoSubscription;

  static TextEditingController _qqController;
  static TextEditingController _emailController;
  static TextEditingController _addressController;

  List<TextEditingController> _controllers = <TextEditingController>[
    null,
    null,
    null
  ];

//  String kTestString = 'Hello world';

  @override
  void initState() {
    super.initState();
    initValiable();
  }

  Future<bool> _onWillPop() async {
    if (!_saveNeeded) return true;

    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle =
        theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);

    return await showDialog<bool>(
            context: context,
            child: defaultTargetPlatform == TargetPlatform.iOS
                ? new CupertinoAlertDialog(
                content: new Text('放弃此次修改?', style: dialogTextStyle),
                actions: <Widget>[
                  new CupertinoButton(
                      child: const Text('取消'),
                      onPressed: () {
                        Navigator.of(context).pop(
                            false); // Pops the confirmation dialog but not the page.
                      }),
                  new CupertinoButton(
                      child: const Text('放弃'),
                      onPressed: () {
                        Navigator.of(context).pop(
                            true); // Returning true to _onWillPop will pop again.
                      })
                ])
                : new AlertDialog(
                content: new Text('放弃此次修改?', style: dialogTextStyle),
                actions: <Widget>[
                  new FlatButton(
                      child: const Text('取消'),
                      onPressed: () {
                        Navigator.of(context).pop(
                            false); // Pops the confirmation dialog but not the page.
                      }),
                  new FlatButton(
                      child: const Text('放弃'),
                      onPressed: () {
                        Navigator.of(context).pop(
                            true); // Returning true to _onWillPop will pop again.
                      }),
                  new FlutterLogo()
                ])) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    void showDemoDialog<T>({BuildContext context, int index, Widget child}) {
      showDialog<DialogItemValue>(
        context: context,
        child: child,
      ).then<Null>((DialogItemValue value) {
        // The value passed to Navigator.pop() or null.
//        print('序号:' + index.toString() + '返回数据:' + value);
        setState(() {
          if (value != null) {
            _saveNeeded = true;
            switch (index) {
              case 0:
                _education = value.text;
                break;
              case 1:
                _marriage = value.text;
                break;
              case 2:
                _childencount = value.text;
                break;
              case 3:
                _livetime = value.text;
                break;
            }
          }
        });
      });
    }

    Widget _textInputItem(
        String label, String hintText, TextInputType inputType, int i) {
      return new Container(
        padding: const EdgeInsets.only(left: 16.0),
        color: Colors.white,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(label),
              flex: 1,
            ),
            new Expanded(
              flex: 3,
              child: new TextFormField(
                decoration: new InputDecoration(
                  hideDivider: true,
                  hintText: hintText,
                ),
                controller: _controllers[i] != null ? _controllers[i] : null,
                keyboardType: inputType,
              ),
            ),
          ],
        ),
      );
    }

    Widget _dropdownInputItem(String label, int index, List<DialogItemValue> values) {
      return new InkWell(
        onTap: () {
          showDemoDialog<String>(
            context: context,
            index: index,
            child: new BottomModelDiolog(title: '请选择${label}' ,values: values,)
          );
        },
        child: new Container(
          color: Colors.white,
          height: 45.0,
            padding: const EdgeInsets.only(left: 16.0),
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
                    ? new Text(_education)
                    : index == 1
                        ? new Text(_marriage)
                        : index == 2
                            ? new Text(_childencount)
                            : index == 3 ? new Text(_livetime) : null,
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

    Widget _iconButtonItem(String label, Icon icon, int index) {
      return new InkWell(
        onTap: () {
          switch (index) {
            case 0:
              Navigator
                  .push(
                      context,
                      new MaterialPageRoute<Jobinfo>(
                        builder: (BuildContext context) =>
                            new JobInfoPage(_jobinfo),
                        fullscreenDialog: true,
                      ))
                  .then((job) {
                if (job != null) {
                  setState(() {
                    _jobinfo = job;
                  });
                }
              });
              break;
            case 1:
              Navigator
                  .push(
                      context,
                      new MaterialPageRoute<Contacts>(
                        builder: (BuildContext context) =>
                            new ContactsInfoPage(_contactsinfo),
                        fullscreenDialog: true,
                      ))
                  .then((contacts) {
                if (contacts != null) {
                  setState(() {
                    _contactsinfo = contacts;
                  });
                }
              });
              break;
            case 2:
              Navigator
                  .push(
                  context,
                  new MaterialPageRoute<BankCard>(
                    builder: (BuildContext context) =>
                    new BankCardValidPage(_bankcard),
                    fullscreenDialog: true,
                  ))
                  .then((bankcard) {
                if (bankcard != null) {
                  setState(() {
                    _bankcard = bankcard;
                  });
                }
              });
              break;
          }
        },
        child: new Container(
          height: 45.0,
          child: new Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Expanded(
                flex: 1,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    icon,
                  ],
                ),
              ),
              new Expanded(
                flex: 3,
                child: new Text(label),
              ),
              new Expanded(
                flex: 3,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Icon(
                      Icons.keyboard_arrow_right,
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
//      backgroundColor: Colors.grey.shade100,
      appBar: new AppBar(
        title: const Text('个人信息认证'),
        centerTitle: true,
      ),
      body: new Form(
          key: _formKey,
          onWillPop: _onWillPop,
          child: new ListView(children: <
              Widget>[
            new Container(
              decoration: new BoxDecoration(
                  border: new Border(
                      bottom: new BorderSide(
                          width: 1.0, color: theme.dividerColor))),
              child: new Column(
                children: <Widget>[
                  _textInputItem('QQ', '请输入QQ号码', TextInputType.number, 0),
                  new Divider(height: 1.0, indent: 16.0,),
                  _textInputItem('电子邮箱', '输入电子邮箱', TextInputType.emailAddress, 1),
                  new SizedBox(height: 16.0,),
                  _dropdownInputItem('学历', 0, educations),
                  new SizedBox(height: 16.0,),
                  _dropdownInputItem('婚姻', 1, marriages),
                  new Divider(height: 1.0, indent: 16.0,),
                  _dropdownInputItem('子女个数', 2, childencounts),
                  new SizedBox(height: 16.0,),
                  _textInputItem('常住地址', '请输入常住地址', TextInputType.text, 2),
                  new Divider(height: 1.0, indent: 16.0,),
                  _dropdownInputItem('居住时长', 3, liveTimes),
                ],
              ),
            ),
            new SizedBox(height: 16.0,),
            new Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: 16.0),
              child: new Column(
                children: <Widget>[
                  _iconButtonItem(
                      '职业信息',
                      new Icon(
                        Icons.work,
                        color: theme.primaryColor,
                      ),
                      0),
                  new Divider(),
                  _iconButtonItem(
                      '紧急联系人',
                      new Icon(
                        Icons.contact_phone,
                        color: theme.primaryColor,
                      ),
                      1),
                  new Divider(),
                  _iconButtonItem(
                      '银行卡信息',
                      new Icon(
                        Icons.credit_card,
                        color: theme.primaryColor,
                      ),
                      2),
                ],
              ),
            ),
            new Container(
              margin: const EdgeInsets.only(top: 15.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              child: new RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  _handleSubmit();
                },
                child: const Text('提交'),
              ),
            ),
          ])),
    );
  }

  void _handleClick(BuildContext context, int i) {}

  _handleSubmit() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidate = true;
    } else {
      /**
       * TODO 添加部分检查逻辑
       */


      /**
       * TODO 后面将扩展支持提交多份信息(如:联系人/银行卡等)
       */
      /**
       * 更新数据库
       */
      await _rootRef.child('person_info').child(_userid).set({
        "qq": _controllers[0].value.text,
        "email": _controllers[1].value.text,
        "address": _controllers[2].value.text,
        "education": _education,
        "livetime": _livetime,
        "childCount": _childencount,
        "marriage": _marriage,
        "job": {
          'job': _jobinfo.job,
          'monIncome': _jobinfo.monIncome,
          'compName': _jobinfo.compName,
          'cities': _jobinfo.cities,
          'compAdd': _jobinfo.compAdd,
          'compPhone': _jobinfo.compPhone,
        },
        "contacts": {
          'contact1': {
            'type': _contactsinfo.type1,
            'phoneNo': _contactsinfo.phoneNo1
          },
          'contact2': {
            'type': _contactsinfo.type2,
            'phoneNo': _contactsinfo.phoneNo2
          }
        },
        "bankcards":{
          "openBank":_bankcard.openBank,
          "opencity":_bankcard.opencity,
          "phoneNo":_bankcard.phoneNo,
          "cardNo":_bankcard.cardNo,
        }
      }).then((v) {
        setState(() {
          _saveNeeded = false;
        });
        _rootRef.child('person_info/${_userid}/checkStatus').set(1);
        Navigator.pop(context, true);
      }, onError: () {
        /**
         * 更新失败
         */
        Navigator.pop(context, false);
      });
    }
  }

  //新起一个线程获取登录用户认证信息
  initValiable() async {
//    await Firebaseui.currentUser.then((user) {
    await getFirebaseUser().then((user) {
      if(user==null){
        return;
      }
      _userid = user.uid;
      _infoSubscription = _rootRef
          .child('person_info')
          .child(_userid)
          .onValue
          .listen((Event event) {
        setState(() {
          Map<String, dynamic> maps = event.snapshot.value;
          print('返回数据：${maps}');
          if(maps == null){
            return;
          }
          setState(() {
            print('开始setState....');
            _qqController =
                new TextEditingController(text: maps != null ? maps['qq'] : '');
            _emailController = new TextEditingController(
                text: maps != null ? maps['email'] : '');
            _addressController = new TextEditingController(
                text: maps != null ? maps['address'] : '');
            _controllers[0] = _qqController;
            _controllers[1] = _emailController;
            _controllers[2] = _addressController;
            print('结束setState....');
          });
          _education = (maps != null ? maps['education']!= null ?maps['education']:'' : '');
          _livetime = (maps != null ? maps['livetime']!= null ?maps['livetime']:''  : '');
          _childencount = (maps != null ? maps['childCount']!= null ?maps['childCount']:''  : '');
          _marriage = (maps != null ? maps['marriage']!= null ?maps['marriage']:''  : '');

          /**
           * 职业
           */
          Map<String, String> job = maps != null ? maps['job'] : null;
          if (job == null) {
            _jobinfo = new Jobinfo('', '', '', '', '', '');
          } else {
            _jobinfo = new Jobinfo(
                job['job'],
                job['monIncome'],
                job['compName'],
                job['cities'],
                job['compAdd'],
                job['compPhone']);
          }
          /**
           * 紧急联系人
           */
          Map<String, Map<String, dynamic>> contacts = maps!=null?maps['contacts']:null;
          if(contacts==null){
            _contactsinfo = new Contacts('','','','');
          }else{
            _contactsinfo = new Contacts(
              contacts['contact1']['type'],
              contacts['contact1']['phoneNo'],
              contacts['contact2']['type'],
              contacts['contact2']['phoneNo']
            );
          }
          /**
           * 银行卡
           */
          Map<String, String> cards = maps!=null?maps['bankcards']:null;
          if(cards==null){
            _bankcard = new BankCard('','','','');
          }else{
            _bankcard = new BankCard(
                cards['openBank'],
                cards['opencity'],
                cards['phoneNo'],
                cards['cardNo']
            );
          }
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _infoSubscription.cancel();
  }
}


