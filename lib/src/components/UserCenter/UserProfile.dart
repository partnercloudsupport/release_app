import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:release_app/src/comm/Colors.dart';

/**
 * Created by zgx on 2017/6/9.
 * 个人资料
 */
class UserProfile extends StatefulWidget {
  UserProfile({Key key}) : super(key: key);

  @override
  _UserProfileState createState() => new _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final TextStyle labelStyle = new TextStyle(fontSize: 16.0);
  final TextStyle highStyle =
  new TextStyle(fontSize: 16.0, color: AppColors.primary);

  final TextStyle infoStyle =
  new TextStyle(fontSize: 16.0, color: AppColors.bankCardTextCorlor);


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('个人资料'),
        centerTitle: true,
        actions: <Widget>[
          new CupertinoButton(
            child: new Text(
              '修改',
              style: new TextStyle(color: Theme
                  .of(context)
                  .buttonColor),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/message');
            },
          ),
        ],
      ),
      body: new Container(
        padding: const EdgeInsets.all(8.0),
        child: new Column(
          children: <Widget>[
            new Card(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Container(
                    height: 48.0,
                    padding:
                    const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
//                    margin: const EdgeInsets.only(
//                        top: 8.0, bottom: 8.0, left: 2.0, right: 2.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          '手机号码',
                          style: labelStyle,
                        ),
                        new Text(
                          '1325465464',
                          style: highStyle,
                        ),
                        new InkWell(
                          child: new Row(
                            children: <Widget>[
                              const Text('注销'),
                              new Icon(
                                Icons.chevron_right,
                                size: 24.0,
                                color: AppColors.primary,
                              )
                            ],
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    height: 48.0,
                    padding:
                    const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          '职业',
                          style: labelStyle,
                        ),
                        new Text(
                          '产品经理',
                          style: labelStyle,
                        ),
                        new Container(width: 20.0,),
                      ],
                    ),
                  ),
                  new Container(
                    height: 48.0,
                    padding:
                    const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          '收入水平',
                          style: labelStyle,
                        ),
                        new Text(
                          '1325465464',
                          style: highStyle,
                        ),
                        new Container(width: 40.0,),
                      ],
                    ),
                  ),
                  new Container(
                    height: 48.0,
                    padding:
                    const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          '亲属联系方式',
                          style: labelStyle,
                        ),
                        new Text(
                          '1325465464',
                          style: highStyle,
                        ),
                        new Container(width: 40.0,),
                      ],
                    ),
                  ),
                  new Container(
                    height: 48.0,
                    padding:
                    const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          '朋友联系方式',
                          style: labelStyle,
                        ),
                        new Text(
                          '1325465464',
                          style: highStyle,
                        ),
                        new Container(width: 40.0,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              height: 100.0,
              child: new InkWell(
                onTap: (){},
                child: new Card(
                  color: AppColors.primary.shade400,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Icon(Icons.account_circle, size: 48.0,),
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text('身份证好  43***********2718', style: infoStyle,),
                          new Text('真实姓名  **李', style: infoStyle),
                        ],
                      ),
                      const Icon(Icons.check_circle_outline, size: 48.0,)
                    ],
                  ),
                ),
              ),
            ),
            new Container(
              height: 100.0,
              child: new InkWell(
                onTap: (){},
                child: new Card(
                  color: AppColors.bankCardCorlor,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Icon(Icons.credit_card, size: 48.0,),
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text('银行名称  工商银行', style: infoStyle,),
                          new Text('银行卡号  ***********8878', style: infoStyle),
                        ],
                      ),
                      const Icon(Icons.check_circle_outline, size: 48.0,)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
