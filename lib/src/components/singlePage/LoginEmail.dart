import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:release_app/src/comm/Colors.dart';

/**
 * Created by zgx on 2017/5/24.
 */

final FirebaseAuth auth = FirebaseAuth.instance;

class LoginEmail extends StatefulWidget {
  @override
  _LoginEmailState createState() => new _LoginEmailState();
}

class UserData {
  String phoneno = '';
  String password = '';
  String confirmpassword = '';
}

class _LoginEmailState extends State<LoginEmail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController _phoneController = new TextEditingController();

  UserData user = new UserData();

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  bool _isLogining = false;

  void showInSnackBar(String s) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(s)));
  }

  String _email;
  String _password;
  String _errmessage;

  bool _autovalidate = false;
  bool _formWasEdited = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _handleSubmitted() async {
      setState(() {
        _isLogining = true;
      });
      final FormState form = _formKey.currentState;
      if (!form.validate()) {
        _autovalidate = true; // Start validating on every change.
        setState((){_isLogining = false;});
//        showInSnackBar('请按照提示修改输入内容.');
        return false;
      } else {
        form.save(); //可以由此保存state
//      showInSnackBar('${user.phoneno}\'s phone number is ${user.phoneno}');
        //匿名登录
        FirebaseUser firebaseUser = auth.currentUser;
        if (firebaseUser == null) {
          print('loging......');
//          user = await auth.signInAnonymously(); //匿名登录
          try {
            firebaseUser = await auth.signInWithEmailAndPassword(
                email: _email, password: _password);
          } catch (e) {
            print(e.message);
            setState(() {_isLogining = false;_errmessage=e.message;});
            return false;
          }
          print('loging call complete...');
        }
        setState(() {_isLogining = false;});
        return auth.currentUser!= null;
        //邮箱密码登录
//        FirebaseUser user = auth
      }
//      return user != null;
    }

    return new Scaffold(
//      key: _scaffoldKey,
      appBar: new AppBar(
        title: const Text('登录'),
        centerTitle: true,
      ),

      body: new Form(
        key: _formKey,
        autovalidate: _autovalidate,
        child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              new Container(
                child: new TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.email),
                    hintText: '请输入邮箱地址',
                    labelText: '邮箱地址',
                  ),
                  keyboardType: TextInputType.text,
//                  onSaved: (String value) {
//                    //form.save时才会调用
//                    user.phoneno = value;
//                  },
//                  inputFormatters: [
//                    WhitelistingTextInputFormatter.digitsOnly,
//                  ],
                  validator: _validateEmailAddress,
                  controller: _emailController,
                  onSaved: (email) {
                    setState(() {
                      _email = email;
                    });
                  },
                ),
              ),
              new TextFormField(
                decoration: const InputDecoration(
                    icon: const Icon(Icons.keyboard),
                    hintText: '请输入登录密码',
                    labelText: '密码'),
                obscureText: true,
                validator: _validatePassword,
                controller: _passwordController,
                onSaved: (pass) {
                  setState(() {
                    _password = pass;
                  });
                },
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Container(
                    child: new InkWell(
                      onTap: () {},
                      child: const Text('忘记密码?'),
                    ),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  new Container(
                    child: new InkWell(
                      onTap: () {},
                      child: const Text('注册'),
                    ),
                  ),
                ],
              ),
              new Container(
                padding: const EdgeInsets.all(20.0),
                child: new RaisedButton(
                  onPressed: () {
                    print('before press login');
                    _handleSubmitted().then((status) {
                      print('返回状态：' + status.toString());
                      if (status) {
                        print('登录成功.....');
//                        showDialog(
//                            context: context,
//                            child: new AlertDialog(
//                              title: const Text('提示'),
//                                content: new Text('登录成功!'),
//                                actions: <Widget>[
//                                  new FlatButton(
//                                      child: const Text('OK'),
//                                      onPressed: () {
//                                        Navigator.of(context).pop(
//                                            false); // Pops the confirmation dialog but not the page.
//                                      }),
//                                ])) ??
//                            false;
                        Navigator.pop(context, auth.currentUser);
                      } else
                        showDialog(
                                context: context,
                                child: new AlertDialog(
                                    title: const Text('提示'),
                                    content: new Text('登录失败!'+_errmessage),
                                    actions: <Widget>[
                                      new FlatButton(
                                          child: const Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop(
                                                false); // Pops the confirmation dialog but not the page.
                                            setState((){_errmessage='';});
                                          }),
                                    ])) ??
                            false;
                    });
                    print('after press login');
                  },
                  child: const Text('登录'),
                ),
              ),
              new FlutterLogo(
                size: 100.0,
                colors: AppColors.primary,
              ),
              new Align(),
              new Center(
                child: _isLogining ? new CircularProgressIndicator() : null,
              ),
              new Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new IconButton(
                      onPressed: (){
                        _handleGoogleSingn();
                      },
                      icon: new ImageIcon(new AssetImage('images/Google.png'),color: Colors.blue,),
                    ),
                    new IconButton(
                      onPressed: (){},
                      icon: new ImageIcon(new AssetImage('images/Facebook.png'),color: Colors.black,),
                    ),
                    new IconButton(
                      onPressed: (){},
                      icon: new ImageIcon(new AssetImage('images/wechat.png'),color: Colors.green,),
                    ),
                  ],
                ),
              ),
            ]),
      ),

      //旧版本
//      body: new Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: [
//          new Form(
//            key: _formKey,
//            autovalidate: false,
//            child: null,

//            child: new ListView(
//              padding: const EdgeInsets.symmetric(horizontal: 16.0),
//              children: [
//                new TextFormField(
//                    decoration: const InputDecoration(
//                      icon: const Icon(Icons.phone_iphone),
//                      hintText: '请输入手机号码',
//                    ),
//                    keyboardType: TextInputType.phone,
//                    onSaved: (String value) {
//                      user.phoneno = value;
//                    },
////                    validator: _validatePhoneNumber,
//                    inputFormatters: <TextInputFormatter>[
//                      WhitelistingTextInputFormatter.digitsOnly, //仅仅允许输入数字
//                      //亦可添加格式化定义方法，继承自TextInputFormatter即可
//                    ],
//                ),
//                new TextFormField(
//                  decoration: const InputDecoration(
//                    icon: const Icon(Icons.keyboard),
//                    hintText: '请输入登录密码',
//                  ),
//                  obscureText: true,
//                  onSaved: (String value){user.password = value;},
//                  validator: _validatePassword,
//                ),
//              ],
//            ),
//          ),
//          new Image.asset('images/ic_center_more_icon.png', width: 200.0, height: 200.0),
//        ],
//      ),
    );
  }

  _handleGoogleSingn() async {
    GoogleSignIn _googleSignIn = new GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    await auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    Navigator.pop(context, auth.currentUser);
  }

  String _validateEmailAddress(String value) {
    _formWasEdited = true;
    if (value.length == 0) {
      return '请输入邮箱地址';
    }
//    final RegExp phoneExp = new RegExp(r'^\(\d\d\d\) \d\d\d\-\d\d\d\d$');
    print('手机号是:' + value);
    final RegExp emailExp =
        new RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)");
    if (!emailExp.hasMatch(value)) return '请检查邮箱地址格式.';
    return null;
  }

  String _validatePassword(String value) {
    if (value.length == 0) {
      return '请输入密码';
    }
    return null;
  }
}
