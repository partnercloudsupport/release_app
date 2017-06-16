import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseui/firebaseui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:release_app/src/comm/Colors.dart';
import 'package:release_app/src/components/UserCenter/GiftPage.dart';
import 'package:release_app/src/components/UserCenter/TestPage.dart';
import 'package:release_app/src/components/UserCenter/UserProfile.dart';
import 'package:release_app/src/components/singlePage/Login.dart';
import 'package:release_app/src/components/Usercenter/LoginEmail.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final googleSignIn = new GoogleSignIn();

class UserCenter extends StatefulWidget {
  UserCenter({Key key}) : super(key: key);

  @override
  _UserCenter createState() => new _UserCenter();
}

class _UserCenter extends State<UserCenter> {
  UiFirebaseUser _uiuser;
  FirebaseUser _user;
  bool _islogin = false;
  String _userName = '';
  String _photoUrl;

  @override
  Widget build(BuildContext context) {
    Widget _itemLine(String lable, IconData icon, int index) {
      return new Container(
        color: Colors.white,
          height: 45.0,
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: new InkWell(
            onTap: () {
              _handleClick(context, index);
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
                    child: const Icon(Icons.keyboard_arrow_right),
                  ),
                ),
              ],
            ),
          ));
    }

    return new Scaffold(
      appBar: new AppBar(
        title: const Text('现金口贷'),
      ),
      body: new ListView(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
        children: [
          new Container(
//            height: 200.0,
//          color: Theme.of(context).primaryColor,
//          padding: const EdgeInsets.only(top: 16.0),
            child: new Column(
              children: <Widget>[
                new Container(
                  color: Colors.white,
                    alignment: FractionalOffset.center,
                  padding: const EdgeInsets.only(bottom: 10.0, left: 10.0),
                  height: 100.0,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Expanded(
                        flex: 1,
                        child: new InkWell(
                          child: new Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                image: (_photoUrl == null)
                                    ? const AssetImage(
                                    'images/Google.png') //登录后可替换为头像，待完善
                                    : new NetworkImage(_photoUrl),
                              ),
                            ),
                          ),
                          onTap: () {
                            print(_uiuser);
                            if (_uiuser != null) {
                              showDialog(
                                context: context,
                                child: defaultTargetPlatform == TargetPlatform.iOS
                                    ? new CupertinoAlertDialog(
                                  title: const Text('提示'),
                                  content: new Text('你好:' + _userName),
                                )
                                    : new AlertDialog(
                                  content: new Text('您已登录:' + _userName),
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
                          },
                        ),
                      ),
                      new Expanded(
                        flex: 3,
                        child: new Container(
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                _uiuser == null ? '  ' : '您好',
                                style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                              ),
                              new Text(
                                _uiuser == null ? '  ' : '手机号:${_userName}',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
//                new Container(
//                  height: 60.0,
//                  decoration: new BoxDecoration(
//                    border: new Border.all(
//                        width: 1.0, color: Theme.of(context).dividerColor),
//                  ),
//                  child: new Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: <Widget>[
//                      new Flexible(
//                        child: new Container(
//                          alignment: FractionalOffset.center,
//                          decoration: new BoxDecoration(
//                            border: new Border(
//                                right: const BorderSide(
//                                    color: Colors.grey, width: 1.0)),
//                          ),
//                          child: new Row(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//                              new Column(
//                                mainAxisAlignment: MainAxisAlignment.center,
//                                children: [
//                                  new Text('525.00',
//                                      style: new TextStyle(
//                                          fontSize: Theme
//                                              .of(context)
//                                              .primaryTextTheme
//                                              .title
//                                              .fontSize,
//                                          color: AppColors.primary)),
//                                  new Text('待还金额'),
//                                ],
//                              ),
//                              new Text('元')
//                            ],
//                          ),
//                        ),
//                      ),
//                      new Flexible(
//                        child: new InkWell(
////                          splashColor: Colors.black,
//                            onTap: () {
//                              _handleClick(context, 0);
//                            },
//                            child: new Container(
//                              alignment: FractionalOffset.center,
//                              decoration: new BoxDecoration(
//                                border: new Border(
//                                    right: const BorderSide(
//                                        color: Colors.grey, width: 1.0)),
//                              ),
//                              child: new Row(
//                                mainAxisAlignment: MainAxisAlignment.center,
//                                crossAxisAlignment: CrossAxisAlignment.center,
//                                children: <Widget>[
//                                  new Column(
//                                    mainAxisAlignment: MainAxisAlignment.center,
//                                    children: [
//                                      new Text('1',
//                                          style: new TextStyle(
//                                              fontSize: Theme
//                                                  .of(context)
//                                                  .primaryTextTheme
//                                                  .title
//                                                  .fontSize,
//                                              color: AppColors.primary)),
//                                      new Text('需还贷款'),
//                                    ],
//                                  ),
//                                  new Text('笔')
//                                ],
//                              ),
//                            )),
//                      ),
//                      new Flexible(
//                        child: new InkWell(
//                          onTap: () {
//                            _handleClick(context, 2);
//                          },
//                          child: new Container(
//                            alignment: FractionalOffset.center,
//                            decoration: new BoxDecoration(
//                              border: new Border(
//                                  right: new BorderSide(
//                                      color: Theme.of(context).dividerColor,
//                                      width: 1.0)),
//                            ),
//                            child: new Row(
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              crossAxisAlignment: CrossAxisAlignment.center,
//                              children: <Widget>[
//                                new Column(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  children: [
//                                    new Text('3',
//                                        style: new TextStyle(
//                                            fontSize: Theme
//                                                .of(context)
//                                                .primaryTextTheme
//                                                .title
//                                                .fontSize,
//                                            color: AppColors.primary)),
//                                    new Text('我的卡券'),
//                                  ],
//                                ),
//                                new Text('张')
//                              ],
//                            ),
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
              ],
            ),
          ),
          new Container(
              margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              height: 50.0,
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: new BoxDecoration(
                color: Colors.white,
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
                    new Icon(
                      Icons.attach_money,
                      color: Theme.of(context).primaryColor,
                    ),
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
//            decoration: new BoxDecoration(
//              border: new Border.all(
//                  width: 1.0, color: Theme.of(context).dividerColor),
//            ),
            child: new Column(
              children: [
                new Divider(),
                _itemLine('帮助中心', Icons.lightbulb_outline, 0),
                _itemLine('个人资料', Icons.info, 1),
//                new Divider(),
                _itemLine('我的卡券', Icons.card_giftcard, 2),
//                new Divider(height: 1.0, indent: 40.0),
                _itemLine('邀请好友', Icons.person_add, 3),
//                new Divider(height: 1.0, indent: 40.0),
                _itemLine('设置', Icons.settings, 4),
//                new Divider(height: 1.0, indent: 40.0),
                _islogin ? _itemLine('退出', Icons.all_out, 5) : new Align(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initUser();
  }

  _initUser() async {
    try {
      UiFirebaseUser user = await Firebaseui.currentUser;
      if (user != null) {
        setState(() {
          _uiuser = user;
          _islogin = true;
          if (user.providerData.length > 1) {
            _userName = user.providerData[1].displayName;
            _photoUrl = user.providerData[1].photoUrl;
          } else {
            _userName = user.displayName;
            _photoUrl = user.photoUrl;
          }
        });
      } else {
        setState(() {
          _islogin = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        _islogin = false;
      });
    }
  }

  Future<Null> _doLogin() async {
    await Navigator
        .push(
            context,
            new MaterialPageRoute<FirebaseUser>(
              builder: (BuildContext context) => new LoginEmail(),
//              fullscreenDialog: false,
            ))
        .then((user) {
      if (user != null) {
        _initUser();
        print(user);
//        if (user != null) {
//          setState(() {
//            _uiuser = user;
//            _islogin = true;
//            if (user.providerData.length > 1) {
//              _userName = user.providerData[1].displayName;
//              _photoUrl = user.providerData[1].photoUrl;
//            } else {
//              _userName = user.displayName;
//              _photoUrl = user.photoUrl;
//            }
//          });
//        } else {
//          setState(() {
//            _islogin = false;
//          });
//        }
      }
    });
//    try {
//      String name = await Firebaseui.signin;
//      _initUser();
//    }catch(e){
//      print(e.message);
//    }
  }

  _dosave(user) async {
    setState(() {
      _uiuser = user;
    });
    bool _saveStaus = await _saveUserInterface();
    print("保存数据成功：" + _saveStaus.toString());
  }

  Future<Null> _getUserInterface() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print("获取保存的user uid:" + prefs.getString('userUid'));
    } catch (e) {
      print(e);
    }
  }

  _handleClick(BuildContext context, int index) async {
//    await Firebaseui.signinstatus;
//    if(!await Firebaseui.signinstatus){
    if (_uiuser == null) {
      showDialog(
        context: context,
        child: defaultTargetPlatform == TargetPlatform.iOS
            ? new CupertinoAlertDialog(
                title: const Text('提示'),
                content: const Text('请先点击头像登录'),
                actions: [
                  new CupertinoButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                  ),
                ],
              )
            : new AlertDialog(
                title: const Text('提示'),
                content: const Text('请先点击头像登录'),
                actions: [
                  new FlatButton(
                    child: const Text('OK'),
                    onPressed: () {
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
//        Navigator.pushNamed(context, '/borrowRecord');
        Navigator.push(
            context,
            new MaterialPageRoute<Null>(
              builder: (BuildContext context) => new UserProfile(),
            ));
        break;
      case 2:
        Navigator.push(
            context,
            new MaterialPageRoute<Null>(
              builder: (BuildContext context) => new GiftPage(),
            ));
        break;
      case 3:
//        Navigator.pushNamed(context, '/borrowRecord');
      Navigator.push(context, new MaterialPageRoute<Null>(
        builder: (BuildContext context)=> new TestPage(),
      ));
        break;
      case 4:
        Navigator.pushNamed(context, '/borrowRecord');
        break;
      case 5:
        _signout();
        break;
    }
  }

  Future<Null> _handleSubmitted() async {
    GoogleSignInAccount account = googleSignIn.currentUser;
    if (account == null) account = await googleSignIn.signInSilently();
    if (account == null) await googleSignIn.signIn();
  }

  Future<bool> _saveUserInterface() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userUid', _uiuser.uid);
    return true;
  }

  void _showMessage(BuildContext context) {
    Navigator.of(context).pushNamed('/message');
  }

  _signout() async {
//    await Firebaseui.signout;
    await auth.signOut();
    setState(() {
      _uiuser = null;
      _islogin = false;
    });
  }
}
