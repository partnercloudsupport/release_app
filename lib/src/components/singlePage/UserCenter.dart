import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:release_app/src/components/singlePage/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

final googleSignIn = new GoogleSignIn();
final FirebaseAuth auth = FirebaseAuth.instance;


class UserCenter extends StatefulWidget {
  UserCenter({Key key}) : super(key: key);

  @override
  _UserCenter createState() => new _UserCenter();
}

class _UserCenter extends State<UserCenter> {

  FirebaseUser _user;

  @override
  void initState() {
    super.initState();
    _user = auth.currentUser;
    _getUserInterface();
  }

  @override
  Widget build(BuildContext context) {
    Widget _itemLine(String lable, IconData icon, int index) {
      return new Container(
          height: 45.0,
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: new InkWell(
            onTap: () {
              _handleClick(context, index);
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
          height: 200.0,
          color: Theme.of(context).primaryColor,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                padding: const EdgeInsets.only(bottom: 10.0,left: 10.0),
                height: 150.0,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    new InkWell(
                      child: new Container(
                        height: 70.0,
                        width: 70.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            image: const AssetImage('images/ic_center_more_icon.png'),//登录后可替换为头像，待完善
                          ),
                        ),
                      ),
                      onTap: () {
                        print(_user);
                        if (_user != null) {
                          showDialog(
                            context: context,
                            child: defaultTargetPlatform == TargetPlatform.iOS
                                ? new CupertinoAlertDialog(
                                    title: const Text('提示'),
                                    content: new Text(
                                        '你好,UID:' + _user.uid),
                                  )
                                : new AlertDialog(
                                    content: new Text(
                                        '您已登录,UID:' + _user.uid),
                                    actions: <Widget>[
                                      new FlatButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pop(null);
                                        },
                                      ),
                                    ],
                                  ),
                          );
                        } else {
                          _doLogin();

                        }
//                        _handleSubmitted();
                      },
                    ),
                    new Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 5.0),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new Text(
                              _user==null?'  ':'您好',
                          ),
                          new Text(
                            _user==null?'  ':_user.uid,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                height: 50.0,
                decoration: new BoxDecoration(
                  border: new Border.all(
                      width: 1.0, color: Theme.of(context).dividerColor),
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
                              right: new BorderSide(
                                  color: Theme.of(context).dividerColor,
                                  width: 1.0)),
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
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            decoration: new BoxDecoration(
              border: new Border.all(
                  width: 1.0, color: Theme.of(context).dividerColor),
            ),
            child: new Container(
                child: new InkWell(
              onTap: () {
                _handleClick(context, 0);
              },
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  new Icon(Icons.attach_money, color: Theme.of(context).primaryColor,),
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
          decoration: new BoxDecoration(
            border: new Border.all(
                width: 1.0, color: Theme.of(context).dividerColor),
          ),
          child: new Column(
            children: [
              _itemLine('帮助中心', Icons.lightbulb_outline, 0),
              new Divider(height: 1.0, indent: 40.0),
              _itemLine('个人资料', Icons.info, 1),
              new Divider(height: 1.0, indent: 40.0),
              _itemLine('我的卡券', Icons.card_giftcard, 2),
              new Divider(height: 1.0, indent: 40.0),
              _itemLine('邀请好友', Icons.person_add, 3),
              new Divider(height: 1.0, indent: 40.0),
              _itemLine('设置', Icons.settings, 4),
            ],
          ),
        ),
      ],
    );
  }

  void _showMessage(BuildContext context) {
    Navigator.of(context).pushNamed('/message');
  }

  void _handleClick(BuildContext context, int index) {
    if(_user==null){
      showDialog(
        context: context,
        child: new AlertDialog(
          title: const Text('提示'),
          content: const Text('请先点击头像登录'),
          actions: [
            new FlatButton(
              child: const Text('OK'),
              onPressed: (){
                Navigator.pop(context, true);
              },
            ),
          ],
        ),
      );
      return;
    }
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/borrowRecord');
        break;
      case 1:
        Navigator.pushNamed(context, '/borrowRecord');
        break;
      case 2:
        Navigator.pushNamed(context, '/borrowRecord');
        break;
      case 3:
        Navigator.pushNamed(context, '/borrowRecord');
        break;
      case 4:
        Navigator.pushNamed(context, '/borrowRecord');
        break;
    }
  }

  Future<Null> _handleSubmitted() async {
    GoogleSignInAccount account = googleSignIn.currentUser;
    if (account == null) account = await googleSignIn.signInSilently();
    if (account == null) await googleSignIn.signIn();
  }

  Future<bool> _saveUserInterface() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userUid', _user.uid);
    return true;
  }

  Future<Null> _getUserInterface() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("获取保存的user uid:"+prefs.getString('userUid'));
  }

  Future<Null> _doLogin()async {
    FirebaseUser user = await Navigator.push(
        context,
        new MaterialPageRoute<FirebaseUser>(
          builder: (BuildContext context) => new Login(),
          fullscreenDialog: false,
        ));
    setState((){_user = user;});
    bool _saveStaus = await _saveUserInterface();
    print("保存数据成功："+ _saveStaus.toString());
  }

}
