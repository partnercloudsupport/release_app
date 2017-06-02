import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_auth/firebase_auth.dart';
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

  void showInSnackBar(String s) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(s)));
  }

  String _email;
  String _password;

  bool _autovalidate = false;
  bool _formWasEdited = false;


  @override
  void initState() {
    super.initState();
//    -_emailController.addListener();
  }

  @override
  Widget build(BuildContext context) {

    Future<bool> _handleSubmitted() async {

      final FormState form = _formKey.currentState;
      if (!form.validate()) {
        _autovalidate = true; // Start validating on every change.
        showInSnackBar('请按照提示修改输入内容.');
        return false;
      } else {
//        form.save();
//      showInSnackBar('${user.phoneno}\'s phone number is ${user.phoneno}');
      //匿名登录
//        FirebaseUser user = auth.currentUser;
//        if (user == null) {
//          print('loging......');
//          user = await auth.signInAnonymously();
//          print('loging call complete...');
//        }
      //邮箱密码登录
//        FirebaseUser user = auth
      }
    return user != null;
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
                    _handleSubmitted().then((status){
                      print('返回状态：'+ status.toString());
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

                      }
                      else
                        showDialog(
                            context: context,
                            child: new AlertDialog(
                                title: const Text('提示'),
                                content: new Text('登录失败!'),
                                actions: <Widget>[
                                  new FlatButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop(
                                            false); // Pops the confirmation dialog but not the page.
                                      }),
                                ])) ??
                            false;
                    });
                    print('after press login');
                  },
                  child: const Text('登录'),
                ),
              ),
              new FlutterLogo(size: 100.0,colors: AppColors.primary,),
              new Align(),
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

  String _validateEmailAddress(String value) {
    _formWasEdited = true;
    if(value.length == 0){
      return '请输入邮箱地址';
    }
//    final RegExp phoneExp = new RegExp(r'^\(\d\d\d\) \d\d\d\-\d\d\d\d$');
    print('手机号是:'+ value);
    final RegExp emailExp = new RegExp(
        r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)");
    if (!emailExp.hasMatch(value)) return '请检查邮箱地址格式.';
//    setState((){_email=value;});
    return null;
  }

  String _validatePassword(String value) {
    if (value.length == 0) {
      return '请输入密码';
    }
//    setState((){_password=value;});
    return null;
  }
}