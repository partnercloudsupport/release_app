import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**
 * Created by zgx on 2017/5/24.
 */
class Login extends StatefulWidget {
  @override
  _LoginState createState() => new _LoginState();
}

class UserData {
  String phoneno = '';
  String password = '';
  String confirmpassword = '';
}

class _LoginState extends State<Login> {
  String userName;
  String password;


  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
    TextEditingController _phoneController = new TextEditingController();

    UserData user = new UserData();

    return new Scaffold(
      appBar: new AppBar(
        title: const Text('登录'),
        centerTitle: true,
      ),

    body: new Form(
      child: new ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          new Container(
            child: new TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.phone_iphone),
                hintText: '请输入手机号码',
                labelText: '手机号码',
              ),
              keyboardType: TextInputType.number,
              onSaved: (String value) { //form.save时才会调用
                user.phoneno = value;
              },
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
              ],
            ),
//            decoration: new BoxDecoration(
//              border: new Border.all(width: 1.0,color: Theme.of(context).dividerColor)
//            ),
          ),

          new TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.keyboard),
              hintText: '请输入登录密码',
              labelText: '密码'
            ),
            keyboardType: TextInputType.number,
            onSaved: (String value) {
              user.phoneno = value;

            },
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
            ],
          ),

          new Container(
            padding: const EdgeInsets.all(20.0),
            child: new RaisedButton(
              onPressed: (){},
              child: const Text('登录'),
            ),
          ),
//          new TextField(
//            decoration: const InputDecoration(
//              icon: const Icon(Icons.phone_iphone),
//              hintText: '请输入手机号码'
//            ),
//          ),

          new Image.asset('images/ic_center_more_icon.png', width: 150.0, height: 150.0),
        ]
      ),
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

  String _validatePhoneNumber(String value) {
    return null;
  }

  String _validatePassword(String value) {
    return null;
  }
}
