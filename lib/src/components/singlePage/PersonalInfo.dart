import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseui/firebaseui.dart';
import 'package:flutter/material.dart';
import 'package:release_app/src/comm/CommBin.dart';
import 'package:release_app/src/components/singlePage/BankCardValiPage.dart';
import 'package:release_app/src/components/singlePage/ContactsPage.dart';
import 'package:release_app/src/components/singlePage/JobInfoPage.dart';

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
//  String _qq = '';
//  String _email = '';
//  String _address = '';
  Jobinfo _jobinfo;
  Contacts _contactsinfo;
  BankCard _bankcard;
  List<Map<String, String>> _contacts = [];
  List<Map<String, String>> _bankcards = [];

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
            child: new AlertDialog(
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
                      })
                ])) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    void showDemoDialog<T>({BuildContext context, int index, Widget child}) {
      showDialog<String>(
        context: context,
        child: child,
      ).then<Null>((String value) {
        // The value passed to Navigator.pop() or null.
//        print('序号:' + index.toString() + '返回数据:' + value);
        setState(() {
          if (value != null) {
            _saveNeeded = true;
            switch (index) {
              case 0:
                _education = value;
                break;
              case 1:
                _marriage = value;
                break;
              case 2:
                _childencount = value;
                break;
              case 3:
                _livetime = value;
                break;
            }
          }
        });
      });
    }

    Widget _textInputItem(
        String label, String hintText, TextInputType inputType, int i) {
      return new Container(
//        height: 45.0,
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

    Widget _dropdownInputItem(String label, int index) {
      return new InkWell(
        onTap: () {
          showDemoDialog<String>(
            context: context,
            index: index,
            child: index == 0
                ? new EduDiolog()
                : index == 1
                    ? new MarriageDiolog()
                    : index == 2 ? new ChildenDiolog() : new LivetimeDiolog(),
          );
        },
        child: new Container(
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
      appBar: new AppBar(
        title: const Text('个人信息认证'),
        centerTitle: true,
      ),
      body: new Form(
          key: _formKey,
          onWillPop: _onWillPop,
          child: new ListView(padding: const EdgeInsets.all(16.0), children: <
              Widget>[
            new Container(
              decoration: new BoxDecoration(
                  border: new Border(
                      top:
                          new BorderSide(width: 1.0, color: theme.dividerColor),
                      bottom: new BorderSide(
                          width: 1.0, color: theme.dividerColor))),
              child: new Column(
                children: <Widget>[
                  _textInputItem('QQ', '请输入QQ号码', TextInputType.number, 0),
                  new Divider(),
                  _textInputItem('电子邮箱', '输入电子邮箱', TextInputType.text, 1),
                  new Divider(),
                  _dropdownInputItem('学历', 0),
                  new Divider(),
                  _dropdownInputItem('婚姻', 1),
                  new Divider(),
                  _dropdownInputItem('子女个数', 2),
                  new Divider(),
                  _textInputItem('常住地址', '请输入常住地址', TextInputType.text, 2),
                  new Divider(),
                  _dropdownInputItem('居住时长', 3),
                ],
              ),
            ),
            new Container(
              margin: const EdgeInsets.only(top: 20.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      top:
                          new BorderSide(width: 1.0, color: theme.dividerColor),
                      bottom: new BorderSide(
                          width: 1.0, color: theme.dividerColor))),
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
    await Firebaseui.currentUser.then((user) {
      _userid = user.uid;
      _infoSubscription = _rootRef
          .child('person_info')
          .child(_userid)
          .onValue
          .listen((Event event) {
        setState(() {
          Map<String, dynamic> maps = event.snapshot.value;
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
          _education = maps != null ? maps['education'] : '';
          _livetime = maps != null ? maps['livetime'] : '';
          _childencount = maps != null ? maps['childCount'] : '';
          _marriage = maps != null ? maps['marriage'] : '';
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

//'学历'弹出对话框
class EduDiolog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SimpleDialog(
      title: const Text('请选择学历'),
      children: <Widget>[
        new DialogItem(
          text: '小学',
          onPressed: () {
            Navigator.pop(context, '小学');
          },
        ),
        new DialogItem(
          text: '初中',
          onPressed: () {
            Navigator.pop(context, '初中');
          },
        ),
        new DialogItem(
          text: '高中',
          onPressed: () {
            Navigator.pop(context, '高中');
          },
        ),
        new DialogItem(
          text: '大学',
          onPressed: () {
            Navigator.pop(context, '大学');
          },
        ),
        new DialogItem(
          text: '研究生及以上',
          onPressed: () {
            Navigator.pop(context, '研究生及以上');
          },
        ),
      ],
    );
  }
}

//'婚姻'弹出对话框
class MarriageDiolog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SimpleDialog(
      title: const Text('请选择婚姻状况'),
      children: <Widget>[
        new DialogItem(
          text: '未婚',
          onPressed: () {
            Navigator.pop(context, '未婚');
          },
        ),
        new DialogItem(
          text: '已婚',
          onPressed: () {
            Navigator.pop(context, '已婚');
          },
        ),
        new DialogItem(
          text: '离异',
          onPressed: () {
            Navigator.pop(context, '离异');
          },
        ),
      ],
    );
  }
}

//'子女数'弹出对话框
class ChildenDiolog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SimpleDialog(
      title: const Text('请选择子女个数'),
      children: <Widget>[
        new DialogItem(
          text: '0',
          onPressed: () {
            Navigator.pop(context, '0');
          },
        ),
        new DialogItem(
          text: '1',
          onPressed: () {
            Navigator.pop(context, '1');
          },
        ),
        new DialogItem(
          text: '2',
          onPressed: () {
            Navigator.pop(context, '2');
          },
        ),
      ],
    );
  }
}

//'居住时长'弹出对话框
class LivetimeDiolog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SimpleDialog(
      title: const Text('请选择居住时间'),
      children: <Widget>[
        new DialogItem(
          text: '三个月',
          onPressed: () {
            Navigator.pop(context, '三个月');
          },
        ),
        new DialogItem(
          text: '六个月',
          onPressed: () {
            Navigator.pop(context, '六个月');
          },
        ),
        new DialogItem(
          text: '一年',
          onPressed: () {
            Navigator.pop(context, '一年');
          },
        ),
      ],
    );
  }
}

class DialogItem extends StatelessWidget {
  const DialogItem({Key key, this.icon, this.color, this.text, this.onPressed})
      : super(key: key);

  final IconData icon;
  final Color color;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return new SimpleDialogOption(
      onPressed: onPressed,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
//          new Icon(icon, size: 36.0, color: color),
          new Padding(
            padding: const EdgeInsets.all(5.0),
//            padding: const EdgeInsets.only(left: 16.0),
            child: new Text(text),
          ),
        ],
      ),
    );
  }
}
