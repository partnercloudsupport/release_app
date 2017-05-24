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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController _phoneController = new TextEditingController();

  UserData user = new UserData();

  void showInSnackBar(String s) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(content: new Text(s))
    );
  }

  void _handleSubmitted() {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidate = true;  // Start validating on every change.
      showInSnackBar('请按照提示修改输入内容.');
    } else {
//        form.save();
      showInSnackBar('${user.phoneno}\'s phone number is ${user.phoneno}');
    }
  }
  String userName;
  String password;

  bool _autovalidate = false;
  bool _formWasEdited = false;

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
//      key: _scaffoldKey,
      appBar: new AppBar(
        title: const Text('登录'),
        centerTitle: true,
      ),

      body: new Form(
        key: _formKey,
//        autovalidate: _autovalidate,
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
//                  onSaved: (String value) {
//                    //form.save时才会调用
//                    user.phoneno = value;
//                  },
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                  ],
                  validator: _validatePhoneNumber,
                ),
              ),
              new TextFormField(
                decoration: const InputDecoration(
                    icon: const Icon(Icons.keyboard),
                    hintText: '请输入登录密码',
                    labelText: '密码'),
//                onSaved: (String value) {
//                  user.phoneno = value;
//                },
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
//                  onPressed: (){},
                  onPressed: _handleSubmitted,
                  child: const Text('登录'),
                ),
              ),
              new Image.asset('images/ic_center_more_icon.png',
                  width: 150.0, height: 150.0),
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

  String _validatePhoneNumber(String value) {
    _formWasEdited = true;
    final RegExp phoneExp = new RegExp(r'^\(\d\d\d\) \d\d\d\-\d\d\d\d$');
    if (!phoneExp.hasMatch(value))
      return '(###) ###-#### - 请检查格式.';
    return null;
  }

  String _validatePassword(String value) {
    return null;
  }


}
